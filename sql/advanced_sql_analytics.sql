/*
Advanced SQL and Analytics
1. For each course, calculate:
   a. Total number of enrolled users
   b. Total number of lessons
   c.  Average lesson duration
2. Identify the top three most active users based on total activity count.
3. Calculate course completion percentage per user based on lesson activity.
4. Find users whose average Assessment score is higher than the course average.
5. List courses where lessons are frequently accessed but Assessments are never attempted.
6. Rank users within each course based on their total assessment score.
7. Identify the first lesson accessed by each user for every course.
8. Find users with activity recorded on at least five consecutive days.
9. Retrieve users who enrolled in a course but never submitted any assessment.
10. List courses where every enrolled user has submitted at least one assessment.
*/


-- 1. For each course, calculate:
--    a. Total number of enrolled users
--    b. Total number of lessons
--    c. Average lesson duration
-- Why LEFT JOIN: We want to include courses even if no one is enrolled or there are no lessons.
-- COUNT(DISTINCT) avoids double-counting users or lessons due to joins.
-- CASE with COUNT prevents division by zero when calculating average lesson duration.
SELECT 
    c.course_id, 
    c.course_title, 
    COUNT(DISTINCT e.user_id) AS Number_of_Enrolled_Users, 
    COUNT(DISTINCT l.lesson_id) AS Number_of_Lessons,
    CASE
        WHEN COUNT(DISTINCT l.lesson_id) = 0 THEN 0
        ELSE c.course_duration * 1.0 / COUNT(DISTINCT l.lesson_id)
    END AS average_lesson_duration
FROM lms.Courses AS c
LEFT JOIN lms.Enrollments AS e
    ON c.course_id = e.course_id
LEFT JOIN lms.Lessons AS l
    ON l.course_id = c.course_id
GROUP BY c.course_id, c.course_title, c.course_duration;


-- 2.  Identify the top three most active users based on total activity count.
-- Why INNER JOIN: Only users with activity should be considered active.
-- COUNT(*) measures total activity events per user.
SELECT 
	TOP(3) u.user_id, 
	u.user_name, 
	COUNT(*) AS Number_of_activities
FROM lms.Users AS u
JOIN lms.User_Activity as ua  
ON u.user_id = ua.user_id
GROUP BY 
	u.user_id, 
	u.user_name
ORDER BY COUNT(*) DESC;
GO

-- 3. Calculate course completion percentage per user based on lesson activity.
-- Why LEFT JOIN: To count total lessons even if the user has no activity.
-- Completion percentage is calculated based on distinct lessons completed.
SELECT
	u.user_id,
	u.user_name,
	c.course_id,
	COUNT(DISTINCT l.lesson_id) AS total_lessons,
	COUNT(DISTINCT ua.lesson_id) AS lessons_completed,
	COALESCE((COUNT(DISTINCT ua.lesson_id)  * 100.0)/ NULLIF(COUNT(DISTINCT l.lesson_id), 0), 0 ) AS completion_percentage
FROM lms.Enrollments AS e
JOIN lms.Users AS u
   	ON u.user_id = e.user_id	
JOIN lms.Courses AS c
   	ON c.course_id = e.course_id	
LEFT JOIN lms.Lessons AS l
   	ON l.course_id = c.course_id	
LEFT JOIN lms.User_Activity AS ua
	ON ua.user_id = u.user_id
	AND ua.lesson_id = l.lesson_id
GROUP BY
	u.user_id,
	u.user_name,
	c.course_id
ORDER BY completion_percentage DESC;
GO

-- 4. Find users whose average Assessment score is higher than the course average.
-- Why CTEs: Separates course-level and user-level aggregation for clarity.
-- Assumption: Course average is calculated across all submissions in that course.
WITH course_avg AS (
    SELECT
        l.course_id,
        AVG(s.marks_scored * 1.0) AS AVG_Course_Score
    FROM lms.Assessment_Submission AS s
    JOIN lms.Assessments AS a
        ON a.assessment_id = s.assessment_id
    JOIN lms.Lessons AS l
        ON l.lesson_id = a.lesson_id
    GROUP BY l.course_id
),
user_avg AS (
    SELECT
        u.user_id,
        u.user_name,
        l.course_id,
        AVG(s.marks_scored * 1.0) AS AVG_User_Score
    FROM lms.Users AS u
    JOIN lms.Assessment_Submission AS s
        ON u.user_id = s.user_id
    JOIN lms.Assessments AS a
        ON a.assessment_id = s.assessment_id
    JOIN lms.Lessons AS l
        ON l.lesson_id = a.lesson_id
    GROUP BY u.user_id, u.user_name, l.course_id
)
SELECT
    ua.user_id,
    ua.user_name,
    ua.course_id,
    ua.AVG_User_Score,
    ca.AVG_Course_Score
FROM user_avg ua
JOIN course_avg ca
    ON ca.course_id = ua.course_id
WHERE ua.AVG_User_Score > ca.AVG_Course_Score;
GO

-- 5. List courses where lessons are frequently accessed but Assessments are never attempted.
-- ASSUMPTION: EXISTS ensures at least one activity on lesson. NOT EXISTS ensures no submissions exist for any lesson in the course.
SELECT DISTINCT
    c.course_id,
    c.course_title
FROM lms.Courses c
JOIN lms.Lessons l
    ON l.course_id = c.course_id
WHERE EXISTS (
    SELECT 1
    FROM lms.User_Activity ua
    WHERE ua.lesson_id = l.lesson_id
)
AND NOT EXISTS (
    SELECT 1
    FROM lms.Assessment_Submission s
    WHERE s.assessment_id IN (
        SELECT assessment_id 
        FROM lms.Assessments 
        WHERE lesson_id = l.lesson_id
    )
);
GO

-- 6. Rank users within each course based on their total assessment score.
-- Why LEFT JOIN: LEFT JOIN ensures users with no submissions appear with score 0.
-- DENSE_RANK allows ties in scores.
WITH UserCourseScores AS (
    SELECT
        s.user_id,
        l.course_id,
        SUM(s.marks_scored) AS total_assessment_score
    FROM lms.Assessment_Submission s
    JOIN lms.Assessments a
        ON a.assessment_id = s.assessment_id
    JOIN lms.Lessons l
        ON l.lesson_id = a.lesson_id
    GROUP BY
        s.user_id,
        l.course_id
)
SELECT
    u.user_id,
    u.user_name,
    c.course_title,
    COALESCE(ucs.total_assessment_score, 0) AS total_assessment_score,
    DENSE_RANK() OVER (
        PARTITION BY c.course_id
        ORDER BY COALESCE(ucs.total_assessment_score, 0) DESC
    ) AS rank_in_course
FROM lms.Enrollments e
JOIN lms.Users u
    ON u.user_id = e.user_id
JOIN lms.Courses c
    ON c.course_id = e.course_id
LEFT JOIN UserCourseScores ucs
    ON ucs.user_id = e.user_id
   AND ucs.course_id = e.course_id
ORDER BY
    c.course_id,
    rank_in_course;
GO

-- 7. Identify the first lesson accessed by each user for every course.
-- Using CTE : To group activities based on user names and assign row numbers to all the activities 
-- and ordering then in Ascending order.
-- Then the first row of all the user is where we can find the first user activity
WITH first_activity AS (
    SELECT
        ua.user_id,
        ua.lesson_id,
        ua.activity_date,
        ROW_NUMBER() OVER (
            PARTITION BY ua.user_id
            ORDER BY ua.activity_date ASC
        ) AS row_number
    FROM lms.User_Activity AS ua
)
SELECT 
	fa.user_id,
	u.user_name, 
	fa.lesson_id, 
	fa.activity_date
FROM first_activity AS fa
JOIN  lms.Users AS u
	ON u.user_id = fa.user_id
WHERE row_number = 1;

-- 8. Find users with activity recorded on at least five consecutive days.
-- Using CTE: To perform two operations seperately where we are first finding users with their activity dates.
-- Then in second CTE we are finding the streaks and then later checking which user has streak of more than 5 consecutive days.
WITH ActivityDates AS (
    SELECT DISTINCT
        user_id,
        CAST(activity_date AS DATE) AS activity_date
    FROM lms.User_Activity
),
Streaks AS (
    SELECT
        user_id,
        activity_date,
        DATEADD(
            DAY,
            -ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY activity_date),
            activity_date
        ) AS streak_group
    FROM ActivityDates
)
SELECT
    user_id,
    MIN(activity_date) AS streak_start,
    MAX(activity_date) AS streak_end,
    COUNT(*) AS consecutive_days
FROM Streaks
GROUP BY user_id, streak_group
HAVING COUNT(*) >= 5
ORDER BY user_id;
GO

-- 9. Retrieve users who enrolled in a course but never submitted any assessment.
-- NOT EXISTS: It ensures no submissions exist for any lesson of the course.
SELECT
    e.user_id,
    e.course_id
FROM lms.Enrollments AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM lms.Lessons AS l
	JOIN lms.Assessments AS a
		ON a.lesson_id = l.lesson_id
    JOIN lms.Assessment_Submission AS s
        ON s.assessment_id = a.assessment_id
       AND s.user_id = e.user_id
    WHERE l.course_id = e.course_id
);
GO

-- 10. List courses where every enrolled user has submitted at least one assessment.
-- NOT EXISTS: It checks for atleast 1 maching records where as join checks for all the matching records.
SELECT
    e.course_id
FROM lms.Enrollments AS e
WHERE EXISTS (
    SELECT 1
    FROM lms.Lessons AS l
	JOIN lms.Assessments AS a
		ON a.lesson_id = l.lesson_id
    JOIN lms.Assessment_Submission AS s
        ON s.assessment_id = a.assessment_id
       AND s.user_id = e.user_id
    WHERE l.course_id = e.course_id
	AND s.submission_id = NULL
);
GO
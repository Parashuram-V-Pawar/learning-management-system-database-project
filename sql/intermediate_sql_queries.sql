/*Intermediate SQL Queries
1. List all users who are enrolled in more than three courses.
2. Find courses that currently have no enrollments.
3. Display each course along with the total number of enrolled users.
4. Identify users who enrolled in a course but never accessed any lesson.
5. Fetch lessons that have never been accessed by any user.
6. Show the last activity timestamp for each user.
7. List users who submitted an assessment but scored less than 50 percent of the maximum score.
8. Find assessments that have not received any submissions.
9. Display the highest score achieved for each assessment.
10. Identify users who are enrolled in a course but have an inactive enrollment status.
*/


-- 1. List all users who are enrolled in more than three courses.
-- * Why JOIN: I have used INNER JOIN so that i can retreive only matching rows in both tables.
-- * ASSUMPTIONS: Yes, I have assumed that each user has only enrolled to particular course one time.

SELECT u.user_id, u.user_name
FROM lms.Users AS u 
JOIN lms.Enrollments AS e 
    ON u.user_id = e.user_id
-- WHERE e.enrollment_status = 'ACTIVE'
GROUP BY u.user_id, u.user_name
HAVING count(*) > 3;
GO

-- 2. Find courses that currently have no enrollments.
-- Why LEFT ANTI JOIN: Enrollment table stores user enrollment data which also contains courses to which users enrolled,
-- So, i am left joining courses on enrollments so that i can find courses which are not present in enrollments.
SELECT c.course_id, c.course_title
FROM lms.Courses AS c
LEFT JOIN lms.Enrollments AS e
    ON e.course_id = c.course_id
WHERE e.course_id IS NULL
GO

-- 3. Display each course along with the total number of enrolled users.
-- Why LEFT JOIN: Because we want all the courses to be displayed irrespective of whether it has enrolled users or no,
-- then i'm left joining it to enrollment to count for number of enrollments in each course by grouping the courses.
SELECT c.course_id, c.course_title, COUNT(e.enrollment_id) AS Number_of_enrollments
FROM lms.Courses as c
LEFT JOIN lms.Enrollments as e 
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
ORDER BY Number_of_enrollments DESC;
GO


-- 4. Identify users who enrolled in a course but never accessed any lesson.
-- Why NOT EXISTS: Because i wwant to find if the data is matching with the right table for atleast once,
-- Here the Left join becomes slower because it checks for all the rows and NOT EXISTS only check for 1 match
-- and if it is there atleast once then it won't check later.
SELECT
    u.user_id,
    u.user_name,
    c.course_id,
    c.course_title
FROM lms.Enrollments AS e
JOIN lms.Users AS u
    ON u.user_id = e.user_id
JOIN lms.Courses AS c
    ON c.course_id = e.course_id
WHERE NOT EXISTS (
    SELECT 1
    FROM lms.User_Activity AS ua
    JOIN lms.Lessons AS l
        ON l.lesson_id = ua.lesson_id
    WHERE ua.user_id = e.user_id
      AND l.course_id = e.course_id
);
GO



-- 5. Fetch lessons that have never been accessed by any user.
-- WHY LEFT JOIN: Because we need all the courses which have never been accessed by users,
-- IF we use inner join then only the match rows will be returned and that goes the opposite way.
-- This way we are only able to get courses which are not present in user_activity and it also matches the problem statement.
SELECT l.lesson_title
FROM lms.Lessons as l 
LEFT JOIN lms.User_Activity as ua 
ON ua.lesson_id = l.lesson_id
WHERE ua.lesson_id is NULL;

-- 6. Show the last activity timestamp for each user.
-- Why LEFT JOIN: The question says all the users so we are using left join users on user_activity,
-- From where we get last activity timestamp for users who performed activity and NULL for user who didn't perfom any activity.
SELECT u.user_id,u.user_name, MAX(ua.activity_date) as Last_activity
FROM lms.Users as u 
LEFT JOIN lms.User_Activity as ua 
ON u.user_id = ua.user_id
GROUP BY u.user_id, u.user_name;
GO

-- 7. List users who submitted an assessment but scored less than 50 percent of the maximum score.
-- Why INNER JOIN: Because we only want users who have actually submitted an assessment.
-- INNER JOIN ensures only matching rows between users, submissions, and assessments are returned.
-- Assumptions: marks_scored is always less than or equal to max_score as per business logic.
SELECT 
    u.user_id, 
    u.user_name, 
    a.assessment_id, 
    s.marks_scored
FROM lms.Assessment_Submission AS s
JOIN lms.Users AS u
    ON u.user_id = s.user_id
JOIN lms.Assessments AS a
    ON a.assessment_id = s.assessment_id
WHERE s.marks_scored < (a.max_score * 0.5);
GO



-- 8. Find assessments that have not received any submissions.
-- Why LEFT JOIN (LEFT ANTI JOIN): Because we want all assessments,
-- and then filter out those that do not have any matching records in the Assessment_Submission table.
SELECT 
    a.assessment_id, 
    a.assessment_name
FROM lms.Assessments AS a
LEFT JOIN lms.Assessment_Submission AS s
    ON s.assessment_id = a.assessment_id
WHERE s.assessment_id IS NULL;
GO

-- 9. Display the highest score achieved for each assessment.
-- Why LEFT JOIN: Because we want to display all assessments, even those that have not yet received any submissions.
-- MAX() is used to get the highest marks scored per assessment. And used COALESCE to replace NULL with 0.
SELECT 
    a.assessment_id, 
    a.assessment_name, 
    COALESCE(MAX(s.marks_scored),0) AS Highest_Score
FROM lms.Assessments AS a
LEFT JOIN lms.Assessment_Submission AS s
    ON s.assessment_id = a.assessment_id
GROUP BY 
    a.assessment_id, 
    a.assessment_name;
GO

-- 10. Identify users who are enrolled in a course but have an inactive enrollment status.
SELECT u.user_id, e.course_id, u.user_name
FROM lms.Users as u 
JOIN lms.Enrollments as e 
ON u.user_id = e.user_id
WHERE enrollment_status = 'INACTIVE';


SELECT * FROM lms.Users;
SELECT * FROM lms.Courses;
SELECT * FROM lms.Enrollments;
SELECT * FROM lms.Lessons;
SELECT * FROM lms.Assessment_Submission;
SELECT * FROM lms.Assessments;
SELECT * FROM lms.User_Activity;
-- Section 3: Performance and Optimization
-- 1. Suggest appropriate indexes for improving performance of:
--      a. Course dashboards
--      b. User activity analytics
-- 2. Identify potential performance bottlenecks in queries involving user activity.
-- 3. Explain how you would optimize queries when the user_activity table grows to millions of rows.
-- 4. Describe scenarios where materialized views would be useful for this schema.
-- 5. Explain how partitioning could be applied to user_activity.


-- 1. Suggest appropriate indexes for improving performance of:
-- a. Course dashboards
-- Solution:
-- We can use non-clustered indexing to increase the performance of queries on:
-- 1. Enrollments table - Where we can find number of users registered for course.
-- 2. Lessons table - To find number of lessons in each course.
-- 3. Assignments table - To find number of assessments in each course.
-- 4. Assessment_Submission table - To increase the calculations of scores obtained.

-- 1. Enrollments table - Where we can find number of users registered for course.
-- Speed up course enrollment lookups.
CREATE NONCLUSTERED INDEX IX_Enrollments_Course
ON lms.Enrollments (course_id, user_id);
GO
-- 2. Lessons table - To find number of lessons in each course.
-- Speed up lesson counts per course.
CREATE NONCLUSTERED INDEX IX_Lessons_Course
ON lms.Lessons (course_id);
GO
-- 3. Assignments table - To find number of assessments in each course.
-- Speed up assessment lookups per lesson.
CREATE NONCLUSTERED INDEX IX_Assessments_Lesson
ON lms.Assessments (lesson_id);
GO
-- 4. Assessment_Submission table - To increase the calculations of scores obtained.
-- Speed up score aggregation per course.
CREATE NONCLUSTERED INDEX IX_Assessment_Submission_Assessment_User
ON lms.Assessment_Submission (assessment_id, user_id)
INCLUDE (marks_scored);
GO
-- =================================================================================================
-- b. User activity analytics
-- Solution:
-- 1. Frequent user-based activity analysis
-- User_Activity table - Helps quickly find all activities done by a specific user.
-- Useful for tracking user engagement and activity history.
CREATE NONCLUSTERED INDEX IX_User_Activity_User_Date
ON lms.User_Activity (user_id, activity_date);
GO

-- 2. Lesson engagement analytics
-- User_Activity table - Helps analyze how many users interacted with a specific lesson over time.
-- Useful for checking lesson popularity and engagement trends.
CREATE NONCLUSTERED INDEX IX_User_Activity_Lesson_Date
ON lms.User_Activity (lesson_id, activity_date);
GO

-- 3. Status-based filtering (optional)
-- User_Activity table - Helps quickly filter activities based on their status.
-- Useful for progress tracking and completion reports.
CREATE NONCLUSTERED INDEX IX_User_Activity_Status
ON lms.User_Activity (activity_status);
GO

-- =================================================================================================
-- 2. Identify potential performance bottlenecks in queries involving user activity.
-- Solution:
-- * For certain queries such as joining user_activity  with courses can create too many rows and becomes slower.
-- * Scanning all the records for daily activity of a user or checking streaks reduces the performance.
-- * Windows function are slow because Sorting becomes expensive and slow in large datasets.

-- =================================================================================================
-- 3. Explain how you would optimize queries when the user_activity table grows to millions of rows.
-- Solution:
-- * Including columns in indexes which are being used repeatedly in queries.
-- * We can apply filters to data before doing any joins or aggregations on data that reduces the number of rows 
-- to be processed.
-- We can do this on activity_date or user_id.

-- =================================================================================================
-- 4. Describe scenarios where materialized views would be useful for this schema.
-- Solution:
-- We can use materialized views tto check number of user activities on daily basis like how many users are active daily.

-- =================================================================================================
-- 5. Explain how partitioning could be applied to user_activity.
-- Solution:
-- We can apply partitioning on user_activity by activity date on monthly or yearly basis.
-- Because user_activity grows massively on daily basis so we can apply partitioning on activity date.



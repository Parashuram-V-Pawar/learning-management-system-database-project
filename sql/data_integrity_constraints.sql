-- Section 4: Data Integrity and Constraints
-- 1. Propose constraints to ensure a user cannot submit the same assessment more than once.
-- 2. Ensure that assessment scores do not exceed the defined maximum score.
-- 3. Prevent users from enrolling in courses that have no lessons.
-- 4. Ensure that only instructors can create courses.
-- 5. Describe a safe strategy for deleting courses while preserving historical data.


-- =======================================================================================================================
-- 1. Propose constraints to ensure a user cannot submit the same assessment more than once.
-- Solution:
ALTER TABLE lms.Assessment_Submission
ADD CONSTRAINT UQ_Assessment_User 
    UNIQUE (assessment_id, user_id);
-- This can fail if we have more than one assessment submittted for 1 user for same assessment, 
-- but in my case i have added this constraint while creating table, so this issue won't arise.

-- =======================================================================================================================
-- 2. Ensure that assessment scores do not exceed the defined maximum score.
-- Solution:
-- We can use triggers for this condition and cannot add constraint here as maximum score is available in some other table.

CREATE TRIGGER trg_Check_Max_Score
ON lms.Assessment_Submission
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN lms.Assessments a
            ON a.assessment_id = i.assessment_id
        WHERE i.marks_scored > a.max_score
    )
    BEGIN
        RAISERROR ('Marks scored cannot exceed assessment max score.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Testing example
INSERT INTO lms.Assessment_Submission(submission_id, assessment_id, user_id, submission_date, marks_scored) 
VALUES (10001, 20, 3789, '2025-07-16', 1001)

-- =======================================================================================================================
-- 3. Prevent users from enrolling in courses that have no lessons.
-- Solution:
-- Here also condition to check from another table so we cannot add a constraint and we need to use trigger.
CREATE TRIGGER trg_Prevent_Enroll_NoLessons
ON lms.Enrollments
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1
            FROM lms.Lessons l
            WHERE l.course_id = i.course_id
        )
    )
    BEGIN
        RAISERROR ('Cannot enroll in a course with no lessons.', 16, 1);
        RETURN;
    END

    INSERT INTO lms.Enrollments
    SELECT * FROM inserted;
END;
GO

-- =======================================================================================================================
-- 4. Ensure that only instructors can create courses.
-- Solution: 
-- Currently we donot have instructors records in my user table and we have not specified roles for the users.
-- This is why first we need to add one more column in users table as role which defines students or instructors.
-- Aslo adding constraint to be checked while inserting the values to users so that there can be only Student or instructor in role.
-- AS we only inserted student data earlier, we are setting role for existing user as STUDENT by default.
ALTER TABLE lms.Users
ADD user_role VARCHAR(20) NOT NULL DEFAULT 'STUDENT';
GO
ALTER TABLE lms.Users
ADD CONSTRAINT CK_User_Role
CHECK (user_role IN ('STUDENT','INSTRUCTOR','ADMIN'));
GO

-- Then Add column created by and assign all previous courses to admin so that the dataset don't fail.
-- And created by cannot be null for all upcoming courses so making it not null after assigning existing courses to admin.
ALTER TABLE lms.Courses
ADD created_by INT NULL;

-- Inserted a Admin record to the users table so that we can assign created by to admin for all the courses.
INSERT INTO lms.Users(user_id, [user_name], user_email, user_phone, user_role)
VALUES (5001, 'Parashuram Pawar', 'parashu@gmail.com', 8090542877, 'ADMIN')

UPDATE lms.Courses
SET created_by = 5001; 

ALTER TABLE lms.Courses
ALTER COLUMN created_by INT NOT NULL;

-- Once we make it not null we need to make it foriegn key to users table so that mapping could be possible.
ALTER TABLE lms.Courses
ADD CONSTRAINT FK_Course_Creator
FOREIGN KEY (created_by)
REFERENCES lms.Users(user_id);
GO

-- Now we need to create a trigger which allows only Instructors to add the courses.
CREATE TRIGGER trg_Only_Instructor_Create_Course
ON lms.Courses
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN lms.Users u
            ON u.user_id = i.created_by
        WHERE u.user_role <> 'INSTRUCTOR'
    )
    BEGIN
        RAISERROR ('Only instructors can create courses.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- =======================================================================================================================
-- 5. Describe a safe strategy for deleting courses while preserving historical data.
-- Solution:
-- If we delete course will be dropped and relationship fails and references are broken.
-- So we can do soft delete that add we can add the status column in the course table where we can update whether 
-- the courses are available or no. and if we want to delete them We can set the status to archived or deleted and 
-- when querying we can use the status as ACTIVE to get deltails of only active courses.
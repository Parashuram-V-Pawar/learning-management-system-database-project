/*
==================================================================================================
The schema represents an LMS with the following entities:
Users, Courses, Lessons, Enrollments, User Activity, Assessments, and Assessment Submissions.
Relationships include:
1. Users enroll in courses
2. Courses contain lessons and assessments
3. Users perform activities on lessons
4. Users submit assessments and receive scores
==================================================================================================
*/

-- Creating Database for the project.
CREATE DATABASE learning_management;
GO
-- Navigating to Database.
use learning_management;
GO

--Creating Schema.
CREATE SCHEMA lms;
GO

-- Creating Tables. 

-- Course table creation.
CREATE TABLE lms.Courses (
    course_id INT IDENTITY(1,1) NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    course_duration INT,
    CONSTRAINT PK_Course_Id PRIMARY KEY(course_id)
);
GO

-- User table creation.
CREATE TABLE lms.Users (
    user_id INT NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(254) NOT NULL,
    user_phone VARCHAR(10) NOT NULL,
    CONSTRAINT PK_User_Id 
        PRIMARY KEY(user_id),
    CONSTRAINT UQ_Users_Email  
        UNIQUE (user_email),
    CONSTRAINT Check_Phone 
        CHECK (user_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

-- Lessons table creation.
CREATE TABLE lms.Lessons(
    lesson_id INT NOT NULL,
    lesson_title VARCHAR(150) NOT NULL,
    course_id INT,
    CONSTRAINT PK_Lesson_Key 
        PRIMARY KEY(lesson_id),
    CONSTRAINT UQ_lesson_per_course 
        UNIQUE(course_id, lesson_title),
    CONSTRAINT FK_Course_Id 
        FOREIGN KEY(course_id) 
        REFERENCES lms.Courses(course_id)
);
GO

-- Enrollments table creation.
CREATE TABLE lms.Enrollments (
    enrollment_id INT NOT NULL,
    enrollment_date date NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    user_id INT,
    course_id INT,
    CONSTRAINT PK_Enrollment_Id
        PRIMARY KEY(enrollment_id),
    CONSTRAINT Check_Status
        CHECK (enrollment_status in ('ACTIVE','INACTIVE','COMPLETED')),
    CONSTRAINT FK_Lessons_User_Id
        FOREIGN KEY(user_id) 
        REFERENCES lms.Users(user_id),
    CONSTRAINT FK_Lessons_Course_Id
        FOREIGN KEY(course_id)
        REFERENCES lms.Courses(course_id),
    CONSTRAINT UQ_UserId_CourseID
        UNIQUE(user_id, course_id)
);
GO

-- Assessments table creation.
CREATE TABLE lms.Assessments (
    assessment_id INT NOT NULL,
    assessment_name VARCHAR(150) NOT NULL,
    max_score INT NOT NULL,
    lesson_id INT,
    CONSTRAINT PK_Assessment_Id
        PRIMARY KEY (assessment_id),
    CONSTRAINT FK_Assessment_Lesson
        FOREIGN KEY (lesson_id)
        REFERENCES lms.Lessons(lesson_id),
    CONSTRAINT UQ_Assessments_PerLesson 
        UNIQUE (lesson_id, assessment_name)
);
GO

-- Assessment submission table creation.
CREATE TABLE lms.Assessment_Submission (
    submission_id INT NOT NULL,
    lesson_id INT NOT NULL,
    user_id INT NOT NULL,
    submission_date date NOT NULL,
    marks_scored INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_SubmissionId
        PRIMARY KEY(submission_id),
    CONSTRAINT UQ_Lesson_User
        UNIQUE(lesson_id, user_id),
    CONSTRAINT CK_Assessments_MarksScored
        CHECK (marks_scored >= 0 AND marks_scored <= 100),
    CONSTRAINT FK_Submission_UserId
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),
    CONSTRAINT FK_Submission_LessonId
        FOREIGN KEY (lesson_id)
        REFERENCES lms.Lessons(lesson_id)
);
GO

-- User Activity table creation.
CREATE TABLE lms.User_Activity (
    activity_id INT IDENTITY(1,1) NOT NULL,
    lesson_id INT NOT NULL,
    user_id INT NOT NULL,
    activity_status VARCHAR(20) NOT NULL DEFAULT 'NOT STARTED',
    activity_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_Activity_Id 
        PRIMARY KEY(activity_id),
    CONSTRAINT CK_Activity_Status
        CHECK (activity_status in ('NOT STARTED', 'STARTED', 'COMPLETED')),
    CONSTRAINT FK_Activity_UserId
        FOREIGN KEY(user_id)
        REFERENCES lms.Users(user_id),
    CONSTRAINT FK_Activity_Lesson_Id
        FOREIGN KEY(lesson_id)
        REFERENCES lms.Lessons(lesson_id),
);
GO

-- To check current working Database
SELECT DB_NAME()
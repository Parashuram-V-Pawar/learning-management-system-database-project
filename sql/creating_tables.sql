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
    course_id INT NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    course_duration INT NOT NULL,
    CONSTRAINT PK_Courses 
        PRIMARY KEY (course_id)
);
GO

CREATE TABLE lms.Users (
    user_id INT NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(254) NOT NULL,
    user_phone VARCHAR(15) NOT NULL,
    CONSTRAINT PK_Users 
        PRIMARY KEY (user_id),
    CONSTRAINT UQ_Users_Email 
        UNIQUE (user_email)
);
GO

CREATE TABLE lms.Enrollments (
    enrollment_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    CONSTRAINT PK_Enrollments 
        PRIMARY KEY (enrollment_id),
    CONSTRAINT UQ_User_Course 
        UNIQUE (user_id, course_id),
    CONSTRAINT CK_Enrollment_Status 
        CHECK (enrollment_status IN ('ACTIVE','INACTIVE','COMPLETED')),
    CONSTRAINT FK_Enrollments_User 
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),
    CONSTRAINT FK_Enrollments_Course 
        FOREIGN KEY (course_id)
        REFERENCES lms.Courses(course_id)
);
GO

CREATE TABLE lms.Lessons (
    lesson_id INT NOT NULL,
    lesson_title VARCHAR(150) NOT NULL,
    course_id INT NOT NULL,
    CONSTRAINT PK_Lessons 
        PRIMARY KEY (lesson_id),
    CONSTRAINT UQ_Lesson_PerCourse 
        UNIQUE (course_id, lesson_title),
    CONSTRAINT FK_Lessons_Course 
        FOREIGN KEY (course_id)
        REFERENCES lms.Courses(course_id)
);
GO


CREATE TABLE lms.Assessments (
    assessment_id INT NOT NULL,
    assessment_name VARCHAR(150) NOT NULL,
    max_score INT NOT NULL,
    lesson_id INT NOT NULL,
    CONSTRAINT PK_Assessments 
        PRIMARY KEY (assessment_id),
    CONSTRAINT UQ_Assessment_PerLesson 
        UNIQUE (lesson_id, assessment_name),
    CONSTRAINT FK_Assessments_Lesson 
        FOREIGN KEY (lesson_id)
        REFERENCES lms.Lessons(lesson_id)
);
GO

CREATE TABLE lms.Assessment_Submission (
    submission_id INT NOT NULL,
    assessment_id INT NOT NULL,
    user_id INT NOT NULL,
    submission_date DATE NOT NULL,
    marks_scored INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_Assessment_Submission 
        PRIMARY KEY (submission_id),
    CONSTRAINT UQ_Assessment_User 
        UNIQUE (assessment_id, user_id),
    CONSTRAINT CK_Marks_Scored 
        CHECK (marks_scored >= 0),
    CONSTRAINT FK_Submission_Assessment 
        FOREIGN KEY (assessment_id)
        REFERENCES lms.Assessments(assessment_id),
    CONSTRAINT FK_Submission_User 
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id)
);
GO

CREATE TABLE lms.User_Activity (
    activity_id INT IDENTITY(1,1) NOT NULL,
    lesson_id INT NOT NULL,
    user_id INT NOT NULL,
    activity_status VARCHAR(20) NOT NULL DEFAULT 'NOT_STARTED',
    activity_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_User_Activity 
        PRIMARY KEY (activity_id),
    CONSTRAINT CK_Activity_Status 
        CHECK (activity_status IN ('NOT_STARTED','STARTED','COMPLETED')),
    CONSTRAINT FK_Activity_Lesson 
        FOREIGN KEY (lesson_id)
        REFERENCES lms.Lessons(lesson_id),
    CONSTRAINT FK_Activity_User 
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id)
);

-- To check current working Database
SELECT DB_NAME()
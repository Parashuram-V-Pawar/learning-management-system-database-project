/* Values Insertion */

-- Inserting values into 'Courses' table manually.
INSERT INTO lms.Courses (course_title, course_duration)
VALUES
('Introduction to SQL', 10),
('Database Design Fundamentals', 12),
('Python for Data Analysis', 15),
('Web Development Basics', 8),
('Advanced Machine Learning', 20),
('Cloud Computing Fundamentals', 12);
GO

-- Inserting values into 'Users' table.
INSERT INTO lms.Users (user_id, user_name, user_email, user_phone)
VALUES
(1, 'Parashuram Pawar', 'parashu.pawar@gmail.com', '9876543210'),
(2, 'Vilas Gouda', 'vilasgouda@gmail.com', '9876543211'),
(3, 'Madan J', 'jmadam1@gmail.com', '9876543212'),
(4, 'T Sudheer', 'sudheer980@gmail.com', '9876543213'),
(5, 'Tejeshwar Reddy', 'reddy.tejeshwar@gmail.com', '9876543214'),
(6, 'Isha Mehta', 'isha.mehta@gmail.com', '9876543215'),
(7, 'Aditya Nair', 'aditya.nair@gmail.com', '9876543216'),
(8, 'Pooja Reddy', 'pooja.reddy@gmail.com', '9876543217'),
(9, 'Vikram Patil', 'vikram.patil@gmail.com', '9876543218'),
(10, 'Neha Rao', 'neha.rao@gmail.com', '9876543219'),
(11, 'Ravi Kumar',     'ravi.kumar101@gmail.com', '9876543210'),
(12, 'Neha Sharma',   'neha.sharma102@gmail.com', '9876543211'),
(13, 'Amit Verma',    'amit.verma103@gmail.com',  '9876543212'),
(14, 'Pooja Singh',   'pooja.singh104@gmail.com', '9876543213'),
(15, 'Karan Patel',   'karan.patel105@gmail.com', '9876543214');
GO


-- Inserting values into 'Lessons' table.
INSERT INTO lms.Lessons (lesson_id, lesson_title, course_id)
VALUES
-- Course 1: Introduction to SQL
(1, 'SQL Basics', 1),
(2, 'SELECT Statements', 1),
(3, 'WHERE Clause', 1),
(4, 'Joins in SQL', 1),
(5, 'Aggregate Functions', 1),
(6, 'Subqueries', 1),
-- Course 2: Database Design Fundamentals
(7, 'ER Modeling', 2),
(8, 'Normalization', 2),
(9, 'Relationships', 2),
(10, 'Primary & Foreign Keys', 2),
(11, 'Indexes', 2),
(12, 'Constraints', 2),
-- Course 3: Python for Data Analysis
(13, 'Python Basics', 3),
(14, 'Data Types', 3),
(15, 'Control Flow', 3),
(16, 'Functions', 3),
(17, 'Pandas Introduction', 3),
(18, 'Data Visualization', 3),
-- Course 4: Web Development Basics
(19, 'HTML Basics', 4),
(20, 'CSS Fundamentals', 4),
(21, 'JavaScript Basics', 4),
(22, 'DOM Manipulation', 4),
(23, 'Forms & Validation', 4),
(24, 'Responsive Design', 4),
-- Course 5: Advanced Machine Learning
(25, 'Introduction to ML', 5),
(26, 'Supervised Learning', 5),
(27, 'Unsupervised Learning', 5),
(28, 'Feature Engineering', 5),
(29, 'Model Evaluation', 5),
(30, 'Hyperparameter Tuning', 5),
(31, 'Big DATA', 5);
GO

--Inserting values into 'Enrollments' table.
INSERT INTO lms.Enrollments (enrollment_id, enrollment_date, enrollment_status, user_id, course_id)
VALUES
(1, '2026-01-02', 'ACTIVE', 1, 1),
(2, '2026-01-04', 'COMPLETED', 1, 3),
(3, '2026-01-05', 'ACTIVE', 1, 5),
(4, '2026-01-06', 'INACTIVE', 2, 2),
(5, '2026-01-07', 'ACTIVE', 3, 3),
(6, '2026-01-08', 'ACTIVE', 3, 4),
(7, '2026-01-09', 'COMPLETED', 4, 1),
(8, '2026-01-10', 'ACTIVE', 5, 5),
(9, '2026-01-11', 'INACTIVE', 6, 2),
(10, '2026-01-12', 'ACTIVE', 6, 3),
(11, '2026-01-13', 'ACTIVE', 7, 1),
(12, '2026-01-14', 'COMPLETED', 7, 2),
(13, '2026-01-15', 'ACTIVE', 7, 4),
(14, '2026-01-16', 'ACTIVE', 8, 5),
(15, '2026-01-17', 'INACTIVE', 9, 3),
(16, '2026-01-18', 'ACTIVE', 10, 2),
(17, '2026-01-19', 'ACTIVE', 10, 4),
(18, '2026-01-20', 'COMPLETED', 10, 5),
(19, '2026-01-21', 'ACTIVE', 2, 5),
(20, '2026-01-22', 'ACTIVE', 4, 3),
(21, '2025-12-02', 'ACTIVE', 1, 4),
(22, '2026-01-12', 'ACTIVE', 12, 5),
(23, '2025-12-09', 'ACTIVE', 12, 3);
GO

-- Insert values into 'Assessments' table.
INSERT INTO lms.Assessments (assessment_id, assessment_name, max_score, lesson_id)
VALUES
(1, 'Intro Quiz', 50, 1),
(2, 'Intro Assignment', 50, 1),
(3, 'Basics Quiz', 50, 2),
(4, 'SELECT Quiz', 50, 3),
(5, 'SELECT Assignment', 50, 3),
(6, 'WHERE Clause Quiz', 50, 4),
(7, 'JOINS Quiz', 50, 5),
(8, 'JOINS Assignment', 50, 5),
(9, 'Subqueries Quiz', 50, 6),
(10, 'Indexes Quiz', 50, 7),
(11, 'Indexes Assignment', 50, 7),
(12, 'Normalization Quiz', 50, 8),
(13, 'ER Diagram Quiz', 50, 9),
(14, 'ER Diagram Assignment', 50, 9),
(15, 'Constraints Quiz', 50, 10),
(16, 'Transactions Quiz', 50, 11),
(17, 'ACID Properties Quiz', 50, 12),
(18, 'Transactions Assignment', 50, 12),
(19, 'Python Basics Quiz', 50, 13),
(20, 'Data Types Quiz', 50, 14),
(21, 'Data Types Assignment', 50, 14),
(22, 'Loops Quiz', 50, 15),
(23, 'Functions Quiz', 50, 16),
(24, 'Pandas Quiz', 50, 17),
(25, 'Pandas Assignment', 50, 17),
(26, 'Data Cleaning Quiz', 50, 18),
(27, 'Visualization Quiz', 50, 19),
(28, 'Matplotlib Assignment', 50, 20),
(29, 'HTML Basics Quiz', 50, 21),
(30, 'CSS Fundamentals Quiz', 50, 22),
(31, 'CSS Layout Assignment', 50, 22),
(32, 'JavaScript Basics Quiz', 50, 23),
(33, 'DOM Manipulation Quiz', 50, 24),
(34, 'DOM Assignment', 50, 24),
(35, 'Async JS Quiz', 50, 25),
(36, 'ML Introduction Quiz', 50, 26),
(37, 'Regression Quiz', 50, 27),
(38, 'Regression Assignment', 50, 27),
(39, 'Classification Quiz', 50, 28),
(40, 'Model Evaluation Quiz', 50, 29),
(41, 'Final Project Proposal', 50, 30),
(42, 'Final Project Submission', 50, 30),
(43, 'Final Viva Quiz', 50, 30),
(44, 'Course Feedback Quiz', 50, 30),
(45, 'Capstone Review', 50, 30);
GO

-- Insert values into 'Assessment_Submission' table.
INSERT INTO lms.Assessment_Submission
(submission_id, lesson_id, user_id, submission_date, marks_scored)
VALUES
(1,  1,  1, '2026-02-01', 45),
(2,  1,  3, '2026-02-01', 28),
(3,  2,  1, '2026-02-02', 40),
(4,  3,  2, '2026-02-02', 18),
(5,  3,  3, '2026-02-03', 35),
(6,  4,  4, '2026-02-03', 22),
(7,  5,  1, '2026-02-04', 48),
(8,  5,  5, '2026-02-04', 31),
(9,  6,  6, '2026-02-05', 15),
(10, 7,  7, '2026-02-06', 42),
(11, 7,  3, '2026-02-06', 25),
(12, 8,  8, '2026-02-07', 39),
(13, 9,  9, '2026-02-07', 44),
(14, 9,  1, '2026-02-08', 50),
(15, 10, 2, '2026-02-08', 20),
(16, 11, 3, '2026-02-09', 33),
(17, 12, 4, '2026-02-09', 27),
(18, 12, 5, '2026-02-10', 46),
(19, 13, 6, '2026-02-10', 19),
(20, 14, 7, '2026-02-11', 41),
(21, 15, 8, '2026-02-11', 23),
(22, 16, 9, '2026-02-12', 38),
(23, 17, 10,'2026-02-12', 49),
(24, 17, 1, '2026-02-13', 34),
(25, 18, 2, '2026-02-13', 17),
(26, 19, 3, '2026-02-14', 29),
(27, 20, 4, '2026-02-14', 45),
(28, 21, 5, '2026-02-15', 26),
(29, 22, 6, '2026-02-15', 32),
(30, 24, 7, '2026-02-16', 47);
GO


-- Insert values into 'Assessment_Submission' table.
INSERT INTO lms.User_Activity (lesson_id, user_id, activity_status, activity_date)
VALUES
(1, 1, 'STARTED',   '2026-02-01 09:10'),
(1, 1, 'COMPLETED', '2026-02-01 10:30'),
(3, 1, 'COMPLETED', '2026-02-02 09:45'),
(5, 1, 'COMPLETED', '2026-02-03 11:00'),
(7, 1, 'COMPLETED', '2026-02-04 10:15'),
(9, 1, 'COMPLETED', '2026-02-05 12:00'),
(2, 2, 'STARTED',   '2026-02-02 14:00'),
(3, 2, 'STARTED',   '2026-02-04 15:30'),
(3, 3, 'STARTED',   '2026-02-01 10:00'),
(4, 3, 'STARTED',   '2026-02-03 11:00'),
(5, 3, 'STARTED',   '2026-02-05 13:30'),
(1, 4, 'COMPLETED', '2026-02-02 09:00'),
(4, 4, 'COMPLETED', '2026-02-03 09:30'),
(5, 5, 'STARTED',   '2026-02-04 16:00'),
(6, 6, 'NOT STARTED','2026-02-06 10:00'),
(1, 7, 'COMPLETED', '2026-02-01 08:30'),
(2, 7, 'COMPLETED', '2026-02-02 08:45'),
(3, 7, 'COMPLETED', '2026-02-03 09:00'),
(4, 7, 'COMPLETED', '2026-02-04 09:15'),
(5, 7, 'COMPLETED', '2026-02-05 09:30'),
(8, 8, 'STARTED',   '2026-02-03 17:00'),
(9, 8, 'STARTED',   '2026-02-07 18:00'),
(9, 9, 'STARTED',   '2026-02-05 11:30'),
(10, 10, 'STARTED', '2026-02-08 14:00'),
(11, 10, 'COMPLETED','2026-02-09 15:00'),
(12, 1, 'COMPLETED', '2026-02-06 13:00'),
(13, 3, 'STARTED',   '2026-02-07 09:00'),
(14, 7, 'COMPLETED', '2026-02-06 10:00'),
(15, 4, 'STARTED',   '2026-02-07 11:00'),
(16, 2, 'NOT STARTED','2026-02-08 12:00'),
(17, 6, 'STARTED',   '2026-02-09 13:30'),
(18, 8, 'COMPLETED', '2026-02-10 14:45'),
(19, 9, 'NOT STARTED','2026-02-11 15:00'),
(20, 10,'COMPLETED', '2026-02-12 16:30'),
(13, 12, 'STARTED', '2026-02-11 15:00'),
(25, 1, 'STARTED', '2026-02-20');
GO


-- Inserting data from CSV File.
BULK INSERT lms.Courses
FROM '/var/opt/mssql/data/Courses1.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);
Go
BULK INSERT lms.Users
FROM '/var/opt/mssql/data/Users1.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);
GO
BULK INSERT lms.Lessons
FROM '/var/opt/mssql/data/Lessons1.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);
GO
BULK INSERT lms.Enrollments
FROM '/var/opt/mssql/data/Enrollments1.csv'
WITH (FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);
GO
BULK INSERT lms.Assessments
FROM '/var/opt/mssql/data/Assessments1.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);
GO
BULK INSERT lms.Assessment_Submission
FROM '/var/opt/mssql/data/Assessment_Submission1.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);
GO

-- Because User_Avtivity table contains Identity for auto-increment of activity ID.
-- It is not possible to directly insert values from file so need to create a stage file.
-- Then load data to stage table and copy that table data to User_Activity.
CREATE TABLE lms.User_Activity_Stage (
    lesson_id INT,
    user_id INT,
    activity_status VARCHAR(20),
    activity_date DATETIME2
);
GO
BULK INSERT lms.User_Activity_Stage
FROM '/var/opt/mssql/data/User_Activity1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO
INSERT INTO lms.User_Activity
(lesson_id, user_id, activity_status, activity_date)
SELECT
    lesson_id,
    user_id,
    activity_status,
    activity_date
FROM lms.User_Activity_Stage;
GO

-- Once the insertion is complete dropping the stage table
DROP TABLE lms.User_Activity_Stage;
GO



SELECT * FROM lms.Users;
SELECT * FROM lms.Courses;
SELECT * FROM lms.Lessons;
SELECT * FROM lms.Enrollments;
SELECT * FROM lms.Assessments;
SELECT * FROM lms.Assessment_Submission;
SELECT * FROM lms.User_Activity;
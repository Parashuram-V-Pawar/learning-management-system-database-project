# Learning Management System (LMS) Database Project

The Learning Management System (LMS) is a relational database project implemented in Microsoft SQL Server, designed to support online learning platforms.

## Project Overview
The database captures core LMS functionality including:
1. User management (students and instructors)
2. Course creation and enrollment
3. Lessons and assessments
4. User activity tracking and assessment submissions

## Schema & Architecture
### 1. Tables and Relationships
|Table	|Purpose|
|-------|-------|
|Courses	|Stores courses, titles, and duration|
|Users	|Stores student and instructor information|
|Lessons	|Contains lessons associated with courses|
|Enrollments	|Tracks users enrolled in courses, including status|
|Assessments	|Contains assessments associated with lessons|
|Assessment_Submission	|Stores assessment submissions and marks|
|User_Activity	|Logs user interactions with lessons|

### 2. Key Relationships
1. Users enroll in courses (Enrollments)
2. Courses contain lessons (Lessons)
3. Lessons may have assessments (Assessments)
4. Users interact with lessons (User_Activity)
5. Users submit assessments (Assessment_Submission)

## Tech Stack
- Database: Microsoft SQL Server
- Language: T-SQL
- Concepts Used:
  - CTEs
  - Subqueries
  - Window Functions (ROW_NUMBER, LAG)
  - Joins and Aggregations
  - Normalization (3NF)

## Project structure
```
learning-management-system-database-project /
|-- data /
|   |-- Users_realistic.csv
|   |-- Enrollments_realistic.csv
|   |-- Courese_realistic.csv
|   |-- Lessons_realistic.csv
|   |-- User_Activity_realistic.csv
|   |-- Assessment_realistic.csv
|   |-- Assessment_Submission_realistic.csv
|
|-- designs /
|   |-- Learning-Management-System-ERD.png
|
|-- sql /
|   |-- creating_tables.sql
|   |-- inserting_values.sql
|   |-- intermediate_sql_queries.sql
|   |-- advanced_sql_queries.sql
|   |-- performance_and_optimization.sql
|   |-- transaction_and_concurrency.sql
|   |-- data_integrity_constraints.sql
|   |-- database_design_and_archittecture.sql
|
|-- README.md
|-- requirements.txt
|-- .gitignore
```

## Installation
```
Clone the repository
-> git clone https://github.com/Parashuram-V-Pawar/learning-management-system-database-project.git

Move to project folder
-> cd learning-management-system-database-project.git

```

## How to Use
Once you have installed all the requirements 
Run sql scripts in order
1. First execute create_table.sql - Creates the database, schema and tables.
2. Now execute insert_values.sql to insert values into table
Note: We have both user defined values and inserting values from CSV files 
    execute import statements based on your requirements.
3. Now you can other files which contains queries, performance improvement queries.


## Author
```
Parashuram V Pawar
GitHub username: Parashuram-V-Pawar
```
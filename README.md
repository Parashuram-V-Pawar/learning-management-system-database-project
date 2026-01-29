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


## Author
```
Parashuram V Pawar
GitHub username: Parashuram-V-Pawar
```
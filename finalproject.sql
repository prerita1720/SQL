Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 29
Server version: 9.5.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> -- Create Database
Query OK, 0 rows affected (0.007 sec)

mysql> CREATE DATABASE UniversityDB;
ERROR 1007 (HY000): Can't create database 'universitydb'; database exists
mysql>
mysql> -- Use the Database
Query OK, 0 rows affected (0.004 sec)

mysql> USE UniversityDB;
Database changed
mysql>
mysql> CREATE TABLE Students (StudentID INT PRIMARY KEY,FirstName VARCHAR(50),LastName VARCHAR(50),Email VARCHAR(100),BirthDate DATE,EnrollmentDate DATE);
Query OK, 0 rows affected (0.250 sec)

mysql> CREATE TABLE Departments (
    -> DepartmentID INT PRIMARY KEY,
    -> DepartmentNRame VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.210 sec)

mysql>
mysql> CREATE TABLE Courses (CourseID INT PRIMARY KEY,CourseName VARCHAR(100),DepartmentID INT,Credits INT,FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));
Query OK, 0 rows affected (0.614 sec)

mysql>
mysql> CREATE TABLE Instructors (InstructorID INT PRIMARY KEY,FirstName VARCHAR(50),LastName VARCHAR(50),Email VARCHAR(100),DepartmentID INT,Salary DECIMAL(10,2),FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));
Query OK, 0 rows affected (0.431 sec)

mysql>
mysql> CREATE TABLE Enrollments (
    -> EnrollmentID INT PRIMARY KEY,
    -> StudentID INT,
    -> CourseID INT,
    -> EnrollmentDate DATE,
    -> FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    -> FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
    -> );
Query OK, 0 rows affected (0.552 sec)

mysql>
mysql> INSERT INTO Departments VALUES
    -> (1, 'Computer Science'),
    -> (2, 'Mathematics');
Query OK, 2 rows affected (0.065 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Students VALUES
    -> (1, 'prerita', 'Dev', 'prerita.dev@email.com', '2000-01-15', '2022-08-01'),
    -> (2, 'diya', 'payal', 'diya.payal@email.com', '1999-05-25', '2021-08-01');
Query OK, 2 rows affected (0.073 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Courses VALUES
    -> (101, 'Introduction to SQL', 1, 3),
    -> (102, 'Data Structures', 2, 4);
Query OK, 2 rows affected (0.076 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Instructors VALUES
    -> (1, 'vishal', 'ravindra', 'vishal.ravindra@univ.com', 2, 60000),
    -> (2, 'kavya', 'raj', 'kavya.raj@univ.com', 2, 65000);
Query OK, 2 rows affected (0.068 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Enrollments VALUES(1, 1, 101, '2022-08-01'),(2, 2, 102, '2021-08-01');
Query OK, 2 rows affected (0.084 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Students VALUES
    -> (3, 'Rahul', 'Verma', 'rahul@email.com', '2001-04-10', '2023-08-01');
Query OK, 1 row affected (0.053 sec)

mysql>
mysql> SELECT * FROM Students;
+-----------+-----------+----------+-----------------------+------------+----------------+
| StudentID | FirstName | LastName | Email                 | BirthDate  | EnrollmentDate |
+-----------+-----------+----------+-----------------------+------------+----------------+
|         1 | prerita   | Dev      | prerita.dev@email.com | 2000-01-15 | 2022-08-01     |
|         2 | diya      | payal    | diya.payal@email.com  | 1999-05-25 | 2021-08-01     |
|         3 | Rahul     | Verma    | rahul@email.com       | 2001-04-10 | 2023-08-01     |
+-----------+-----------+----------+-----------------------+------------+----------------+
3 rows in set (0.007 sec)

mysql>
mysql> UPDATE Students
    -> SET Email = 'prerita.new@email.com'
    -> WHERE StudentID = 1;
Query OK, 1 row affected (0.057 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> DELETE FROM Students WHERE StudentID = 3;
Query OK, 1 row affected (0.051 sec)

mysql>
mysql> SELECT *FROM StudentsWHERE EnrollmentDate > '2022-12-31';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '> '2022-12-31'' at line 1
mysql>
mysql> SELECT *
    -> FROM Students
    -> WHERE EnrollmentDate > '2022-12-31';
Empty set (0.012 sec)

mysql>
mysql> SELECT c.*
    -> FROM Courses c
    -> JOIN Departments d ON c.DepartmentID = d.DepartmentID
    -> WHERE d.DepartmentName = 'Mathematics'
    -> LIMIT 5;
ERROR 1054 (42S22): Unknown column 'd.DepartmentName' in 'where clause'
mysql>
mysql> SELECT CourseID, COUNT(StudentID) AS TotalStudents
    -> FROM Enrollments
    -> GROUP BY CourseID
    -> HAVING COUNT(StudentID) > 5;
Empty set (0.029 sec)

mysql>
mysql> SELECT s.StudentID, s.FirstName, s.LastName
    -> FROM Students s
    -> WHERE s.StudentID IN (
    -> SELECT e1.StudentID
    -> FROM Enrollments e1
    -> JOIN Courses c1 ON e1.CourseID = c1.CourseID
    -> WHERE c1.CourseName = 'Introduction to SQL'
    -> )
    -> AND s.StudentID IN (
    -> SELECT e2.StudentID
    -> FROM Enrollments e2
    -> JOIN Courses c2 ON e2.CourseID = c2.CourseID
    -> WHERE c2.CourseName = 'Data Structures'
    -> );
Empty set (0.025 sec)

mysql>
mysql> SELECT DISTINCT s.*
    -> FROM Students s
    -> JOIN Enrollments e ON s.StudentID = e.StudentID
    -> JOIN Courses c ON e.CourseID = c.CourseID
    -> WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');
+-----------+-----------+----------+-----------------------+------------+----------------+
| StudentID | FirstName | LastName | Email                 | BirthDate  | EnrollmentDate |
+-----------+-----------+----------+-----------------------+------------+----------------+
|         1 | prerita   | Dev      | prerita.new@email.com | 2000-01-15 | 2022-08-01     |
|         2 | diya      | payal    | diya.payal@email.com  | 1999-05-25 | 2021-08-01     |
+-----------+-----------+----------+-----------------------+------------+----------------+
2 rows in set (0.030 sec)

mysql>
mysql> SELECT AVG(Credits) AS AverageCredits
    -> FROM Courses;
+----------------+
| AverageCredits |
+----------------+
|         3.5000 |
+----------------+
1 row in set (0.011 sec)

mysql>
mysql> SELECT MAX(Salary) AS MaxSalary
    -> FROM Instructors i
    -> JOIN Departments d ON i.DepartmentID = d.DepartmentID
    -> WHERE d.DepartmentName = 'Computer Science';
ERROR 1054 (42S22): Unknown column 'd.DepartmentName' in 'where clause'
mysql>
mysql>
mysql> SELECT d.DepartmentName, COUNT(DISTINCT e.StudentID) AS TotalStudentsFROM Departments dJOIN Courses c ON d.DepartmentID = c.DepartmentIDJOIN Enrollments e ON c.CourseID = e.CourseIDGROUP BY d.DepartmentName;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Departments dJOIN Courses c ON d.DepartmentID = c.DepartmentIDJOIN Enrollments e' at line 1
mysql>
mysql>
mysql> SELECT s.FirstName, s.LastName, c.CourseName
    -> FROM Students s
    -> INNER JOIN Enrollments e ON s.StudentID = e.StudentID
    -> INNER JOIN Courses c ON e.CourseID = c.CourseID;
+-----------+----------+---------------------+
| FirstName | LastName | CourseName          |
+-----------+----------+---------------------+
| prerita   | Dev      | Introduction to SQL |
| diya      | payal    | Data Structures     |
+-----------+----------+---------------------+
2 rows in set (0.016 sec)

mysql> SELECT s.FirstName, s.LastName, c.CourseName
    -> FROM Students s
    -> LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
    -> LEFT JOIN Courses c ON e.CourseID = c.CourseID;
+-----------+----------+---------------------+
| FirstName | LastName | CourseName          |
+-----------+----------+---------------------+
| prerita   | Dev      | Introduction to SQL |
| diya      | payal    | Data Structures     |
+-----------+----------+---------------------+
2 rows in set (0.010 sec)

mysql>
mysql> SELECT *
    -> FROM Students
    -> WHERE StudentID IN (
    -> SELECT StudentID
    -> FROM Enrollments
    -> WHERE CourseID IN (
    -> SELECT CourseID
    -> FROM Enrollments
    -> GROUP BY CourseID
    -> HAVING COUNT(StudentID) > 10
    -> )
    -> );
Empty set (0.033 sec)

mysql>
mysql> SELECT StudentID,
    -> YEAR(EnrollmentDate) AS EnrollmentYear
    -> FROM Students;
+-----------+----------------+
| StudentID | EnrollmentYear |
+-----------+----------------+
|         1 |           2022 |
|         2 |           2021 |
+-----------+----------------+
2 rows in set (0.013 sec)

mysql>
mysql> SELECT CONCAT(FirstName, ' ', LastName) AS FullNameFROM Instructors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Instructors' at line 1
mysql>
mysql>
mysql>
mysql> SELECT CourseID,
    -> COUNT(StudentID) AS TotalStudents,
    -> SUM(COUNT(StudentID)) OVER (ORDER BY CourseID) AS RunningTotal
    -> FROM Enrollments
    -> GROUP BY CourseID;
+----------+---------------+--------------+
| CourseID | TotalStudents | RunningTotal |
+----------+---------------+--------------+
|      101 |             1 |            1 |
|      102 |             1 |            2 |
+----------+---------------+--------------+
2 rows in set (0.025 sec)

mysql>
mysql> SELECT StudentID, FirstName, LastName,
    -> CASE
    -> WHEN EnrollmentDate <= DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    -> THEN 'Senior'
    -> ELSE 'Junior'
    -> END AS Status
    -> FROM Students;
+-----------+-----------+----------+--------+
| StudentID | FirstName | LastName | Status |
+-----------+-----------+----------+--------+
|         1 | prerita   | Dev      | Junior |
|         2 | diya      | payal    | Senior |
+-----------+-----------+----------+--------+
2 rows in set (0.014 sec)

mysql>
Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 9.5.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE DataTransformer;
Query OK, 1 row affected (0.205 sec)

mysql>
mysql> USE DataTransformer;
Database changed
mysql>
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50),
    ->     Email VARCHAR(100),
    ->     RegistrationDate DATE
    -> );
Query OK, 0 rows affected (0.494 sec)

mysql>
mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY,
    ->     CustomerID INT,
    ->     OrderDate DATE,
    ->     TotalAmount DECIMAL(10,2),
    ->     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    -> );
Query OK, 0 rows affected (1.271 sec)

mysql>
mysql> CREATE TABLE Employees (
    ->     EmployeeID INT PRIMARY KEY,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50),
    ->     Department VARCHAR(50),
    ->     HireDate DATE,
    ->     Salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.223 sec)

mysql>
mysql> INSERT INTO Customers VALUES
    -> (1,'John','Doe',' john.doe@email.com ','2022-03-15'),
    -> (2,'Jane','Smith','jane.smith@email.com','2021-11-02'),
    -> (3,'Amit','Shah','amit@email.com','2023-01-10');
Query OK, 3 rows affected (0.147 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Orders VALUES
    -> (101,1,'2023-07-01',150.50),
    -> (102,2,'2023-07-03',200.75),
    -> (103,1,'2023-08-10',1200.00);
Query OK, 3 rows affected (0.120 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Employees VALUES
    -> (1,'Mark','Johnson','Sales','2020-01-15',50000),
    -> (2,'Susan','Lee','HR','2021-03-20',55000),
    -> (3,'Rahul','Mehta','IT','2019-06-12',75000);
Query OK, 3 rows affected (0.075 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> SELECT * FROM Customers;
+------------+-----------+----------+----------------------+------------------+
| CustomerID | FirstName | LastName | Email                | RegistrationDate |
+------------+-----------+----------+----------------------+------------------+
|          1 | John      | Doe      |  john.doe@email.com  | 2022-03-15       |
|          2 | Jane      | Smith    | jane.smith@email.com | 2021-11-02       |
|          3 | Amit      | Shah     | amit@email.com       | 2023-01-10       |
+------------+-----------+----------+----------------------+------------------+
3 rows in set (0.011 sec)

mysql> SELECT * FROM Orders;
+---------+------------+------------+-------------+
| OrderID | CustomerID | OrderDate  | TotalAmount |
+---------+------------+------------+-------------+
|     101 |          1 | 2023-07-01 |      150.50 |
|     102 |          2 | 2023-07-03 |      200.75 |
|     103 |          1 | 2023-08-10 |     1200.00 |
+---------+------------+------------+-------------+
3 rows in set (0.007 sec)

mysql> SELECT * FROM Employees;
+------------+-----------+----------+------------+------------+----------+
| EmployeeID | FirstName | LastName | Department | HireDate   | Salary   |
+------------+-----------+----------+------------+------------+----------+
|          1 | Mark      | Johnson  | Sales      | 2020-01-15 | 50000.00 |
|          2 | Susan     | Lee      | HR         | 2021-03-20 | 55000.00 |
|          3 | Rahul     | Mehta    | IT         | 2019-06-12 | 75000.00 |
+------------+-----------+----------+------------+------------+----------+
3 rows in set (0.011 sec)

mysql>
mysql> SELECT o.OrderID, o.OrderDate, o.TotalAmount,
    ->        c.FirstName, c.LastName
    -> FROM Orders o
    -> INNER JOIN Customers c
    -> ON o.CustomerID = c.CustomerID;
+---------+------------+-------------+-----------+----------+
| OrderID | OrderDate  | TotalAmount | FirstName | LastName |
+---------+------------+-------------+-----------+----------+
|     101 | 2023-07-01 |      150.50 | John      | Doe      |
|     102 | 2023-07-03 |      200.75 | Jane      | Smith    |
|     103 | 2023-08-10 |     1200.00 | John      | Doe      |
+---------+------------+-------------+-----------+----------+
3 rows in set (0.029 sec)

mysql>
mysql> SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
    -> FROM Customers c
    -> LEFT JOIN Orders o
    -> ON c.CustomerID = o.CustomerID;
+------------+-----------+---------+-------------+
| CustomerID | FirstName | OrderID | TotalAmount |
+------------+-----------+---------+-------------+
|          1 | John      |     101 |      150.50 |
|          1 | John      |     103 |     1200.00 |
|          2 | Jane      |     102 |      200.75 |
|          3 | Amit      |    NULL |        NULL |
+------------+-----------+---------+-------------+
4 rows in set (0.035 sec)

mysql>
mysql> SELECT o.OrderID, o.TotalAmount,
    ->        c.FirstName, c.LastName
    -> FROM Orders o
    -> RIGHT JOIN Customers c
    -> ON o.CustomerID = c.CustomerID;
+---------+-------------+-----------+----------+
| OrderID | TotalAmount | FirstName | LastName |
+---------+-------------+-----------+----------+
|     101 |      150.50 | John      | Doe      |
|     103 |     1200.00 | John      | Doe      |
|     102 |      200.75 | Jane      | Smith    |
|    NULL |        NULL | Amit      | Shah     |
+---------+-------------+-----------+----------+
4 rows in set (0.017 sec)

mysql>
mysql> SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
    -> FROM Customers c
    -> LEFT JOIN Orders o
    -> ON c.CustomerID = o.CustomerID
    ->
    -> UNION
    ->
    -> SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
    -> FROM Customers c
    -> RIGHT JOIN Orders o
    -> ON c.CustomerID = o.CustomerID;
+------------+-----------+---------+-------------+
| CustomerID | FirstName | OrderID | TotalAmount |
+------------+-----------+---------+-------------+
|          1 | John      |     103 |     1200.00 |
|          1 | John      |     101 |      150.50 |
|          2 | Jane      |     102 |      200.75 |
|          3 | Amit      |    NULL |        NULL |
+------------+-----------+---------+-------------+
4 rows in set (0.076 sec)

mysql>
mysql> SELECT *
    -> FROM Customers
    -> WHERE CustomerID IN (
    ->     SELECT CustomerID
    ->     FROM Orders
    ->     WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders)
    -> );
+------------+-----------+----------+----------------------+------------------+
| CustomerID | FirstName | LastName | Email                | RegistrationDate |
+------------+-----------+----------+----------------------+------------------+
|          1 | John      | Doe      |  john.doe@email.com  | 2022-03-15       |
+------------+-----------+----------+----------------------+------------------+
1 row in set (0.028 sec)

mysql>
mysql> SELECT *
    -> FROM Employees
    -> WHERE Salary > (SELECT AVG(Salary) FROM Employees);
+------------+-----------+----------+------------+------------+----------+
| EmployeeID | FirstName | LastName | Department | HireDate   | Salary   |
+------------+-----------+----------+------------+------------+----------+
|          3 | Rahul     | Mehta    | IT         | 2019-06-12 | 75000.00 |
+------------+-----------+----------+------------+------------+----------+
1 row in set (0.032 sec)

mysql>
mysql> SELECT OrderID,
    ->        YEAR(OrderDate) AS OrderYear,
    ->        MONTH(OrderDate) AS OrderMonth
    -> FROM Orders;
+---------+-----------+------------+
| OrderID | OrderYear | OrderMonth |
+---------+-----------+------------+
|     101 |      2023 |          7 |
|     102 |      2023 |          7 |
|     103 |      2023 |          8 |
+---------+-----------+------------+
3 rows in set (0.042 sec)

mysql>
mysql> SELECT OrderID,
    ->        DATEDIFF(CURDATE(), OrderDate) AS DaysDifference
    -> FROM Orders;
+---------+----------------+
| OrderID | DaysDifference |
+---------+----------------+
|     101 |            956 |
|     102 |            954 |
|     103 |            916 |
+---------+----------------+
3 rows in set (0.039 sec)

mysql>
mysql> SELECT OrderID,
    ->        DATE_FORMAT(OrderDate,'%d-%b-%Y') AS FormattedDate
    -> FROM Orders;
+---------+---------------+
| OrderID | FormattedDate |
+---------+---------------+
|     101 | 01-Jul-2023   |
|     102 | 03-Jul-2023   |
|     103 | 10-Aug-2023   |
+---------+---------------+
3 rows in set (0.024 sec)

mysql>
mysql> SELECT CONCAT(FirstName,' ',LastName) AS FullName
    -> FROM Customers;
+------------+
| FullName   |
+------------+
| John Doe   |
| Jane Smith |
| Amit Shah  |
+------------+
3 rows in set (0.015 sec)

mysql>
mysql> SELECT REPLACE(FirstName,'John','Jonathan') AS NewName
    -> FROM Customers;
+----------+
| NewName  |
+----------+
| Jonathan |
| Jane     |
| Amit     |
+----------+
3 rows in set (0.022 sec)

mysql>
mysql> SELECT UPPER(FirstName) AS UpperName,
    ->        LOWER(LastName) AS LowerName
    -> FROM Customers;
+-----------+-----------+
| UpperName | LowerName |
+-----------+-----------+
| JOHN      | doe       |
| JANE      | smith     |
| AMIT      | shah      |
+-----------+-----------+
3 rows in set (0.040 sec)

mysql>
mysql> SELECT TRIM(Email) AS CleanEmail
    -> FROM Customers;
+----------------------+
| CleanEmail           |
+----------------------+
| john.doe@email.com   |
| jane.smith@email.com |
| amit@email.com       |
+----------------------+
3 rows in set (0.031 sec)

mysql>
mysql> SELECT OrderID,
    ->        OrderDate,
    ->        TotalAmount,
    ->        SUM(TotalAmount) OVER(ORDER BY OrderDate) AS RunningTotal
    -> FROM Orders;
+---------+------------+-------------+--------------+
| OrderID | OrderDate  | TotalAmount | RunningTotal |
+---------+------------+-------------+--------------+
|     101 | 2023-07-01 |      150.50 |       150.50 |
|     102 | 2023-07-03 |      200.75 |       351.25 |
|     103 | 2023-08-10 |     1200.00 |      1551.25 |
+---------+------------+-------------+--------------+
3 rows in set (0.047 sec)

mysql>
mysql> SELECT OrderID,
    ->        TotalAmount,
    ->        RANK() OVER(ORDER BY TotalAmount DESC) AS OrderRank
    -> FROM Orders;
+---------+-------------+-----------+
| OrderID | TotalAmount | OrderRank |
+---------+-------------+-----------+
|     103 |     1200.00 |         1 |
|     102 |      200.75 |         2 |
|     101 |      150.50 |         3 |
+---------+-------------+-----------+
3 rows in set (0.033 sec)

mysql>
mysql> SELECT OrderID,
    ->        TotalAmount,
    ->        CASE
    ->           WHEN TotalAmount > 1000 THEN '10% Discount'
    ->           WHEN TotalAmount > 500 THEN '5% Discount'
    ->           ELSE 'No Discount'
    ->        END AS Discount
    -> FROM Orders;
+---------+-------------+--------------+
| OrderID | TotalAmount | Discount     |
+---------+-------------+--------------+
|     101 |      150.50 | No Discount  |
|     102 |      200.75 | No Discount  |
|     103 |     1200.00 | 10% Discount |
+---------+-------------+--------------+
3 rows in set (0.015 sec)

mysql>
mysql> SELECT EmployeeID,
    ->        FirstName,
    ->        Salary,
    ->        CASE
    ->           WHEN Salary >= 70000 THEN 'High'
    ->           WHEN Salary >= 50000 THEN 'Medium'
    ->           ELSE 'Low'
    ->        END AS SalaryCategory
    -> FROM Employees;
+------------+-----------+----------+----------------+
| EmployeeID | FirstName | Salary   | SalaryCategory |
+------------+-----------+----------+----------------+
|          1 | Mark      | 50000.00 | Medium         |
|          2 | Susan     | 55000.00 | Medium         |
|          3 | Rahul     | 75000.00 | High           |
+------------+-----------+----------+----------------+
3 rows in set (0.016 sec)

mysql>


















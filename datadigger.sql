Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 21
Server version: 9.5.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE DataDigger;
ERROR 1007 (HY000): Can't create database 'datadigger'; database exists
mysql> USE DataDigger;
Database changed
mysql>
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100),
    ->     Email VARCHAR(100),
    ->     Address VARCHAR(255)
    -> );
ERROR 1050 (42S01): Table 'customers' already exists
mysql>
mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ->     CustomerID INT,
    ->     OrderDate DATE,
    ->     TotalAmount DECIMAL(10,2),
    ->     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    -> );
ERROR 1050 (42S01): Table 'orders' already exists
mysql>
mysql> CREATE TABLE Products (
    ->     ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ->     ProductName VARCHAR(100),
    ->     Price DECIMAL(10,2),
    ->     Stock INT
    -> );
ERROR 1050 (42S01): Table 'products' already exists
mysql>
mysql> CREATE TABLE OrderDetails (
    ->     OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    ->     OrderID INT,
    ->     ProductID INT,
    ->     Quantity INT,
    ->     SubTotal DECIMAL(10,2),
    ->     FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    ->     FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
    -> );
ERROR 1050 (42S01): Table 'orderdetails' already exists
mysql>
mysql> INSERT INTO Customers (Name, Email, Address) VALUES
    -> ('prerita', 'prerita@gmail.com', 'Delhi'),
    -> ('dev', 'dev@gmail.com', 'Mumbai'),
    -> ('payal', 'payal@gmail.com', 'Pune'),
    -> ('prachi', 'prachi@gmail.com', 'Bangalore'),
    -> ('diya', 'diya@gmail.com', 'Chennai');
Query OK, 5 rows affected (0.074 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
    -> (1, '2026-01-15', 2500),
    -> (2, '2026-01-20', 1800),
    -> (3, '2026-01-25', 3200),
    -> (1, '2026-02-01', 1500),
    -> (4, '2026-02-05', 4000);
Query OK, 5 rows affected (0.681 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Products (ProductName, Price, Stock) VALUES
    -> ('Laptop', 55000, 10),
    -> ('Mobile', 15000, 20),
    -> ('Headphones', 1200, 15),
    -> ('Keyboard', 800, 0),
    -> ('Monitor', 7000, 8);
Query OK, 5 rows affected (0.042 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
    -> (1, 1, 1, 55000),
    -> (1, 3, 2, 2400),
    -> (2, 2, 1, 15000),
    -> (3, 5, 1, 7000),
    -> (4, 4, 2, 1600);
Query OK, 5 rows affected (0.460 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> SELECT * FROM Customers;
+------------+---------+-------------------+-----------+
| CustomerID | Name    | Email             | Address   |
+------------+---------+-------------------+-----------+
|          1 | Alice   | alice@gmail.com   | Delhi     |
|          2 | Bob     | bob@gmail.com     | Hyderabad |
|          3 | Charlie | charlie@gmail.com | Pune      |
|          4 | David   | david@gmail.com   | Bangalore |
|          6 | Alice   | alice@gmail.com   | Delhi     |
|          7 | Bob     | bob@gmail.com     | Mumbai    |
|          8 | Charlie | charlie@gmail.com | Pune      |
|          9 | David   | david@gmail.com   | Bangalore |
|         10 | Emma    | emma@gmail.com    | Chennai   |
|         11 | prerita | prerita@gmail.com | Delhi     |
|         12 | dev     | dev@gmail.com     | Mumbai    |
|         13 | payal   | payal@gmail.com   | Pune      |
|         14 | prachi  | prachi@gmail.com  | Bangalore |
|         15 | diya    | diya@gmail.com    | Chennai   |
+------------+---------+-------------------+-----------+
14 rows in set (0.015 sec)

mysql>
mysql> UPDATE Customers
    -> SET Address = 'Hyderabad'
    -> WHERE CustomerID = 2;
Query OK, 0 rows affected (0.025 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql>
mysql> DELETE FROM Customers
    -> WHERE CustomerID = 5;
Query OK, 0 rows affected (0.013 sec)

mysql>
mysql> SELECT * FROM Customers
    -> WHERE Name = 'Alice';
+------------+-------+-----------------+---------+
| CustomerID | Name  | Email           | Address |
+------------+-------+-----------------+---------+
|          1 | Alice | alice@gmail.com | Delhi   |
|          6 | Alice | alice@gmail.com | Delhi   |
+------------+-------+-----------------+---------+
2 rows in set (0.017 sec)

mysql>
mysql> SELECT * FROM Orders
    -> WHERE CustomerID = 1;
+---------+------------+------------+-------------+
| OrderID | CustomerID | OrderDate  | TotalAmount |
+---------+------------+------------+-------------+
|       1 |          1 | 2026-01-15 |     2500.00 |
|       4 |          1 | 2026-02-01 |     1500.00 |
|       6 |          1 | 2026-01-15 |     2500.00 |
|       9 |          1 | 2026-02-01 |     1500.00 |
|      11 |          1 | 2026-01-15 |     2500.00 |
|      14 |          1 | 2026-02-01 |     1500.00 |
+---------+------------+------------+-------------+
6 rows in set (0.016 sec)

mysql>
mysql> UPDATE Orders
    -> SET TotalAmount = 3000
    -> WHERE OrderID = 2;
Query OK, 0 rows affected (0.007 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql>
mysql> DELETE FROM Orders
    -> WHERE OrderID = 5;
Query OK, 0 rows affected (0.007 sec)

mysql>
mysql> SELECT *
    -> FROM Orders
    -> WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;
+---------+------------+------------+-------------+
| OrderID | CustomerID | OrderDate  | TotalAmount |
+---------+------------+------------+-------------+
|       1 |          1 | 2026-01-15 |     2500.00 |
|       2 |          2 | 2026-01-20 |     3000.00 |
|       3 |          3 | 2026-01-25 |     3200.00 |
|       4 |          1 | 2026-02-01 |     1500.00 |
|       6 |          1 | 2026-01-15 |     2500.00 |
|       7 |          2 | 2026-01-20 |     1800.00 |
|       8 |          3 | 2026-01-25 |     3200.00 |
|       9 |          1 | 2026-02-01 |     1500.00 |
|      10 |          4 | 2026-02-05 |     4000.00 |
|      11 |          1 | 2026-01-15 |     2500.00 |
|      12 |          2 | 2026-01-20 |     1800.00 |
|      13 |          3 | 2026-01-25 |     3200.00 |
|      14 |          1 | 2026-02-01 |     1500.00 |
|      15 |          4 | 2026-02-05 |     4000.00 |
+---------+------------+------------+-------------+
14 rows in set (0.008 sec)

mysql>
mysql> SELECT
    ->     MAX(TotalAmount) AS Highest,
    ->     MIN(TotalAmount) AS Lowest,
    ->     AVG(TotalAmount) AS Average
    -> FROM Orders;
+---------+---------+-------------+
| Highest | Lowest  | Average     |
+---------+---------+-------------+
| 4000.00 | 1500.00 | 2585.714286 |
+---------+---------+-------------+
1 row in set (0.007 sec)

mysql>
mysql> SELECT * FROM Products
    -> ORDER BY Price DESC;
+-----------+-------------+----------+-------+
| ProductID | ProductName | Price    | Stock |
+-----------+-------------+----------+-------+
|         1 | Laptop      | 55000.00 |    10 |
|         6 | Laptop      | 55000.00 |    10 |
|        11 | Laptop      | 55000.00 |    10 |
|         2 | Mobile      | 16000.00 |    20 |
|         7 | Mobile      | 15000.00 |    20 |
|        12 | Mobile      | 15000.00 |    20 |
|         5 | Monitor     |  7000.00 |     8 |
|        10 | Monitor     |  7000.00 |     8 |
|        15 | Monitor     |  7000.00 |     8 |
|         3 | Headphones  |  1200.00 |    15 |
|         8 | Headphones  |  1200.00 |    15 |
|        13 | Headphones  |  1200.00 |    15 |
|         4 | Keyboard    |   800.00 |     0 |
|         9 | Keyboard    |   800.00 |     0 |
|        14 | Keyboard    |   800.00 |     0 |
+-----------+-------------+----------+-------+
15 rows in set (0.183 sec)

mysql>
mysql> UPDATE Products
    -> SET Price = 16000
    -> WHERE ProductID = 2;
Query OK, 0 rows affected (0.007 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql>
mysql> DELETE FROM Products
    -> WHERE Stock = 0;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`datadigger`.`orderdetails`, CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`))
mysql>
mysql> SELECT * FROM Products
    -> WHERE Price BETWEEN 500 AND 2000;
+-----------+-------------+---------+-------+
| ProductID | ProductName | Price   | Stock |
+-----------+-------------+---------+-------+
|         3 | Headphones  | 1200.00 |    15 |
|         4 | Keyboard    |  800.00 |     0 |
|         8 | Headphones  | 1200.00 |    15 |
|         9 | Keyboard    |  800.00 |     0 |
|        13 | Headphones  | 1200.00 |    15 |
|        14 | Keyboard    |  800.00 |     0 |
+-----------+-------------+---------+-------+
6 rows in set (0.028 sec)

mysql>
mysql> SELECT
    ->     MAX(Price) AS MostExpensive,
    ->     MIN(Price) AS Cheapest
    -> FROM Products;
+---------------+----------+
| MostExpensive | Cheapest |
+---------------+----------+
|      55000.00 |   800.00 |
+---------------+----------+
1 row in set (0.025 sec)

mysql>
mysql> SELECT *
    -> FROM OrderDetails
    -> WHERE OrderID = 1;
+---------------+---------+-----------+----------+----------+
| OrderDetailID | OrderID | ProductID | Quantity | SubTotal |
+---------------+---------+-----------+----------+----------+
|             1 |       1 |         1 |        1 | 55000.00 |
|             2 |       1 |         3 |        2 |  2400.00 |
|             6 |       1 |         1 |        1 | 55000.00 |
|             7 |       1 |         3 |        2 |  2400.00 |
|            11 |       1 |         1 |        1 | 55000.00 |
|            12 |       1 |         3 |        2 |  2400.00 |
+---------------+---------+-----------+----------+----------+
6 rows in set (0.017 sec)

mysql>
mysql> SELECT SUM(SubTotal) AS TotalRevenue
    -> FROM OrderDetails;
+--------------+
| TotalRevenue |
+--------------+
|    243000.00 |
+--------------+
1 row in set (0.021 sec)

mysql>
mysql> SELECT ProductID, SUM(Quantity) AS TotalSold
    -> FROM OrderDetails
    -> GROUP BY ProductID
    -> ORDER BY TotalSold DESC
    -> LIMIT 3;
+-----------+-----------+
| ProductID | TotalSold |
+-----------+-----------+
|         3 |         6 |
|         4 |         6 |
|         1 |         3 |
+-----------+-----------+
3 rows in set (0.044 sec)

mysql>
mysql> SELECT COUNT(*) AS TimesSold
    -> FROM OrderDetails
    -> WHERE ProductID = 1;
+-----------+
| TimesSold |
+-----------+
|         3 |
+-----------+
1 row in set (0.011 sec)

mysql> SELECT COUNT(*) AS TimesSold
    -> FROM OrderDetails
    -> WHERE ProductID = 1;
+-----------+
| TimesSold |
+-----------+
|         3 |
+-----------+
1 row in set (0.018 sec)

mysql>

















Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 19
Server version: 9.5.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> DROP DATABASE IF EXISTS SmartEventDB;
Query OK, 3 rows affected (1.152 sec)

mysql> CREATE DATABASE SmartEventDB;
Query OK, 1 row affected (0.057 sec)

mysql> USE SmartEventDB;
Database changed
mysql>
mysql> CREATE TABLE Venues (
    ->     venue_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     venue_name VARCHAR(100) NOT NULL,
    ->     location VARCHAR(100),
    ->     capacity INT
    -> );
Query OK, 0 rows affected (0.416 sec)

mysql>
mysql> CREATE TABLE Organizers (
    ->     organizer_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     organizer_name VARCHAR(100),
    ->     contact_email VARCHAR(100),
    ->     phone_number VARCHAR(15)
    -> );
Query OK, 0 rows affected (0.439 sec)

mysql>
mysql> CREATE TABLE Events (
    ->     event_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     event_name VARCHAR(100),
    ->     event_date DATE,
    ->     venue_id INT,
    ->     organizer_id INT,
    ->     ticket_price DECIMAL(10,2),
    ->     total_seats INT,
    ->     available_seats INT,
    ->     FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    ->     FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
    -> );
Query OK, 0 rows affected (0.623 sec)

mysql>
mysql> CREATE TABLE Attendees (
    ->     attendee_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     email VARCHAR(100),
    ->     phone_number VARCHAR(15)
    -> );
Query OK, 0 rows affected (0.430 sec)

mysql>
mysql> CREATE TABLE Tickets (
    ->     ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     event_id INT,
    ->     attendee_id INT,
    ->     booking_date DATE,
    ->     status ENUM('Confirmed','Cancelled','Pending'),
    ->     UNIQUE(event_id, attendee_id),
    ->     FOREIGN KEY (event_id) REFERENCES Events(event_id),
    ->     FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
    -> );
Query OK, 0 rows affected (0.863 sec)

mysql>
mysql> CREATE TABLE Payments (
    ->     payment_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     ticket_id INT,
    ->     amount_paid DECIMAL(10,2),
    ->     payment_status ENUM('Success','Failed','Pending'),
    ->     payment_date DATETIME,
    ->     FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
    -> );
Query OK, 0 rows affected (0.846 sec)

mysql>
mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.061 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.047 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.050 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.044 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
Query OK, 2 rows affected (0.054 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.045 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.050 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.039 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.028 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.034 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.035 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.061 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.026 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.030 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.029 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.050 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.028 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.026 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.041 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.039 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.037 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.034 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.026 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.028 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.034 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.029 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.030 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.033 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.053 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.040 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.050 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.033 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.038 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.037 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.029 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.029 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.044 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.038 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.036 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.038 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.060 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.030 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.048 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.037 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.028 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.026 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.029 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.034 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.024 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.029 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('Rahul Sharma','rahul@gmail.com','9000000001'),
    -> ('Priya Verma','priya@gmail.com','9000000002');
Query OK, 2 rows affected (0.042 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.028 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.033 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('Rahul Sharma','rahul@gmail.com','9000000001'),
    -> ('Priya Verma','priya@gmail.com','9000000002');
Query OK, 2 rows affected (0.030 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.027 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.066 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.033 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.030 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.039 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.030 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.397 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.394 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.503 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.358 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.298 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.331 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.282 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.288 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.283 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.289 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Venues (venue_name, location, capacity)
    -> VALUES
    -> ('Grand Hall','Mumbai',500),
    -> ('City Arena','Delhi',800);
Query OK, 2 rows affected (0.042 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Organizers (organizer_name, contact_email, phone_number)
    -> VALUES
    -> ('EventPro Ltd','eventpro@gmail.com','9876543210'),
    -> ('MegaEvents','mega@gmail.com','9123456780');
Query OK, 2 rows affected (0.061 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES
    -> ('Music Fest','2026-12-10',1,1,1000,500,200),
    -> ('Tech Expo','2026-11-05',2,2,1500,800,100);
Query OK, 2 rows affected (0.082 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Attendees (name,email,phone_number)
    -> VALUES
    -> ('prerita patel','prerita@gmail.com','9000000001'),
    -> ('dev joshi','dev@gmail.com','9000000002');
Query OK, 2 rows affected (0.068 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Tickets (event_id,attendee_id,booking_date,status)
    -> VALUES
    -> (1,1,CURDATE(),'Confirmed'),
    -> (2,2,CURDATE(),'Pending');
ERROR 1062 (23000): Duplicate entry '1-1' for key 'tickets.event_id'
mysql>
mysql> INSERT INTO Payments (ticket_id,amount_paid,payment_status,payment_date)
    -> VALUES
    -> (1,1000,'Success',NOW()),
    -> (2,1500,'Pending',NOW());
Query OK, 2 rows affected (0.048 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Events
    -> (event_name,event_date,venue_id,organizer_id,ticket_price,total_seats,available_seats)
    -> VALUES ('Art Show','2026-12-20',1,1,500,300,300);
Query OK, 1 row affected (0.037 sec)

mysql>
mysql> UPDATE Events SET ticket_price=1200 WHERE event_id=1;
Query OK, 1 row affected (0.205 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Events WHERE event_id=3;
Query OK, 1 row affected (0.049 sec)

mysql> SELECT * FROM Events WHERE event_name LIKE '%Music%';
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name | event_date | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
|        1 | Music Fest | 2026-12-10 |        1 |            1 |      1200.00 |         500 |             200 |
|        5 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|        7 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|        9 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       11 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       13 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       15 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       17 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       19 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       21 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       23 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       25 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       27 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       29 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       31 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
15 rows in set (0.032 sec)

mysql>
mysql> -- Upcoming events in Mumbai
Query OK, 0 rows affected (0.008 sec)

mysql> SELECT e.*
    -> FROM Events e
    -> JOIN Venues v ON e.venue_id=v.venue_id
    -> WHERE v.location='Mumbai';
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name | event_date | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
|        1 | Music Fest | 2026-12-10 |        1 |            1 |      1200.00 |         500 |             200 |
|        5 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|        7 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|        9 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       11 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       13 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       15 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       17 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       19 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       21 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       23 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       25 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       27 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       29 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       31 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       33 | Art Show   | 2026-12-20 |        1 |            1 |       500.00 |         300 |             300 |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
16 rows in set (0.023 sec)

mysql>
mysql> -- Top revenue events
Query OK, 0 rows affected (0.004 sec)

mysql> SELECT e.event_name,SUM(p.amount_paid) revenue
    -> FROM Events e
    -> JOIN Tickets t ON e.event_id=t.event_id
    -> JOIN Payments p ON t.ticket_id=p.ticket_id
    -> GROUP BY e.event_id
    -> ORDER BY revenue DESC
    -> LIMIT 5;
+------------+----------+
| event_name | revenue  |
+------------+----------+
| Tech Expo  | 24000.00 |
| Music Fest | 16000.00 |
+------------+----------+
2 rows in set (0.020 sec)

mysql>
mysql> SELECT *
    -> FROM Events
    -> WHERE MONTH(event_date)=12
    -> AND available_seats > total_seats*0.5;
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name | event_date | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
|       33 | Art Show   | 2026-12-20 |        1 |            1 |       500.00 |         300 |             300 |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
1 row in set (0.031 sec)

mysql>
mysql> SELECT *
    -> FROM Events
    -> WHERE NOT available_seats=0;
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
| event_id | event_name | event_date | venue_id | organizer_id | ticket_price | total_seats | available_seats |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
|        1 | Music Fest | 2026-12-10 |        1 |            1 |      1200.00 |         500 |             200 |
|        2 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|        4 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|        5 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|        6 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|        7 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|        8 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|        9 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       10 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       11 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       12 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       13 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       14 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       15 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       16 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       17 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       18 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       19 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       20 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       21 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       22 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       23 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       24 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       25 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       26 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       27 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       28 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       29 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       30 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       31 | Music Fest | 2026-12-10 |        1 |            1 |      1000.00 |         500 |             200 |
|       32 | Tech Expo  | 2026-11-05 |        2 |            2 |      1500.00 |         800 |             100 |
|       33 | Art Show   | 2026-12-20 |        1 |            1 |       500.00 |         300 |             300 |
+----------+------------+------------+----------+--------------+--------------+-------------+-----------------+
32 rows in set (0.011 sec)

mysql>
mysql> SELECT event_id,COUNT(*) attendees
    -> FROM Tickets
    -> GROUP BY event_id;
+----------+-----------+
| event_id | attendees |
+----------+-----------+
|        1 |         1 |
|        2 |         1 |
+----------+-----------+
2 rows in set (0.015 sec)

mysql>
mysql> SELECT e.event_name,SUM(p.amount_paid) revenue
    -> FROM Events e
    -> JOIN Tickets t ON e.event_id=t.event_id
    -> JOIN Payments p ON t.ticket_id=p.ticket_id
    -> GROUP BY e.event_id;
+------------+----------+
| event_name | revenue  |
+------------+----------+
| Music Fest | 16000.00 |
| Tech Expo  | 24000.00 |
+------------+----------+
2 rows in set (0.027 sec)

mysql>
mysql> SELECT SUM(amount_paid) total_revenue FROM Payments;
+---------------+
| total_revenue |
+---------------+
|      40000.00 |
+---------------+
1 row in set (0.028 sec)

mysql>
mysql> SELECT event_id
    -> FROM Tickets
    -> GROUP BY event_id
    -> ORDER BY COUNT(*) DESC
    -> LIMIT 1;
+----------+
| event_id |
+----------+
|        1 |
+----------+
1 row in set (0.011 sec)

mysql>
mysql> SELECT AVG(ticket_price) avg_price FROM Events;
+-------------+
| avg_price   |
+-------------+
| 1240.625000 |
+-------------+
1 row in set (0.013 sec)

mysql>
mysql>
mysql>
mysql>
mysql>
mysql> -- INNER JOIN
Query OK, 0 rows affected (0.009 sec)

mysql> SELECT e.event_name,v.venue_name
    -> FROM Events e
    -> INNER JOIN Venues v ON e.venue_id=v.venue_id;
+------------+------------+
| event_name | venue_name |
+------------+------------+
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Music Fest | Grand Hall |
| Tech Expo  | City Arena |
| Art Show   | Grand Hall |
+------------+------------+
32 rows in set (0.016 sec)

mysql>
mysql> -- LEFT JOIN unpaid
Query OK, 0 rows affected (0.003 sec)

mysql> SELECT a.name
    -> FROM Attendees a
    -> LEFT JOIN Tickets t ON a.attendee_id=t.attendee_id
    -> LEFT JOIN Payments p ON t.ticket_id=p.ticket_id
    -> WHERE p.payment_status!='Success' OR p.payment_status IS NULL;
+---------------+
| name          |
+---------------+
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| Rahul Sharma  |
| Priya Verma   |
| Rahul Sharma  |
| Priya Verma   |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
| prerita patel |
| dev joshi     |
+---------------+
46 rows in set (0.011 sec)

mysql>
mysql> -- FULL OUTER JOIN simulation
Query OK, 0 rows affected (0.003 sec)

mysql> SELECT a.name,t.ticket_id
    -> FROM Attendees a
    -> LEFT JOIN Tickets t ON a.attendee_id=t.attendee_id
    -> UNION
    -> SELECT a.name,t.ticket_id
    -> FROM Attendees a
    -> RIGHT JOIN Tickets t ON a.attendee_id=t.attendee_id;
+---------------+-----------+
| name          | ticket_id |
+---------------+-----------+
| prerita patel |         1 |
| dev joshi     |         2 |
| prerita patel |      NULL |
| dev joshi     |      NULL |
| Rahul Sharma  |      NULL |
| Priya Verma   |      NULL |
+---------------+-----------+
6 rows in set (0.030 sec)

mysql>
mysql> SELECT event_name
    -> FROM Events
    -> WHERE event_id IN (
    ->   SELECT event_id
    ->   FROM Tickets
    ->   GROUP BY event_id
    ->   HAVING COUNT(*)>1
    -> );
Empty set (0.041 sec)

mysql>
mysql> SELECT event_name,MONTH(event_date) month_no FROM Events;
+------------+----------+
| event_name | month_no |
+------------+----------+
| Music Fest |       12 |
| Tech Expo  |       11 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Music Fest |       12 |
| Tech Expo  |       11 |
| Art Show   |       12 |
+------------+----------+
32 rows in set (0.023 sec)

mysql>
mysql> SELECT event_name,
    -> DATEDIFF(event_date,CURDATE()) days_remaining
    -> FROM Events;
+------------+----------------+
| event_name | days_remaining |
+------------+----------------+
| Music Fest |            294 |
| Tech Expo  |            259 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Music Fest |            294 |
| Tech Expo  |            259 |
| Art Show   |            304 |
+------------+----------------+
32 rows in set (0.036 sec)

mysql>
mysql> SELECT e.event_name,
    -> SUM(p.amount_paid) revenue,
    -> RANK() OVER (ORDER BY SUM(p.amount_paid) DESC) rank_no
    -> FROM Events e
    -> JOIN Tickets t ON e.event_id=t.event_id
    -> JOIN Payments p ON t.ticket_id=p.ticket_id
    -> GROUP BY e.event_id;
+------------+----------+---------+
| event_name | revenue  | rank_no |
+------------+----------+---------+
| Tech Expo  | 24000.00 |       1 |
| Music Fest | 16000.00 |       2 |
+------------+----------+---------+
2 rows in set (0.041 sec)

mysql>
mysql>
mysql> SELECT event_name,
    -> CASE
    -> WHEN available_seats < total_seats*0.2 THEN 'High Demand'
    -> WHEN available_seats BETWEEN total_seats*0.2 AND total_seats*0.5
    -> THEN 'Moderate Demand'
    -> ELSE 'Low Demand'
    -> END demand_level
    -> FROM Events;
+------------+-----------------+
| event_name | demand_level    |
+------------+-----------------+
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Music Fest | Moderate Demand |
| Tech Expo  | High Demand     |
| Art Show   | Low Demand      |
+------------+-----------------+
32 rows in set (0.012 sec)

mysql> thankyou
    -> ------------------------project is over------------------------------

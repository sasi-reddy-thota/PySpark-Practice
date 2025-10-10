-- Active: 1758878859785@@127.0.0.1@3306@my_db
-- Create DataBase
CREATE DATABASE my_db

use my_db

-- Create Table
create table sasi(
    customer_id int PRIMARY KEY,
    users_name VARCHAR(20),
    dob DATE
)

-- insert values
insert into sasi values 
                (1,'sasi',date('2000-06-14'))
                ,(2,'sasi',date('2000-06-14'))
                ,(3,'sasi',date('2000-06-14'))
                ,(4,'sasi',date('2000-06-14'))

-- Querying the data

select * from sasi

-- add column to existing table
alter table sasi 
add phone_number VARCHAR(12)

-- delete a column
alter table sasi
drop phone_number

-- update values
update sasi
set users_name='ram'

update sasi 
set users_name='sasi'
where customer_id=1


-- delete records/all records
delete from sasi 

delete from sasi 
WHERE customer_id=4

-- deleting the table

drop table sasi 

TRUNCATE sasi 



-- problem -1459:

-- table creation

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    product_id INT
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

INSERT INTO Customers VALUES
(1, 'Winston'), (2, 'Jonathan'), (3, 'Annabelle'), (4, 'Marwan'), (5, 'Khaled');

INSERT INTO Orders VALUES
(1, '2020-07-31', 1, 1),
(2, '2020-07-30', 2, 2),
(3, '2020-08-29', 3, 3),
(4, '2020-07-29', 4, 1),
(5, '2020-06-10', 1, 2),
(6, '2020-08-01', 2, 1),
(7, '2020-08-01', 3, 1),
(8, '2020-08-03', 1, 2),
(9, '2020-08-07', 2, 3),
(10, '2020-07-15', 1, 2);

INSERT INTO Products VALUES
(1, 'keyboard', 120),
(2, 'mouse', 80),
(3, 'screen', 600),
(4, 'hard disk', 450);

SELECT * FROM Orders

explain WITH cte as(
    SELECT
        *
        ,FIRST_VALUE(order_date) OVER(PARTITION BY product_id ORDER BY order_date DESC) as recent_order_date
    FROM Orders
)
SELECT 
    p.product_name
    ,c.product_id
    ,c.order_id
    ,c.order_date
FROM cte as c
JOIN Products as p
ON c.product_id=p.product_id
WHERE order_date=recent_order_date
ORDER BY p.product_name,c.product_id



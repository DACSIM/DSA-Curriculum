-- In this file we will cover the following advance stuff:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Window Functions: AGGREGATES

/*
-- Explanation:
	A window function in SQL allows you to perform calculations across a set of table rows that are somehow related to the current row. 
	Unlike regular aggregate functions (such as SUM, COUNT, AVG), window functions do not group the result into a single output. 
	Instead, they return a value for every row while using a "window" of rows to perform the calculation.
*/

-- Let’s say we want to calculate the running total of sales for each salesperson, partitioned by their ID (so each salesperson gets their own total), 
-- and ordered by the order date.

SELECT *
FROM sales.salesorderheader;

SELECT 
    salesorderid,
    salespersonid,
    orderdate,
    totaldue,
    SUM(totaldue) OVER (PARTITION BY salespersonid ORDER BY orderdate) AS runningtotal
FROM sales.salesorderheader
WHERE salespersonid IS NOT NULL
ORDER BY 
    salespersonid, 
		orderdate;

-- Retrieving distinct active employee names along with salary statistics per department:

SELECT DISTINCT 
	department.name,
  MIN(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS minsalary, -- Minimum salary per department
	MAX(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS maxsalary, -- Maximum salary per department
	AVG(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS avgsalary, -- Average salary per department
	COUNT(employeedepartmenthistory.businessentityid) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS EmployeesPerDept 
FROM humanresources.employeepayhistory AS employeepayhistory
INNER JOIN humanresources.employeedepartmenthistory AS employeedepartmenthistory
        ON employeepayhistory.businessentityid = employeedepartmenthistory.businessentityid  
INNER JOIN humanresources.department AS department
        ON department.departmentid = employeedepartmenthistory.departmentid
WHERE employeedepartmenthistory.enddate IS NULL --Active  
ORDER BY 1;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Window Functions: 
	-- RANK: Assigns a rank to each row, with gaps in rank if there are ties.
	-- DENSE_RANK: Assigns a rank to each row, without gaps in rank for ties.
	-- ROW_NUMBER: Assigns a unique sequential number to each row, even with ties.

-- RANK:
-- Question: Write a query to find the top 5 salespeople based on their total sales. Use the RANK function to handle ties, meaning if 
-- two salespeople have the same total sales, they should have the same rank, but the next rank should be skipped.

SELECT 
    salesorderheader.salespersonid,
    SUM(salesorderheader.totaldue) AS totalsales,
    RANK() OVER (ORDER BY SUM(salesorderheader.totaldue) DESC) AS salesrank
FROM sales.salesorderheader AS salesorderheader
WHERE salesorderheader.salespersonid IS NOT NULL
GROUP BY salesorderheader.salespersonid
ORDER BY salesrank
LIMIT 5;

-- DENSE_RANK:
-- Question: Write a query to rank products by their ListPrice, ensuring that there are no gaps in the rank values even if some products have the same price.

SELECT 
    product.productid,
    product.name AS productname,
    product.listprice,
--     DENSE_RANK() OVER (ORDER BY product.listprice DESC) AS pricerank
    ROW_NUMBER() OVER (ORDER BY product.listprice DESC) AS pricerank --
-- 		RANK() OVER (ORDER BY product.listprice DESC) AS pricerank
FROM production.product AS product
ORDER BY pricerank;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LAG() and LEAD()

-- Write a query to show each sales order and its TotalDue, along with the previous order's TotalDue for the same customer. 
-- Use the LAG() function to retrieve the previous order’s total.

SELECT 
    salesorderid, 
    customerid, 
    orderdate, 
    totaldue, 
    LAG(totaldue, 1) OVER (PARTITION BY customerid ORDER BY orderdate) AS previousordertotal
FROM sales.salesorderheader
ORDER BY 
    customerid, 
		orderdate;
		
-- Write a query to display each order and its OrderDate, along with the next order's OrderDate for the same customer. 
-- Use the LEAD() function to retrieve the next order's date.

SELECT 
    salesorderid, 
    customerid, 
    orderdate, 
    LEAD(orderdate, 1) OVER (PARTITION BY customerid ORDER BY orderdate) AS nextorderdate
FROM 
    sales.salesorderheader
ORDER BY 
    customerid,
		orderdate;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Subqueries

-- Write a query to retrieve the customer ID and total amount of their orders, but only for customers who have placed orders with a total greater than 10,000. 
-- Use a subquery to filter the customers.

SELECT 
	customerid,
	SUM(totaldue) AS total_expenditure
FROM sales.salesorderheader
WHERE customerid IN (
	SELECT 
			customerid 
	FROM sales.salesorderheader 
	GROUP BY 1
	HAVING SUM(totaldue) > 100000
)
GROUP BY customerid;

-- Find the top 5 best sales person alongside their total sales using subquery and window function
SELECT 
    salespersonid, 
    totalsales 
FROM (
	SELECT 
		salespersonid, 
		SUM(totaldue) AS totalsales,
		RANK() OVER(ORDER BY SUM(totaldue) DESC) AS ranking
	FROM sales.salesorderheader 
	GROUP BY salespersonid
) AS sales_summary
WHERE ranking <= 5;

-- Q1: Write a query to retrieve products whose prices are above the average price in the database.
-- A1:

SELECT 
    name, 
    listprice 
FROM production.product 
WHERE listprice > (
	SELECT 
			AVG(listprice) 
	FROM production.product
);


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Common Table Expressions (CTEs)

-- Question: Write a query to calculate the average order amount for each customer using a CTE.
WITH averageorderamount AS (
	SELECT 
			customerid, 
			ROUND(AVG(totaldue), 2) AS avg_order_amount
	FROM sales.salesorderheader
	GROUP BY customerid
)

SELECT
	customerid, 
	avg_order_amount
FROM averageorderamount
ORDER BY 
	avg_order_amount DESC;

-- Question: Write a query to find the total quantity sold for each product using a CTE.
-- sales.salesorderdetail, production.product

WITH productsalesquantity AS (
	SELECT 
			productid, 
			SUM(orderqty) AS total_quantity_sold
	FROM sales.salesorderdetail
	GROUP BY productid
)

SELECT 
    psq.productid, 
    p.name, 
    psq.total_quantity_sold
FROM productsalesquantity psq
INNER JOIN production.product p 
				ON psq.productid = p.productid
ORDER BY total_quantity_sold DESC;


-- Q2: Write a query to retrieve the most recent order for each customer, using ROW_NUMBER() and a CTE to assign a unique rank to each order, starting with the most recent.
-- A2:

WITH rankedorders AS (
    SELECT 
        salesorderheader.customerid, 
        salesorderheader.salesorderid, 
        salesorderheader.orderdate,
        ROW_NUMBER() OVER (PARTITION BY salesorderheader.customerid ORDER BY salesorderheader.orderdate DESC) AS rownum
    FROM sales.salesorderheader AS salesorderheader
)

SELECT 
	customerid, 
	salesorderid, 
	orderdate
FROM rankedorders
WHERE rownum = 1
ORDER BY customerid;


-- Q3: What's the difference between CTE and subquery?
-- A3: Usability, CTE you can call on the question more than once!

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Temporary Tables

-- Write a query to first calculate the total sales amount for each salesperson and then, using the second CTE, calculate the average sales per salesperson. 
-- Display the salespersons who have above-average total sales.

-- First CTE: Calculate total sales for each salesperson
WITH salespersalesperson AS (
	SELECT 
		salespersonid, 
		SUM(totaldue) AS total_sales
	FROM sales.salesorderheader
	WHERE salespersonid IS NOT NULL
	GROUP BY salespersonid
),

-- Second CTE: Calculate the average total sales across all salespersons
averagesales AS (
	SELECT 
			AVG(total_sales) AS avg_sales
	FROM salespersalesperson
)

SELECT 
	sp.salespersonid, 
	sp.total_sales
INTO TEMPORARY TABLE temptable
FROM salespersalesperson sp
WHERE sp.total_sales > (
	SELECT 
		avg_sales
	FROM averagesales
)
ORDER BY sp.total_sales DESC;

SELECT * 
FROM temptable;

-- Used when you are handling alot of data and writing a very long and complex SQL script, especially helpful when creating a new table with new metrics to solve
-- a new problem statement.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a Database

CREATE DATABASE mydatabase;
-- Rmb to refresh!

-- The locale provider controls how text-related operations, like sorting and comparing strings, are handled based on language and regional rules. When creating a new database

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a Schema in the new database!

-- Change connection using the plug connector at the top
-- Change to mydatabase

CREATE SCHEMA leetcode;
CREATE SCHEMA personal;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating Tables

-- Let's populate some tables in our new database!

-- Loading CSV:

CREATE TABLE personal.persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);

SELECT * FROM personal.persons;

COPY personal.persons(first_name, last_name, dob, email)
FROM '/Users/junyeow/Desktop/persons.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM personal.persons;

-- Restoring an entire database
-- Restore the dvdrental database!


-- DROP tables in your schema

DROP TABLE personal.persons;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Inserting Data & Constraints

CREATE TABLE personal.employees (
	employee_id SERIAL PRIMARY KEY,               -- Primary key with auto-increment
	favourite_num INT,
	first_name VARCHAR(50) NOT NULL,              -- Cannot be NULL
	last_name VARCHAR(50) NOT NULL,               -- Cannot be NULL
	email VARCHAR(100) UNIQUE NOT NULL,           -- Must be unique and cannot be NULL
	hire_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Defaults to today's date if not specified
	salary NUMERIC(10, 2) CHECK (salary > 0)     -- Salary must be greater than 0
-- 	department_id INT REFERENCES departments(department_id) -- Foreign key referencing 'departments' example
);

-- Inserting valid data
INSERT INTO personal.employees (favourite_num, first_name, last_name, email, salary)
VALUES (7, 'John', 'Doe', 'john.doe@example.com', 50000.00),
			 (7, 'Jane', 'Smith', 'jane.smith@example.com', 60000.00);

SELECT * FROM personal.employees;

INSERT INTO personal.employees (favourite_num, first_name, last_name, email, hire_date, salary)
VALUES (8, 'Mark', 'Jones', 'mark.jones@example.com', '2023-01-15', 55000.00);

SELECT * FROM personal.employees;

DROP TABLE personal.employees;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Update & Delete Operations

-- Update the salary of an employee
UPDATE personal.employees
SET salary = salary + 5000
WHERE employee_id = 1;

SELECT * FROM personal.employees;

-- Delete an employee from the table
DELETE FROM personal.employees
WHERE employee_id = 3;

SELECT * FROM personal.employees;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stored Procedures

-- Stored procedures in PostgreSQL allow you to encapsulate SQL code in a reusable block that can perform actions like updates, inserts, and more.
-- Basically like python functions

-- Create a stored procedure to give a raise to an employee
CREATE OR REPLACE PROCEDURE personal.give_raise(_employee_id INT, _raise_amount NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE personal.employees
    SET salary = salary + _raise_amount
    WHERE employee_id = _employee_id;
END;
$$;

-- Call the stored procedure to give an employee a raise
CALL personal.give_raise(1, 3000);

SELECT * FROM personal.employees;

DROP PROCEDURE personal.give_raise(integer,numeric);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Functions *

-- Functions in PostgreSQL allow you to return values or perform calculations and return results. They can also be used in queries like any other expression.

-- Create a function to calculate annual salary
CREATE OR REPLACE FUNCTION personal.calculate_annual_salary(_employee_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    annual_salary NUMERIC;
BEGIN
    SELECT salary * 12 INTO annual_salary
    FROM personal.employees
    WHERE employee_id = _employee_id; -- Use the parameter _employee_id
    
    RETURN annual_salary;
END;
$$;

-- Get the annual salary of an employee
SELECT personal.calculate_annual_salary(1);

-- But you can do that using Views as well

CREATE VIEW personal.employee_annual_salaries AS
SELECT 
    employee_id, 
    salary, 
    salary * 12 AS annual_salary
FROM 
    personal.employees;

SELECT * FROM personal.employee_annual_salaries;

-- Q: So what's the difference between VIEWS and tables?
-- A: A view is a virtual table and a table is a database object that stores actual data.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Triggers *

-- Triggers are special procedures that are automatically invoked by PostgreSQL when certain events (like inserts, updates, or deletes) happen on a table.

-- Create a salary_log table to track salary changes
CREATE TABLE personal.salary_log (
    log_id SERIAL PRIMARY KEY,
    employee_id INT,
    old_salary NUMERIC,
    new_salary NUMERIC,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a trigger function to log salary changes
CREATE OR REPLACE FUNCTION personal.log_salary_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the old and new salary into the salary_log table
    INSERT INTO personal.salary_log (employee_id, old_salary, new_salary)
    VALUES (NEW.employee_id, OLD.salary, NEW.salary);
    
    RETURN NEW;
END;
$$;

-- Create a trigger to call the log_salary_change function on salary updates
CREATE TRIGGER salary_update_trigger
AFTER UPDATE OF salary
ON personal.employees
FOR EACH ROW
EXECUTE FUNCTION personal.log_salary_change();

-- Update an employee's salary to test the trigger
UPDATE personal.employees
SET salary = salary + 5000
WHERE employee_id = 1;

UPDATE personal.employees
SET salary = salary + 5000
WHERE employee_id = 2;

-- Check the salary_log table to see the changes logged
SELECT * FROM personal.salary_log;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

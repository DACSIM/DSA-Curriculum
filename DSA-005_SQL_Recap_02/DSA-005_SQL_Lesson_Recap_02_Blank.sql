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



-- Retrieving distinct active employee names along with salary statistics per department:

SELECT DISTINCT 


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

FROM sales.salesorderheader
ORDER BY 
    customerid,
    orderdate;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Subqueries

-- Write a query to retrieve the customer ID and total amount of their orders, but only for customers who have placed orders with a total greater than 10,000. 
-- Use a subquery to filter the customers.




-- Q1: Write a query to retrieve products whose prices are above the average price in the database.
-- A1:


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Common Table Expressions (CTEs)

-- Question: Write a query to calculate the average order amount for each customer using a CTE.


-- Question: Write a query to find the total quantity sold for each product using a CTE.
-- sales.salesorderdetail, production.product




-- Q2: Write a query to retrieve the most recent order for each customer, using ROW_NUMBER() and a CTE to assign a unique rank to each order, starting with the most recent.
-- A2:




-- Q3: What's the difference between CTE and subquery?
-- A3: 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Temporary Tables

-- Write a query to first calculate the total sales amount for each salesperson and then, using the second CTE, calculate the average sales per salesperson. 
-- Display the salespersons who have above-average total sales.

-- First CTE: Calculate total sales for each salesperson


-- Used when you are handling alot of data and writing a very long and complex SQL script, especially helpful when creating a new table with new metrics to solve
-- a new problem statement.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a Database


-- Rmb to refresh!

-- The locale provider controls how text-related operations, like sorting and comparing strings, are handled based on language and regional rules. When creating a new database

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a Schema in the new database!

-- Change connection using the plug connector at the top
-- Change to mydatabase



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



SELECT * FROM personal.persons;

-- Restoring an entire database
-- Restore the dvdrental database!


-- DROP tables in your schema

DROP TABLE personal.persons;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Inserting Data & Constraints

CREATE TABLE personal.employees (
    -- Primary key with auto-increment
    -- Just integer
    -- Cannot be NULL
    -- Cannot be NULL
    -- Must be unique and cannot be NULL
    -- Defaults to today's date if not specified
    -- Salary must be greater than 0
-- 	department_id INT REFERENCES departments(department_id) -- Foreign key referencing 'departments' example
);

-- Inserting valid data
INSERT INTO personal.employees ()
VALUES (7, 'John', 'Doe', 'john.doe@example.com', 50000.00),
			 (7, 'Jane', 'Smith', 'jane.smith@example.com', 60000.00);

SELECT * FROM personal.employees;

INSERT INTO personal.employees ()
VALUES (8, 'Mark', 'Jones', 'mark.jones@example.com', '2023-01-15', 55000.00);

SELECT * FROM personal.employees;

DROP TABLE personal.employees;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Update & Delete Operations

-- Update the salary of an employee


SELECT * FROM personal.employees;

-- Delete an employee from the table


SELECT * FROM personal.employees;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stored Procedures

-- Stored procedures in PostgreSQL allow you to encapsulate SQL code in a reusable block that can perform actions like updates, inserts, and more.
-- Basically like python functions

-- Create a stored procedure to give a raise to an employee


-- Call the stored procedure to give an employee a raise


SELECT * FROM personal.employees;

-- DROP PROCEDURE personal.give_raise(integer,numeric);

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

    
    RETURN annual_salary;
END;
$$;

-- Get the annual salary of an employee
SELECT personal.calculate_annual_salary(1);

-- But you can do that using Views as well



SELECT * FROM personal.employee_annual_salaries;

-- Q4: So what's the difference between VIEWS and tables?
-- A4: A view is a virtual table and a table is a database object that stores actual data.

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
    
    RETURN NEW;
END;
$$;

-- Create a trigger to call the log_salary_change function on salary updates


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

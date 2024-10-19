-- Recap SQL for DSA:

-- Refresher on how to perform basic query and how the database works:
-- SELECT Clause: everything = *
-- Select department table, the employee table and vendor table. Let's explore the database a little!



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT some columns:

-- Select only name, start time and end time.
-- humanresources.shift;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT DISTINCT values: Unique column value, humanresources.department

-- Distinct group names from department and businessentityid from jobcandidate



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LIMIT: As the name suggest it limits the number of *rows* shown at the end result

-- Limit the table productvendor to 10 rows, purchasing.productvendor


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT MDAS: Multiplcation/division/addition/subtraction

-- From the customer table Multiplcation/division/addition/subtraction the store_id

SELECT

FROM sales.customer
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Q1: SELECT the DISTINCT title, last name, middlename and first_name of each person from the person schema. Return only 231 rows.
--A1;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: = 

-- humanresources.employee


-- When dealing with NULL values
-- purchasing.productvendor


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: Arithmetic filter

-- From customer table, territoryid = 4
SELECT DISTINCT territoryid
FROM sales.customer
WHERE 
LIMIT 100;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: OR clause

-- From employee table, select either Design Engineer or Tool Designer
SELECT *
FROM humanresources.employee


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: AND clause

-- From employee, gender must be Male and maritalstatus must be single
SELECT * 
FROM humanresources.employee


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: Combined OR & AND clause

-- From the employee table pick either, marital status as single and gender male or marital status as married and gender female.
SELECT 
	jobtitle,
	gender,
	maritalstatus,
	vacationhours,
	sickleavehours
FROM humanresources.employee


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Example of poor formatting and logic using AND and OR clause
-- From the salesperson table select territory_id either 4 or 6 and salesquota either 250000 or 300000

SELECT *
FROM sales.salesperson

	
SELECT *
FROM sales.salesperson


--Note: AND takes higher priority than OR

-- Reformatted version:
-- The importance of having good SQL formatting when writing your SQL code.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: IN clause
--Q: Find all the employees whose birthdate fall on these dates. humanresources.employee

-- '1977-06-06'
-- '1984-04-30'
-- '1985-05-04'


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: LIKE clause
-- The placement of the wildcard, %, affects what is getting filtered out.

-- From the person table, select all the firstname starting with a 'J'
-- Works very similar to excel find function

SELECT *
FROM person.person


-- But what if you know the number of letters in the firstname?

SELECT *
FROM person.person


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- We can use things like UPPER() and LOWER() clause

SELECT *
FROM person.person


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: NOT clause

-- From the person table, lastname should not contain A in it.

SELECT *
FROM person.person


-- From the employee table, choose middle name that contain

SELECT *
FROM humanresources.employee


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- GROUP BY clause: For aggregate values
-- For us to use when we want to use aggregates.

-- From employee table, group by gender, humanresources.employee


-- We can also group more than one column



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- All the AGGREGATES!

SELECT
FROM humanresources.employee


-- Q2: Analyse if the marital status of each gender affects the number of vacation hours one will take
-- A2:



-- From employee table, ORDER BY hiredate, ASC and DESC

SELECT *
FROM humanresources.employee
-- hiredate earliest

SELECT *
FROM humanresources.employee
-- hiredate latest

-- Sort table using two or more values

SELECT 
FROM humanresources.employee

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- HAVING clause:
SELECT
FROM humanresources.employee

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: From the customer table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A3:


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OFFSET: Using the employee table find the other the other employees except the top 10 oldest employees.
SELECT 
	jobtitle,
	birthdate
FROM humanresources.employee


-- Q4: Another common whiteboard question, from the salesperson table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A4:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Best practise: When exploring a new table:
/*
	Why should we use the example mentioned below?
	1) We don't have to generate the entire table to understand what kind of information the table stores.
	2) Much faster using this compared to generating the entire multi-million row table
	3) So people don't think you are a noob
*/



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: INNER 1

-- Inner join to get product information along with its subcategory name and category name

SELECT *
FROM production.product;

SELECT *
FROM production.productsubcategory;

SELECT *
FROM production.productcategory;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: INNER 2
-- Let's create a base table in the humanresources schema, where we are able to get each employee's department history and department name

-- How I would like to approach the question! Finding out if there is any issue etc etc

-- Employee table -----------

SELECT *
FROM humanresources.employee;

-- Is it unique?

-- Unique table!
-----------------------------

-- Employee Department History table

SELECT *
FROM humanresources.employeedepartmenthistory;

-- Is it unique?

-- Not Unique table!
-----------------------------

-- Department table----------

SELECT *
FROM humanresources.department;

-- No unique form one!

-- Unique table!
-----------------------------

-- Let's find all the employee, their respecitve departments and the time they served there. Bonus if you can find out the duration in days each employee spent
-- in each department! Duration in days cannot be NULL.


				
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JOINS: LEFT

-- Q5: List all employees and their associated email addresses,  
-- display their full name and email address.

SELECT 

FROM humanresources.employee AS employee


-- Q6: Can LEFT JOIN cause duplication? How?
-- A6: It depends on the relationship that both tables share, if it is one to one unlikely and if one to many there could be
-- a chance for duplication.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: RIGHT
-- Write a query to retrieve all sales orders and their corresponding customers. If a sales order exists without an associated customer, 
-- include the sales order in the result.

SELECT 
    salesorderheader.salesorderid AS salesorderid, 
    salesorderheader.orderdate AS orderdate, 
    customer.customerid AS customerid, 
    customer.personid AS personid



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: FULL OUTER JOIN

-- Write a query to retrieve a list of all employees and customers, and if either side doesn't have a FirstName, 
-- use the available value from the other side. Use FULL OUTER JOIN and COALESCE.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: CROSS JOINS

-- Explanation: A CROSS JOIN in SQL combines every row from the first table with every row from the second table. This type of join creates a Cartesian product, 
-- meaning that if the first table has 10 rows and the second table has 5 rows, the result will have 10 * 5 = 50 rows. 
-- A CROSS JOIN does not require any relationship or matching columns between the two tables.

-- Example: Good for arranging one person to meet multiple people

-- Write a query to generate all possible combinations of product categories and product models. Show the category name and the model name.

SELECT 
	name
FROM production.productcategory;

SELECT 
	name
FROM production.productmodel;



-- Each category name is matched to each model name

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION, stacking the tables on top of each other without having duplicates



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION ALL: EVERYTHING

-- Write a query to retrieve all sales orders and purchase orders, displaying the order ID and order date. 
-- Use UNION ALL to combine the sales and purchase order data, keeping all duplicates.



-- Remember how they work and their functionalities

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STRING FUNCTION
-- DATE handling, CONCAT()

-- Getting parts of the date out

SELECT 

FROM sales.salesorderheader;

-- DATETIME manipulations

SELECT


	CURRENT_DATE + INTERVAL '10 days' AS add_days,

	CURRENT_DATE + INTERVAL '1 month' AS add_months
FROM sales.salesorderheader
WHERE territoryid = 1


-- Use string functions to format employee names and email addresses
SELECT

-- Very Important!
		
    UPPER(person.lastname) AS upperlastname,
	LOWER(person.lastname) AS lowerlastname,
		

		
    LEFT(emailaddress.emailaddress, 10) AS endemail,
	RIGHT(emailaddress.emailaddress, 10) AS startemail,
		
		
FROM person.person AS person
INNER JOIN person.emailaddress AS emailaddress
				ON person.businessentityid = emailaddress.businessentityid;


-- From the following table write a query in  SQL to find the  email addresses of employees and groups them by city. 
-- Return top ten rows.

SELECT 
	address.city,
	
FROM person.businessentityaddress AS businessentityaddress  
INNER JOIN person.address AS address
				ON businessentityaddress.addressid = address.addressid
INNER JOIN person.emailaddress AS emailaddress 
				ON businessentityaddress.businessentityid = emailaddress.businessentityid
GROUP BY address.city
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASE FUNCTION: CASE WHEN THEN ELSE END

-- Write a query to categorize sales orders based on the total amount (TotalDue). If the total amount is less than 1000, categorize it as "Low", 
-- if it's between 1000 and 5000, categorize it as "Medium", and if it's greater than 5000, categorize it as "High".

SELECT 
    salesorderheader.salesorderid AS salesorderid, 
    salesorderheader.totaldue AS totaldue,

FROM sales.salesorderheader AS salesorderheader;

-- Q7: Write a query to calculate bonuses for each employee. The bonus is calculated based on both their total sales and their length of employment:

-- If an employee has sales greater than 500,000 and has been employed for more than 5 years, they get a 15% bonus.
-- If their sales are greater than 500,000 but they’ve been employed for less than 5 years, they get a 10% bonus.
-- If their sales are between 100,000 and 500,000, they get a 5% bonus, regardless of years of service.
-- If their sales are less than 100,000, they get no bonus.

-- A7:


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
	department.name,

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

-- Write a query to show each sales order and its TotalDue, along with the previous order's TotalDue for the same customer and to display each order and its OrderDate, 
-- along with the next order's OrderDate for the same customer. 

-- Use the LEAD() function to retrieve the next order's date.
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
		
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Subqueries

-- Write a query to retrieve the customer ID and total amount of their orders, but only for customers who have placed orders with a total greater than 10,000. 
-- Use a subquery to filter the customers.



-- Find the top 5 best sales person alongside their total sales using subquery and window function
SELECT 
    salespersonid, 
    totalsales 
FROM (

) AS sales_summary
WHERE ranking <= 5;

-- Q8: Write a query to retrieve products whose prices are above the average price in the database.
-- A8:



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Common Table Expressions (CTEs)

-- Question: Write a query to calculate the average order amount for each customer using a CTE.




-- Q9: Write a query to find the total quantity sold for each product using a CTE. 
-- sales.salesorderdetail, production.product
-- A9:




-- Q10: Write a query to retrieve the most recent order for each customer, using ROW_NUMBER() and a CTE to assign a unique rank to each order, starting with the most recent.
-- A10: If time permits!




-- Q11: What's the difference between CTE and subquery?
-- A11: 

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



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Inserting Data & Constraints

CREATE TABLE personal.employees (

);

-- Inserting valid data
INSERT INTO personal.employees (favourite_num, first_name, last_name, email, salary)
VALUES (7, 'John', 'Doe', 'john.doe@example.com', 50000.00),
			 (7, 'Jane', 'Smith', 'jane.smith@example.com', 60000.00);

SELECT * FROM personal.employees;



SELECT * FROM personal.employees;


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

$$;

-- Get the annual salary of an employee

-- But you can do that using Views as well



SELECT * FROM personal.employee_annual_salaries;

-- Q12: So what's the difference between VIEWS and tables?
-- A12:
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

END;
$$;

-- Create a trigger to call the log_salary_change function on salary updates


-- Update an employee's salary to test the trigger




-- Check the salary_log table to see the changes logged
SELECT * FROM personal.salary_log;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Leetcode time!
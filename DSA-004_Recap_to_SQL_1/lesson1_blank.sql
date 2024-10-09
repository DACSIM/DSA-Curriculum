-- Refresher on how to perform basic query and how the database works:

-- SELECT Clause: everything = *

-- Select department table, the employee table and vendor table. Let's explore the database a little!



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT some columns:

-- Select only name, start time and end time.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT DISTINCT values: Unique column value

-- Distinct group names from department and businessentityid from jobcandidate



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- From different schemas: sales



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LIMIT: As the name suggest it limits the number of *rows* shown at the end result

-- Limit the table productvendor to 10 rows and purchaseorderdetail to 100 rows



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT MDAS: Multiplcation/division/addition/subtraction

-- From the customer table Multiplcation/division/addition/subtraction the store_id



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Q1: SELECT the DISTINCT title, last name, middlename and first_name of each person from the person schema. Return only 231 rows.
--A1;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: = 
-- gender is male


-- Only Research and Development


-- When dealing with NULL values


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: Arithmetic filter

-- From customer table, territoryid = 4


-- From person table, emailpromotion <> 0


-- From employee table, vacationhours >= 99


-- From employee table, sickleavehours <= 20


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: OR clause

-- From employee table, select either Design Engineer or Tool Designer


-- From product, select either Black or Silver


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: AND clause

-- From Vendor, preferredvendorstatus and activeflag must be TRUE


-- From employee, gender must be Male and maritalstatus must be single


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: Combined OR & AND clause

-- From the employee table pick either, marital status as single and gender male or marital status as married and gender female.


-- Example of poor formatting and logic.
-- From the salesperson table select territory_id either 4 or 6 and salesquota either 250000 or 300000

--


--


--Note: AND takes higher priority than OR

-- Reformatted version:
-- The importance of having good SQL formatting when writing your SQL code.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: IN clause
--Q: Find all the employees whose birthdate fall on these dates.

-- '1977-06-06'
-- '1984-04-30'
-- '1985-05-04'



-- Find all the middle names that contains either A or B or C.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: LIKE clause
-- The placement of the wildcard, %, affects what is getting filtered out.

-- From the person table, select all the firstname starting with a 'J'
-- Works very similar to excel find function

-- Find J

-- Only works for string!

-- But what if you know the number of letters in the firstname?

SELECT *
FROM person.person
WHERE firstname LIKE 'J___';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What if we want firstnames that contains the letter a inside?


-- not tallying

-- We have two varying results, we can use things like UPPER() and LOWER() clause


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: NOT clause

-- From the person table, lastname should not contain A in it.



-- From the employee table, choose middle name that contain



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- GROUP BY clause: For aggregate values
-- For us to use when we want to use aggregates.

-- From employee table, group by gender

SELECT 
	gender
FROM humanresources.employee
GROUP BY gender;

-- From employee table, group by maritalstatus



-- We can also group more than one column



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- All the AGGREGATES!



-- Q2: Analyse if the marital status of each gender affects the number of vacation hours one will take
-- A2:


-- From employee table, ORDER BY hiredate, ASC and DESC

-- hiredate earliest


-- hiredate latest


-- Sort table using two or more values


-- Sorting by Average


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- HAVING clause:


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: From the customer table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A3:



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OFFSET: Using the employee table find the other the other employees except the top 10 oldest employees.
SELECT *
FROM humanresources.employee
ORDER BY birthdate ASC;



-- Q4: From the salesperson table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
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

-- JOINS: INNER

-- Inner join to get product information along with its subcategory name and category name

SELECT *
FROM production.product;

SELECT *
FROM production.productsubcategory;

SELECT *
FROM production.productcategory;



-- Let's create a base table in the humanresources schema, where we are able to get each employee's department history and department name

-- Employee table

SELECT *
FROM humanresources.employee;

-- Unique table or?


-- Employee Department History table

SELECT *
FROM humanresources.employeedepartmenthistory;

-- Unique table or?


-- Department table

SELECT *
FROM humanresources.department;



-- Let's find all the employee, their respecitve departments and the time they served there. Bonus if you can find out the duration in days each employee spent
-- in each department! Duration in days cannot be NULL.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JOINS: LEFT

-- List all products along with their total sales quantities, including products that have never been sold. 
-- For products that have not been sold, display the sales quantity as zero.
-- Sort by total orders descending

SELECT *
FROM production.product;

SELECT *
FROM sales.salesorderdetail;



-- Q5: List all employees and their associated email addresses,  
-- display their full name and email address.


-- Retrieve a list of all individual customers id, firstname along with the total number of orders they have placed 
-- and the total amount they have spent, removing customers who have never placed an order. 

SELECT *
FROM person.person;

SELECT *
FROM sales.customer;

SELECT *
FROM sales.salesorderheader;



-- Q6: Can LEFT JOIN cause duplication? How?
-- A6: 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: RIGHT
-- Write a query to retrieve all sales orders and their corresponding customers. If a sales order exists without an associated customer, 
-- include the sales order in the result.

SELECT 
    salesorderheader.salesorderid AS salesorderid, 
    salesorderheader.orderdate AS orderdate, 
    customer.customerid AS customerid, 
    customer.personid AS personid
FROM sales.salesorderheader AS salesorderheader


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: FULL OUTER JOIN

-- Write a query to find all employees and their corresponding sales orders. If an employee doesn’t have any sales orders, 
-- still include them in the result, and if there are sales orders without an associated employee, include those as well.

SELECT 
    employee.businessentityid AS employeeid,
    salesorderheader.salesorderid
FROM humanresources.employee AS employee

		
-- Write a query to retrieve a list of all employees and customers, and if either side doesn't have a FirstName, 
-- use the available value from the other side. Use FULL OUTER JOIN and COALESCE.

SELECT 

FROM humanresources.employee AS employee

						 
-- Write a query to list all employees along with their associated sales orders. Include employees who may not have any sales orders. 
-- Use the COALESCE function to handle NULL values in the SalesOrderID column.

SELECT

FROM humanresources.employee AS employee

ORDER BY employee.employeeid;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: CROSS JOINS

-- Explanation: A CROSS JOIN in SQL combines every row from the first table with every row from the second table. This type of join creates a Cartesian product, 
-- meaning that if the first table has 10 rows and the second table has 5 rows, the result will have 10 * 5 = 50 rows. 
-- A CROSS JOIN does not require any relationship or matching columns between the two tables.

-- Example: Good for arranging one person to meet multiple people

-- Write a query to generate all possible combinations of product categories and product models. Show the category name and the model name.

SELECT 

FROM production.productcategory AS productcategory


-- Each category name is matched to each model name

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION, stacking the tables on top of each other without having duplicates



-- Union them together segregating employee and customer

SELECT *
FROM person.person;

SELECT *
FROM sales.customer;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION ALL: EVERYTHING

-- Write a query to retrieve all sales orders and purchase orders, displaying the order ID and order date. 
-- Use UNION ALL to combine the sales and purchase order data, keeping all duplicates.

SELECT 
	salesorderid AS orderid, 
	orderdate
FROM sales.salesorderheader

UNION ALL

SELECT 
	purchaseorderid AS orderid, 
	orderdate
FROM purchasing.purchaseorderheader;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STRING FUNCTION
-- DATE handling, CONCAT()

-- Getting parts of the date out

SELECT 

FROM sales.salesorderheader;

-- DATETIME manipulations

SELECT

FROM sales.salesorderheader
WHERE territoryid = 1
	AND EXTRACT(YEAR FROM orderdate) = 2011;

-- Use string functions to format employee names and email addresses
SELECT

FROM person.person AS person


-- From the following table write a query in  SQL to find the  email addresses of employees and groups them by city. 
-- Return top ten rows.

SELECT 
	address.city, 

FROM person.businessentityaddress AS businessentityaddress  

GROUP BY 
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASE FUNCTION: CASE WHEN THEN ELSE END

-- Categorize products based on their list price
SELECT 
	productid,
	name,
	listprice,

FROM production.product;

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

-- If time permits:
-- Window Functions
-- AGGREGATE

-- Explanation:
/*
A window function in SQL allows you to perform calculations across a set of table rows that are somehow related to the current row. 
Unlike regular aggregate functions (such as SUM, COUNT, AVG), window functions do not group the result into a single output. 
Instead, they return a value for every row while using a "window" of rows to perform the calculation.
*/

-- Let’s say we want to calculate the running total of sales for each salesperson, partitioned by their ID (so each salesperson gets their own total), 
-- and ordered by the order date.



-- Retrieving distinct active employee names along with salary statistics per department:


	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
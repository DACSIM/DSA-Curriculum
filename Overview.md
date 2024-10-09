# Introduction to SQL

Welcome to the **Introduction to SQL** class! In this course, we'll embark on a journey to understand and master **Structured Query Language (SQL)**, the standard language for interacting with relational databases.

<img align='center' src="https://i.pinimg.com/originals/0c/64/9a/0c649a17ec1e5f5ca340248b4ef4e4be.gif" width="750">

## Why SQL?

Structured data is organized in a predefined manner, often in tables with rows and columns, making it efficient to store, query, and manipulate. While there are many programming languages out there, SQL is uniquely designed to handle structured data efficiently. Here's why we use SQL over other languages:

- **Declarative Syntax**: SQL allows you to specify *what* data you want, not *how* to get it. This simplifies data retrieval and manipulation.
- **Optimized for Databases**: SQL is tailored for relational databases, providing optimized performance for data operations.
- **Standardization**: SQL is a standardized language, meaning skills are transferable across different database systems like PostgreSQL, MySQL, and Oracle.

## The Importance of Mastering SQL

Becoming proficient in SQL is invaluable in today's data-driven world. Here's how mastering SQL can benefit you in various fields:

- **Data Analytics**: Extract, analyze, and visualize data to inform business decisions.
- **Data Science**: Prepare and manipulate datasets for machine learning and statistical modeling.
- **Data Engineering**: Design and maintain databases and data pipelines for efficient data flow.
- **Software Development**: Integrate databases with applications for dynamic data handling.

By mastering SQL, you become a critical asset capable of turning raw data into actionable insights.

---

## Access to PostgreSQL

For this course, we'll use **PostgreSQL**, a powerful open-source relational database system. Follow the instructions below to download and set up PostgreSQL on your machine.

### Important Notes

- **Download the Latest Version**: Ensure you're downloading **PostgreSQL 17.0**.
- **Password Reminder**: Remember your database password; you'll need it to access your databases.

### Installation Instructions

#### Mac & Windows Users

- **Download Link**: [Installing PostgreSQL](https://docs.google.com/document/d/1Sv1GOYDYWkEm2irWPqRHd664w-qwFtQOC5sWgPl3lbw/edit?usp=sharing)

---

## Verifying PostgreSQL Installation

To confirm that PostgreSQL is installed correctly, use the `SQL Shell (psql)` command-line tool.<img align='centre' src="/Users/junyeow/Desktop/DAC-Curriculum/additional/psql.png" width="300">

### Steps to Verify Installation

1. **Open SQL Shell**

   - Click the SQL Shell (psql)

2. **Check PostgreSQL Version**

   ```bash
   \! psql --version
   ```

   - A successful installation will display the PostgreSQL version.

3. **Connect to the Default Database**

   ```bash
   psql -U postgres
   ```

   - Enter your password if prompted.
   - Successful connection indicates PostgreSQL is operational.

4. **List All Databases**

   ```sql
   \l
   ```

5. **Exit the psql Interface**

   ```sql
   \q
   ```

   - This will return you to the command prompt.

**Note**: If you encounter errors during these steps, please revisit the installation instructions or seek assistance from the excos.

---

## Curriculum Content

1. [Basic Queries](#basic-queries)
   - SELECT Statements
2. [WHERE](#where)
3. [Aggregate Functions & GROUP BY](#aggregate-functions--group-by)
4. [HAVING vs WHERE](#having-vs-where)
5. [Wildcards](#wildcards)
6. [LIMIT & Aliasing](#limit--aliasing)
7. [JOINS](#joins)
8. [UNIONS](#unions)
9. [String Functions](#string-functions)
10.[CASE Statements](#case-statements)
11.[Window Functions](#window-functions)
    - AGGREGATE
    - RANK
    - DENSE_RANK
    - ROW_NUMBER
12. [Subqueries](#subqueries)
13. [Common Table Expressions (CTEs)](#common-table-expressions-ctes)
14. [Temporary Tables](#temporary-tables)
15. [Stored Procedures](#stored-procedures)
16. [Database Introduction](#company-database-introduction)
17. [Creating a Database](#creating-a-company-database)
18. [Creating Schemas](#creating-tables)
19. [Creating Tables](#creating-tables)
20. [Constraints](#constraints)
21. [Inserting Data](#inserting-data)
22. [Update & Delete Operations](#update--delete-operations)
23. [Functions](#functions)
24. [Triggers](#triggers)

---

Feel free to navigate through the topics as we progress in the course. Happy learning! <3
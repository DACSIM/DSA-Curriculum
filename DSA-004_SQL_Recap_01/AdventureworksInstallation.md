# AdventureWorks Setup Using SQL Shell (psql)

This guide provides detailed instructions to set up the AdventureWorks OLTP database in PostgreSQL using the **SQL Shell (psql)** interface. AdventureWorks is a sample database provided by Microsoft, representing a fictitious bicycle parts wholesaler. It contains extensive data on HR, sales, products, and purchasing, organized across five schemas.

By following this guide within the SQL Shell, you will:

- Set up 68 tables containing HR, sales, product, and purchasing data.
- Work with a dataset that includes nearly 300 employees, 500 products, 20,000 customers, and 31,000 sales.
- Prepare a robust environment for learning SQL, ETL processes, and data warehousing concepts.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Open SQL Shell (psql)](#1-open-sql-shell-psql)
  - [2. Verify Current Directory](#2-verify-current-directory)
  - [3. Change Directory to AdventureWorks Files](#3-change-directory-to-adventureworks-files)
  - [4. Create the AdventureWorks Database](#4-create-the-adventureworks-database)
  - [5. Install the Database Schema and Data](#5-install-the-database-schema-and-data)
  - [6. Verify the Installation](#6-verify-the-installation)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)
- [Credits](#credits)

---

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **PostgreSQL** (version 9.6 or higher)
- **Ruby** (for running the CSV modification script) (Most  important!)
- **Git** (for cloning repositories)

### 1) Download the AdventureWorks Data Files

Git clone this repository and download the AdventureWorks 2014 OLTP Script from Microsoft's official repository:

```bash
git clone https://github.com/lorint/AdventureWorks-for-Postgres.git
```

### **Download Link**: [AdventureWorks 2014 OLTP Script](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks-oltp-install-script.zip) *Make sure you unzip the file!!

**Store this somewhere accessible!!!!!**

### 2) Copy all the CSV files from AdventureWorks 2014 OLTP Script into the AdventureWorks-for-Postgres folder.

It should look something like this! A mixture of both files in the folder.

<img align='centre' src="https://i.imgur.com/ibD5PiT.png" width="500">

### 3) Go to the directory where the repository is stored! In shell/terminal

```bash
cd /home/your_username/AdventureWorks-for-Postgres
```

### 4) Run the following command in your terminal/shell

```bash
ruby update_csvs.rb
```

---

## Getting Started

### 1. Open SQL Shell (psql)

Launch the **SQL Shell (psql)** application:

- Press `Enter` to accept the default values for **Server**, **Database**, and **Port**, unless you want to use your own specific custom settings. Should look something like this!

<img align='centre' src="https://i.imgur.com/RFTLXKw.jpeg" width="1000">

- When prompted, enter your PostgreSQL **username** (default is `postgres`).
- Enter your **password** if prompted.

### 2. Verify Current Directory

Within the SQL Shell, check your current working directory to ensure you are in the correct location:

For MacOS:
```sql
\! pwd
```

For Windows 11:
```sql
\! cd
```

- This command executes the shell command `pwd`, displaying the current directory path.
- **Example Output**:

  ```
  /home/your_username
  ```

Ensure that the `AdventureWorks-for-Postgres` directory is present in this location. If not, you'll need to navigate to the directory where you've placed the AdventureWorks files.

### 3. Change Directory to AdventureWorks Files

Navigate to the directory containing the AdventureWorks files:

```sql
\cd /path/to/AdventureWorks-for-Postgres
```

- Replace `/path/to/AdventureWorks-for-Postgres` with the actual path to your directory.
- For example:

  ```sql
  \cd /home/your_username/AdventureWorks-for-Postgres
  ```

Verify that you've changed to the correct directory:

For MacOS:
```sql
\! pwd
```

For Windows 11:
```sql
\! cd
```

- **Example Output**:

  ```
  /home/your_username/AdventureWorks-for-Postgres
  ```

List the files in the current directory to ensure all necessary files are present:

For MacOS:
```sql
\! ls
```

For Windows 11:
```sql
\! dir
```

- You should see the following files:

  ```
  install.sql  update_csvs.rb  ... (other CSV files)
  ```

### 4. Create the AdventureWorks Database

Within the SQL Shell, create a new database named `Adventureworks`:

```sql
CREATE DATABASE "Adventureworks";
```

- **Note**: Use double quotes if your database name has uppercase letters or special characters.

Connect to the newly created database:

```sql
\c Adventureworks
```

### 5. Install the Database Schema and Data

Run the `install.sql` script to set up the database schema and import data:

```sql
\i install.sql
```

- This command executes the `install.sql` script located in the current directory.
- The script will:

  - Create all 68 tables across the five schemas (`humanresources`, `person`, `production`, `purchasing`, `sales`).
  - Import data from the modified CSV files.
  - Convert `hierarchyid` columns.
  - Add primary and foreign keys.
  - Create available views (11 out of 20, excluding those relying on XML functions).

- **Note**: Ensure that the `install.sql` file is in the current directory and that all CSV files are correctly modified and present.

### 6. Verify the Installation

List all schemas to confirm they have been created:

```sql
\dn
```

- **Example Output**:

  ```
    List of schemas
    Name            |  Owner
  ------------------+----------
   humanresources   | postgres
   person           | postgres
   production       | postgres
   purchasing       | postgres
   sales            | postgres
   public           | postgres
  ```

List all tables in the schemas:

```sql
\dt (humanresources|person|production|purchasing|sales).*
```

- This command lists all tables within the specified schemas.
- **Example Output**:

  ```
               List of relations
    Schema        |       Name        | Type  |  Owner
  ----------------+-------------------+-------+----------
   humanresources | department        | table | postgres
   humanresources | employee          | table | postgres
   person         | person            | table | postgres
   production     | product           | table | postgres
   purchasing     | vendor            | table | postgres
   sales          | customer          | table | postgres
   ...            | ...               | ...   | ...
  ```

Check the first few rows of a table to verify data import:

```sql
SELECT * FROM person.person LIMIT 5;
```

- **Sample Output**:

  ```
   businessentityid | persontype | namestyle | title | firstname | middlename | lastname | suffix | emailpromotion | additionalcontactinfo | demographics | rowguid                              | modifieddate
  ------------------+------------+-----------+-------+-----------+------------+----------+--------+----------------+-----------------------+--------------+--------------------------------------+--------------
                 1 | EM         | f         | Mr.   | Ken       | J          | Sánchez  |        |              0 |                       |              | 92C4279F-1207-48A3-8448-4636514EB7E2 | 2009-01-07
                 2 | EM         | f         | Ms.   | Terri     | Lee        | Duffy    |        |              1 |                       |              | 92C4279F-1207-48A3-8448-4636514EB7E3 | 2009-01-07
                 3 | EM         | f         | Ms.   | Roberto   |            | Tamburello |      |              0 |                       |              | 92C4279F-1207-48A3-8448-4636514EB7E4 | 2009-01-07
                 4 | EM         | f         | Ms.   | Roberta   | A          | Tamburello |      |              2 |                       |              | 92C4279F-1207-48A3-8448-4636514EB7E5 | 2009-01-07
                 5 | EM         | f         | Ms.   | Gail      | A          | Erickson  |        |              0 |                       |              | 92C4279F-1207-48A3-8448-4636514EB7E6 | 2009-01-07
  (5 rows)
  ```

---

## Troubleshooting (MacOS)

- **psql Command Errors**: Ensure that you are correctly using SQL commands within the SQL Shell. Commands starting with `\` are `psql` meta-commands.

- **Incorrect Directory**: If you receive errors about missing files when running `\i install.sql`, verify your current directory:

  ```sql
  \! pwd
  ```

  Ensure you are in the directory containing `install.sql` and the CSV files. If not, change to the correct directory using:

  ```sql
  \cd /correct/path/to/AdventureWorks-for-Postgres
  ```

- **File Not Found Errors**: Ensure that all necessary files (`install.sql`, CSV files) are present in the current directory. List files using:

  ```sql
  \! ls
  ```

- **Authentication Errors**: If you encounter authentication errors when creating the database or connecting, verify your PostgreSQL user's credentials.

---

## Troubleshooting (Windows 11)

- **psql Command Errors**: Ensure that you are correctly using SQL commands within the SQL Shell. Commands starting with `\` are `psql` meta-commands.

- **Incorrect Directory**: If you receive errors about missing files when running `\i install.sql`, verify your current directory:

  ```sql
  \! cd
  ```

  Ensure you are in the directory containing `install.sql` and the CSV files. If not, change to the correct directory using:

  ```sql
  \cd /correct/path/to/AdventureWorks-for-Postgres
  ```

- **File Not Found Errors**: Ensure that all necessary files (`install.sql`, CSV files) are present in the current directory. List files using:

  ```sql
  \! dir
  ```

- **Authentication Errors**: If you encounter authentication errors when creating the database or connecting, verify your PostgreSQL user's credentials.

---

## Additional Resources

- **AdventureWorks-for-Postgres Repository**: [https://github.com/lorint/AdventureWorks-for-Postgres](https://github.com/lorint/AdventureWorks-for-Postgres)
- **Microsoft's AdventureWorks Sample Databases**: [https://github.com/Microsoft/sql-server-samples](https://github.com/Microsoft/sql-server-samples)
- **PostgreSQL Official Documentation**: [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)
- **psql Command Reference**: [https://www.postgresql.org/docs/current/app-psql.html](https://www.postgresql.org/docs/current/app-psql.html)

---

### **Quick Command Reference (MacOS)** 

Here is a summary of the key commands used within the SQL Shell:

- **Check Current Directory**:

  ```sql
  \! pwd
  ```

- **Change Directory**:

  ```sql
  \cd /path/to/directory
  ```

- **Create Database**:

  ```sql
  CREATE DATABASE "DatabaseName";
  ```

- **Connect to a Database**:

  ```sql
  \c DatabaseName
  ```

- **Execute a SQL Script**:

  ```sql
  \i script_name.sql
  ```

- **List Schemas**:

  ```sql
  \dn
  ```

- **List Tables in Schemas**:

  ```sql
  \dt schema_name.*
  ```

- **Exit SQL Shell**:

  ```sql
  \q
  ```
---
### **Quick Command Reference (Windows 11)** 

Here is a summary of the key commands used within the SQL Shell:

- **Check Current Directory**:

  ```sql
  \! cd
  ```

- **Change Directory**:

  ```sql
  cd path\to\directory
  ```

- **Create Database**:

  ```sql
  CREATE DATABASE database_name;
  ```

- **Connect to a Database**:

  ```sql
  \c database_name
  ```

- **Execute a SQL Script**:

  ```sql
  \i script.sql
  ```

- **List Schemas**:

  ```sql
  \dn
  ```

- **List Tables in Schemas**:

  ```sql
  \dt schema_name.*
  ```

- **Exit SQL Shell**:

  ```sql
  \q
  ```
---

**Note**: Commands beginning with `\` are `psql` meta-commands executed within the SQL Shell. Commands beginning with `\!` allow you to execute shell commands from within `psql`.

---
## Credits

- **Original Scripts and Conversion Tools**: [Lorin Thwaits](https://github.com/lorint)
- **AdventureWorks Sample Data**: [Microsoft Corporation](https://www.microsoft.com/)

---

By following this guide within the **SQL Shell (psql)**, you should have a fully functional AdventureWorks database in PostgreSQL, ready for exploration, learning, and development.

---
If you have any questions or encounter issues, please refer to the [Troubleshooting](#troubleshooting) section or consult the excos.

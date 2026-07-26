/*
===============================================================================
MIS443 - Assignment 2: PostgreSQL Database Development and SQL Practice

Group        : D2NB
Student      : Do Hoang Bao
Student ID   : 2232300071
Instructor   : Mr. Dang Thai Doan
Quarter      : 4 (2025–2026)
Schema       : Banking (SQL Practice Online)

File         : 03 - Import Data.sql

===============================================================================

OVERVIEW
--------
This file imports the sample CSV data into the Banking database.

PREREQUISITES
-------------
• All tables have been created.
• CSV data files are available.
• pgAdmin 4

WORKFLOW
--------
1. Open Import/Export Data.
2. Select the CSV file.
3. Set Format = CSV.
4. Enable Header.
5. Import the data.
6. Repeat for each table.

HOW TO IMPORT DATA
------------------
In pgAdmin:

Right-click the table
→ Import/Export Data...
→ Import

Settings

• Format : CSV
• Header : Yes

Import the files in the following order:

branches
    ↓
customers
    ↓
accounts
    ↓
transactions
    ↓
loans

This order prevents foreign key constraint violations.

===============================================================================
*/
/*
===============================================================================
MIS443 - Assignment 2: PostgreSQL Database Development and SQL Practice

Group        : D2NB
Student      : Do Hoang Bao
Student ID   : 2232300071
Instructor   : Mr. Dang Thai Doan
Quarter      : 4 (2025–2026)
Schema       : Banking (SQL Practice Online)

File         : 02 - Create Tables.sql

===============================================================================

OVERVIEW
--------
This file creates all tables and defines the relationships
between them.

PREREQUISITES
-------------
• Banking database
• PostgreSQL 18
• pgAdmin 4

WORKFLOW
--------
1. Create the branches table.
2. Create the customers table.
3. Create the accounts table.
4. Create the transactions table.
5. Create the loans table.
6. Define all primary keys and foreign keys.

HOW TO RUN THIS FILE
--------------------
Run this file with the Query Tool connected to the
"Banking" database.

Parent tables must be created before child tables:

branches
    ↓
customers
    ↓
accounts
    ↓
transactions
    ↓
loans

===============================================================================
*/

create table branches(
	branch_id int primary key,
	branch_name varchar(100),
	city varchar(50),
	sate varchar(2)
	);

create table customers(
	customer_id int primary key,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(100),
	branch_id int,
		foreign key (branch_id) 
			references branches(branch_id),
	account_opended_date date
	);

create table accounts(
	account_id int primary key,
	customer_id int ,
		foreign key (customer_id) 
			references customers(customer_id),
	account_type varchar(20),
	balance real,
	opened_date date
	);

create table transactions (
	transaction_id int primary key,
	account_id int,
		foreign key (account_id) 
			references account(account_id)
	transaction_type varchar(20),
	account real,
	trasaction_date date
	);

create table loans(
	loan_id int primary key,
	customer_id int,
		foreign key (customer_id) 
			references customers(customer_id),
	loan_account real,
	interst_rate real,
	status varchar(20),
	start_date date
	);
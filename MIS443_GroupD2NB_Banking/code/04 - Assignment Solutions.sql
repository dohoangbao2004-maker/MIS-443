/*
===============================================================================
MIS443 - Assignment 2: PostgreSQL Database Development and SQL Practice

Group        : D2NB
Student      : Do Hoang Bao
Student ID   : 2232300071
Instructor   : Mr. Dang Thai Doan
Quarter      : 4 (2025–2026)
Schema       : Banking (SQL Practice Online)

File         : 04 - Assignment Solutions.sql

===============================================================================

OVERVIEW
--------
This file contains SQL solutions for Questions 1–30.

PREREQUISITES
-------------
• Banking database
• All tables created
• Sample data imported successfully

CONTENTS
--------
• Basic Queries
• Filtering and Sorting
• Aggregate Functions
• Joins
• Subqueries
• Common Table Expressions (CTEs)
• Window Functions

HOW TO USE
----------
Run each query independently after the database has been
created and populated with the required sample data.

===============================================================================
*/

/*Q1: The customer relations team is conducting a full audit of the client master list.
Return the complete customer roster from the customers table.
	Output: Include every customer column.
	Rules: Do not filter out any customers.*/
select * from customers;

/*Q2: The branch network team needs a directory of all branch locations for the annual report.
Return all branch names and their cities.
	Output: Return branch_name and city.
	Rules: Do not filter out any branches.*/
select branch_name, city from branches;

/*Q3: The retail team is reviewing the savings account portfolio for a product performance report.
Return all accounts with account type Savings.
	Output: Return account_id, customer_id, and balance.
	Rules: Only include accounts where account_type = 'Savings'.*/
select account_id, customer_id, balance
	from accounts
	where account_type = 'Savings';
	
/*Q4: The risk team wants to flag high-value accounts that may qualify for a premium tier review.
Return accounts with a balance greater than $10,000.
	Output: Return customer_id, account_type, and balance.
	Rules: Only include accounts where balance > 10000., Order by balance.
*/
select customer_id, account_type, balance
	from accounts
	where balance > 10000
	order by balance;
	
/*Q5: The operations team is reconciling all inbound cash flows and needs a full list of deposit transactions.
Return all transactions of type Deposit.
	Output: Return transaction_id, account_id, amount, and transaction_date.
	Rules: Only include transactions where transaction_type = 'Deposit'., Order by transaction_date.*/
select transaction_id, account_id, account, trasaction_date
	from transactions
	where transaction_type = 'Deposit'
	order by trasaction_date;
	
/*Q6: The credit team is reviewing all currently active loan obligations for quarterly reporting.
Return all loans with an Active status.
	Output: Return loan_id, customer_id, loan_amount, and interest_rate.
	Rules: Only include loans where status = 'Active'.*/
select loan_id, customer_id, loan_account, interst_rate
	from loans
	where status = 'Active';
	
/*Q7: Operations needs a single count of all accounts currently open across the bank.
Count the total number of accounts.
	Output: Return the count as total_accounts.
	Rules: Return exactly one row.*/
select count(*) as total_accounts
	from accounts;
	
/*Q8: Treasury needs the total deposit inflow across all accounts for the period reconciliation.
Sum the total amount across all Deposit transactions.
	Output: Return the sum as total_deposits.
	Rules: Only include transactions where transaction_type = 'Deposit'., 
		Return exactly one row.*/
select sum(account) as total_deposits
	from transactions
	where transaction_type = 'Deposit';
	
/*Q9: The product team needs a list of all account types offered. 
Find all unique account types available. 
	Show account_type ordered alphabetically.
*/
select distinct account_type
	from accounts
	order by account_type;
/*Q10: The audit team needs to review mid-month activity. 
Find all transactions where transaction_date is between January 10 and January 20, 2025 (inclusive). 
	Show transaction_id, account_id, amount, and transaction_date. 
	Order by transaction_date.
*/
select transaction_id, account_id, account, trasaction_date
	from transactions
	where trasaction_date between '2025-01-10' and '2025-01-20'
	order by trasaction_date;
	
/*Q11: The new-accounts team wants to follow up with registered customers who have not yet opened any account. 
Find all customers who have no accounts. 
	Show first name and last name.
*/
select c.first_name, c.last_name
	from customers c
	left join accounts a 
		on c.customer_id = a.customer_id
	where a.account_id is null
	order by c.last_name;
	
/*Q12: The loans department needs to identify customers who have not taken any loan — potential targets for a new loan campaign. 
Find all customers who have no loans. 
	Show first name and last name ordered by last name.
*/
select c.first_name, c.last_name
	from customers c
	left join loans l 
		on c.customer_id = l.customer_id
	where l.loan_id is null
	order by c.last_name;
/*Q13: The relationship management team wants to know how diversified each customer's portfolio is. 
Show every customer's full name and the number of accounts they hold (including zero). 
	Order by account_count descending, then last name.
*/
select	c.first_name, c.last_name, 
		count(a.account_id) as account_count
	from customers c
	left join accounts a 
		on c.customer_id = a.customer_id
	group by c.customer_id, c.first_name, c.last_name
	order by account_count desc, c.last_name;

/*Q14: The finance team is preparing a balance summary broken down by account product type.
Calculate the total balance for each account type.
	Output: Return account_type and total_balance.
	Rules: Group by account_type., 
		Order by account_type.*/
select	account_type,
		sum(balance) as total_balance
from accounts
group by account_type
order by account_type;

/*Q15: The relationship management team needs each customer paired with their assigned branch for outreach planning.
Medium
Return each customer's name alongside their branch name.
	Output: Return first_name, last_name, and branch_name.
	Rules: Use a JOIN between customers and branches., 
		Order by last_name.*/
select	c.first_name,
		c.last_name,
		b.branch_name
from customers c
join branches b
	on c.branch_id = b.branch_id
order by c.last_name;

/*Q16: Compliance needs a full transaction log enriched with account holder identities for review.
Medium
Return each transaction with the transaction date, amount, type, and the customer's last name.
	Output: Return transaction_date, amount, transaction_type, and last_name.
	Rules: Use JOINs across transactions, accounts, and customers., 
		Order by transaction_date.*/
select	t.trasaction_date,
		t.account,
		t.transaction_type,
		c.last_name
from transactions t
join accounts a
	on t.account_id = a.account_id
join customers c
	on a.customer_id = c.customer_id
order by t.trasaction_date,
		 t.transaction_id;

/*Q17: The branch performance team needs a headcount of active customers per branch to measure branch utilisation.
Medium
Return the number of customers assigned to each branch.
	Output: Return branch_name and customer_count.
	Rules: Use LEFT JOIN so branches with zero customers still appear., 
		Group by branch., 
		Order by branch_id.*/
select	b.branch_name,
		count(c.customer_id) as customer_count
from branches b
left join customers c
	on b.branch_id = c.branch_id
group by b.branch_id,
		 b.branch_name
order by b.branch_id;

/*Q18: The product team is measuring how many accounts each customer holds to identify cross-sell opportunities.
Medium
Return the number of accounts held by each customer.
	Output: Return customer_id and account_count.
	Rules: Group by customer_id., 
		Order by customer_id.*/
select	customer_id,
		count(*) as account_count
from accounts
group by customer_id
order by customer_id;

/*Q19: The loan servicing team needs a customer-level view of all loan obligations and their current status.
Medium
Return each loan with the borrower's first and last name, loan amount, and status.
	Output: Return first_name, last_name, loan_amount, and status.
	Rules: Use a JOIN between loans and customers., 
		Order by loan_amount descending.*/
select	c.first_name,
		c.last_name,
		l.loan_account,
		l.status
from loans l
join customers c
	on l.customer_id = c.customer_id
order by l.loan_account desc;

/*Q20: The regional director needs to see which branches hold the most total deposits across all customer accounts.
Medium
Return the total account balance held by customers at each branch.
	Output: Return branch_name and total_balance.
	Rules: JOIN branches, customers, and accounts., 
		Group by branch_name., 
		Order by total_balance descending.*/
select	b.branch_name,
		sum(a.balance) as total_balance
from branches b
join customers c
	on b.branch_id = c.branch_id
join accounts a
	on c.customer_id = a.customer_id
group by b.branch_name
order by total_balance desc;

/*Q21: The branch operations team wants a portfolio view of every customer's holdings. 
Show each customer's name, their branch name, account type, and balance. 
	Order by branch name, then customer last name.
*/
select	c.first_name,
		c.last_name,
		b.branch_name,
		a.account_type,
		a.balance
from customers c
join accounts a
	on c.customer_id = a.customer_id
join branches b
	on c.branch_id = b.branch_id
order by b.branch_name,
		 c.last_name;

/*Q22: For each account that has transactions, show total deposits and total withdrawals side by side using conditional aggregation. 
	Order by account_id.
*/
select	account_id,
		sum(
			case
				when transaction_type = 'deposit' then account
				else 0
			end
		) as total_deposits,

		sum(
			case
				when transaction_type = 'withdrawal' then account
				else 0
			end
		) as total_withdrawals

from transactions
group by account_id
order by account_id;

/*Q23: Group transactions by year-month (using strftime). 
Show month, transaction count, and total amount. 
	Order by month ascending.
*/
select	to_char(trasaction_date, 'yyyy-mm') as month,
		count(*) as transaction_count,
		sum(account) as total_amount
from transactions
group by month
order by month;

/*Q24: The operations team wants to contact customers who have never used their accounts. 
Find customers who have no transactions in any of their accounts. 
	Show first name and last name.
*/
select	c.first_name,
		c.last_name
from customers c
where not exists (
	select 1
	from accounts a
	join transactions t
		on a.account_id = t.account_id
	where a.customer_id = c.customer_id
)
order by c.last_name;

/*Q25: Create a cash flow list combining all deposits (labelled 'Income') 
and all withdrawals (labelled 'Expense') into one unified report. 
Show account_id, amount, flow_type, and transaction_date. 
	Order by transaction_date.
*/
select	account_id,
		account,
		'income' as flow_type,
		trasaction_date
from transactions
where transaction_type = 'deposit'

union all

select	account_id,
		account,
		'expense' as flow_type,
		trasaction_date
from transactions
where transaction_type = 'withdrawal'

order by trasaction_date;

/*Q26: Find the customer with the largest total active loan amount. 
Show first name, last name, and total_loans. Only include Active loans.*/
select	c.first_name,
		c.last_name,
		sum(l.loan_account) as total_loans
from customers c
join loans l
	on c.customer_id = l.customer_id
where l.status = 'active'
group by c.customer_id,
		 c.first_name,
		 c.last_name
order by total_loans desc
limit 1;

/*Q27: The wealth management team wants to identify accounts performing above their peer group. 
Find accounts with a balance above the average balance for their account_type. 
	Show account_id, account_type, balance, and customer name.
*/
select	a.account_id,
		a.account_type,
		a.balance,
		c.first_name,
		c.last_name
from accounts a
join customers c
	on a.customer_id = c.customer_id
where a.balance > (
	select avg(balance)
	from accounts a2
	where a2.account_type = a.account_type
)
order by a.account_type,
		 a.balance desc;

/*Q28: Rank accounts by balance within each account type using a window function. 
Show account_id, account_type, balance, and balance_rank. 
	Order by account_type, then rank.
*/
select	account_id,
		account_type,
		balance,
		rank() over (
			partition by account_type
			order by balance desc
		) as balance_rank
from accounts
order by account_type,
		 balance_rank;

/*Q29: The branch management team wants to identify the top depositor at each location. 
Find the customer with the highest total account balance in each branch. 
	Show first name, last name, branch name, and total_balance.
*/
with customer_balances as (
	select	c.customer_id,
			c.first_name,
			c.last_name,
			c.branch_id,
			sum(a.balance) as total_balance
	from customers c
	join accounts a
		on c.customer_id = a.customer_id
	group by c.customer_id,
			 c.first_name,
			 c.last_name,
			 c.branch_id
),
ranked as (
	select	*,
			rank() over (
				partition by branch_id
				order by total_balance desc
			) as rnk
	from customer_balances
)

select	r.first_name,
		r.last_name,
		b.branch_name,
		r.total_balance
from ranked r
join branches b
	on r.branch_id = b.branch_id
where r.rnk = 1
order by b.branch_name;

/*Q30: The product team wants a breakdown of account distribution by balance tier. 
Using a CTE, classify accounts into tiers: High (balance >= 10000), Medium (balance >= 3000), Low (below 3000). 
Show each tier's account count, average balance, and total balance. 
	Order by avg_balance descending.
*/
with account_tiers as (
	select	account_id,
			account_type,
			balance,
			case
				when balance >= 10000 then 'high'
				when balance >= 3000 then 'medium'
				else 'low'
			end as tier
	from accounts
)

select	tier,
		count(*) as account_count,
		round(avg(balance)::numeric, 2) as avg_balance,
		sum(balance) as total_balance
from account_tiers
group by tier
order by avg_balance desc;
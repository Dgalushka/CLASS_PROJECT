
-- CREATE A DATA BASE AND A TABLE TO LOAD OUR DATA FILE INTO


create database if not exists
credit_card_classification;

create table if not exists 

credit_card_data
(Customer_Number INT,
Offer_Accepted VARCHAR(100),
Reward VARCHAR(100),
Mailer_Type VARCHAR(100),
Income_Level VARCHAR(100),
Bank_accounts_open INT,
Overdraft_Protection VARCHAR(100),
Credit_Rating VARCHAR(100),
Credit_Cards_Held INT,
Homes_Owned INT,
Household_Size INT,
Own_Your_Home VARCHAR(100),
Average_Balance FLOAT,
Q1_Balance FLOAT,
Q2_Balance FLOAT,
Q3_Balance FLOAT,
Q4_Balance FLOAT);

SHOW VARIABLES LIKE 'local_infile';
use credit_card_classification;


-- COMPLETE TABLE VIEW

SELECT * FROM credit_card_data;



-- DROPPING Q4

alter table credit_card_data
drop column Q4_Balance;

select * from credit_card_data limit 10;



-- CHECKING THE NUMBER OF ROWS IN OUR DATA

select count(*) as "Number of rows" from credit_card_data;



-- RECOUNT OF UNIQUE VALUES(for a quick insight on the data)

select Offer_Accepted as "(Y/N)", count(*)	as "Recount"		-- (Y/N) Offer Acceptance
from credit_card_data
group by Offer_Accepted;

select Reward, count(*)	as "Recount"					-- Type Of Reward
from credit_card_data
group by Reward;

select Mailer_Type as "Mailer Type", count(*)	as "Recount"			-- Mail Type
from credit_card_data
group by Mailer_Type;

select Income_Level as "Income Level", count(*)	as "Recount"			-- Income Level
from credit_card_data
group by Income_Level;

select Bank_accounts_open as "Number Of Bank Accounts Open", count(*)	as "Recount"		-- # Of Bank Accounts Owned
from credit_card_data
group by Bank_accounts_open;

select Overdraft_Protection as "Overdraft Protection", count(*)	as "Recount"	-- Overdraft Protection
from credit_card_data
group by Overdraft_Protection;

select Credit_Rating as "Credit Rating", count(*)	as "Recount"			-- Credit Rating
from credit_card_data
group by Credit_Rating;

select Credit_Cards_Held as "Number Of Credit Cards Owned", count(*)	as "Recount"		-- # Of Credit Cards Owned
from credit_card_data
group by Credit_Cards_Held;

select Homes_Owned as "Number Of Homes Owned", count(*)	as "Recount"			-- # Of Homes Owned
from credit_card_data
group by Homes_Owned;

select Household_Size as "Household Size", count(*)	as "Recount"			-- Household Size
from credit_card_data
group by Household_Size;

select Own_Your_Home "Home Ownership", count(*)	as "Recount"			-- Home Ownership
from credit_card_data
group by Own_Your_Home;



-- Top 10 Customers (Average Balance)

select customer_number as "Top 10 Customers (Average Balance)", average_balance as "Average Balance"
from credit_card_data
order by average_balance desc
limit 10;



-- Total Avarage Balances

select avg(average_balance) as "All Clients Average Balance"
from credit_card_data;



-- Average balance of the customers grouped by `Income Level`

select Income_Level as "Income Level", avg(average_balance) as "Average Balance"
from credit_card_data
group by Income_Level;



-- average balance of the customers grouped by `number_of_bank_accounts_open`

select bank_accounts_open as "# Of Bank Accounts", avg(average_balance) as "Average Balance"
from credit_card_data
group by Bank_accounts_open;



--  average number of credit cards held by customers for each credit rating

select Credit_Rating as "Credit Rating", avg(Credit_Cards_Held) as "Average Number of Credit Cards Owned"
from credit_card_data
group by Credit_Rating;



-- correlation between the columns `credit_cards_held` and `number_of_bank_accounts_open`

select bank_accounts_open as "Number Of Bank Accounts Opened", avg(credit_cards_held) as "Average Number of Credit Cards Owned"
from credit_card_data
group by bank_accounts_open;

select credit_cards_held as "Number of Credit Cards Owned", avg(bank_accounts_open) as "Average Number Of Bank Accounts Opened"
from credit_card_data
group by credit_cards_held;



-- CUSTOMERS OF INTEREST

select *
from credit_card_data
where (Credit_Rating = "medium" OR Credit_Rating = "high")
	AND (credit_cards_held <= 2)
    AND (own_your_home = "yes")
    AND (household_size >= 3)
    AND (Offer_accepted = "Yes");
    
    
    
-- customers whose average balance is less than the average balance

select customer_number as "Customer Number", average_balance as "Average Balance"
from credit_card_data
where average_balance < (select avg(average_balance) from credit_card_data);

create view below_avg_balance_customers as
select customer_number as "Customer Number", average_balance as "Average Balance"
from credit_card_data
where average_balance < (select avg(average_balance) from credit_card_data);

select * from below_avg_balance_customers;		-- VIEW OF CUSTOMERS THAT MEET CRITERIA



-- List of customers with High/Medium Credit Rating.

select customer_number as "Customers With Medium/High Credit Rating" from credit_card_data
where Credit_Rating = "High" OR Credit_Rating = "Medium";



-- Difference in average balance of high credit rating vs low credit rating.

select 
    avg(case when Credit_Rating = 'High' then average_balance end) as "Average Balance (High Credit Score)",
    avg(case when Credit_Rating = 'Low' then average_balance end) as "Average Balance (Low Credit Score)",
		avg(case when Credit_Rating = 'High' then average_balance end) 
        -
        avg(case when Credit_Rating = 'Low' then average_balance end) 
        as "Average Balance Difference"
from credit_card_data
where Credit_Rating in ('High', 'Low');



-- Specific Customer Insight -- 11th Least "Q1 Balance"

select * from credit_card_data
order by Q1_balance asc
limit 1 offset 10;



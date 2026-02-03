-- customer_insights_summary.sql
-- Switch to the Data Warehouse database

USE DataWarehouse;
GO

/*-----------------------------------------------------------------------------
1. Preview Customer Report Data
	- Displays all customer-level metrics from the reporting view
	- Useful for validation and ad-hoc analysis
-----------------------------------------------------------------------------*/

SELECT * FROM gold.report_customers;

/*-----------------------------------------------------------------------------
2. Customer Distribution & Sales by Age Group
	- Shows how customers and revenue are distributed across age brackets
	- Helps identify high-value age demographics
-----------------------------------------------------------------------------*/
SELECT
	age_group,
	COUNT(customer_number) AS total_customers,
	SUM(total_sales) AS total_sales
FROM gold.report_customers
GROUP BY age_group;


/*-----------------------------------------------------------------------------
3. Customer Distribution & Sales by Customer Segment
	- Compares VIP, Regular, and New customers
	- Useful for customer lifecycle and retention analysis
-----------------------------------------------------------------------------*/
SELECT
	customer_segment,
	COUNT(customer_number) AS total_customers,
	SUM(total_sales) AS total_sales
FROM gold.report_customers
GROUP BY customer_segment;



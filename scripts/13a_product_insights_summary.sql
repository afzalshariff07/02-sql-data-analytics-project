-- product_insights_summary.sql
-- Switch to the Data Warehouse database
USE DataWarehouse;
GO

/*-----------------------------------------------------------------------------
	1. Preview Product Report Data
	- Displays all product-level metrics from the reporting view
	- Useful for validation and exploratory analysis
-----------------------------------------------------------------------------*/
SELECT *
FROM gold.report_products;

/*-----------------------------------------------------------------------------
	2. Product Distribution & Sales by Category
	- Shows revenue and product distribution across categories
	- Helps identify high-performing product categories
-----------------------------------------------------------------------------*/
SELECT
	category,
	COUNT(DISTINCT product_key) AS total_products,
	SUM(total_sales) AS total_sales
FROM gold.report_products
GROUP BY category
ORDER BY total_sales DESC, total_products DESC;

/*-----------------------------------------------------------------------------
	3. Product Distribution & Sales by Subcategory
	- Provides deeper insight into product performance within categories
	- Useful for portfolio optimization decisions
-----------------------------------------------------------------------------*/
SELECT
	subcategory,
	COUNT(DISTINCT product_key) AS total_products,
	SUM(total_sales) AS total_sales
FROM gold.report_products
GROUP BY subcategory
ORDER BY total_sales DESC;

/*-----------------------------------------------------------------------------
	4. Product Distribution & Sales by Product Segment
	- Compares High Performer, Mid-Range, and Low-Performer products
	- Helps prioritize inventory, pricing, and marketing strategies
-----------------------------------------------------------------------------*/
SELECT
	product_segment,
	COUNT(DISTINCT product_key) AS total_products,
	SUM(total_sales) AS total_sales
FROM gold.report_products
GROUP BY product_segment
ORDER BY total_sales DESC;

/*-----------------------------------------------------------------------------
5. Product Recency Analysis
- Analyzes how recently products were sold
- Useful for identifying slow-moving or inactive products
-----------------------------------------------------------------------------*/
SELECT
	recency_in_months,
	COUNT(DISTINCT product_key) AS total_products,
	SUM(total_sales) AS total_sales
FROM gold.report_products
GROUP BY recency_in_months
ORDER BY recency_in_months;






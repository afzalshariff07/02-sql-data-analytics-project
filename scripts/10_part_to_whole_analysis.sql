/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

USE DataWarehouse;
GO

-- Which categories contribute the most to overall sales?
WITH category_sales AS (
SELECT
    category,
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
)
SELECT
category,
total_sales,
SUM(total_sales) OVER() overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2), '%') AS percentage_of_total_sales
FROM category_sales
ORDER BY total_sales DESC;


-- Which categories contribute the most to total_orders?
WITH category_orders AS (
SELECT
    p.category,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
)
SELECT
    category,
    total_orders,
    SUM(total_orders) OVER() AS overall_orders,
    CONCAT(ROUND((CAST( total_orders AS FLOAT) / SUM(total_orders) OVER()) , 2 ) * 100, '%')  AS percentage_of_total_orders
FROM category_orders
ORDER BY total_orders DESC;


-- Which categories contribute the most to total_customers?
WITH category_customers AS (
SELECT
    p.category,
    COUNT(DISTINCT f.customer_key) AS total_customer
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
)
SELECT
    category,
    total_customer,
    SUM(total_customer) OVER() AS overall_customers,
    CONCAT(ROUND(( CAST(total_customer AS FLOAT) / SUM(total_customer) OVER()) * 100, 2), '%') AS percentage_of_total_customers
FROM category_customers
ORDER BY total_customer DESC;


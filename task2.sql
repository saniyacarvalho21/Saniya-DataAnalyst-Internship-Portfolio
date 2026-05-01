CREATE DATABASE sales_db;
USE sales_db;

SELECT * FROM sales_data LIMIT 10;
DESCRIBE sales_data;

-- 1.Which region generates the highest revenue?
SELECT 
    region,
    ROUND(SUM(CAST(sales AS DECIMAL(10,2))), 2) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;
-- Insight:Identifies top-performing regions, helping prioritize marketing and expansion strategies.

-- 2.Which product categories drive the most sales?
SELECT 
    category,
    ROUND(SUM(CAST(sales AS DECIMAL(10,2))), 2) AS total_sales
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;
-- Insight:Highlights high-performing categories for inventory planning and promotions.

-- 3.What is the monthly sales trend?
SELECT 
    `order month`,
    ROUND(SUM(CAST(sales AS DECIMAL(10,2))), 2) AS monthly_sales
FROM sales_data
GROUP BY `order month`
ORDER BY `order month`;
-- Insight:Reveals seasonality and demand fluctuations across months.

-- 4.Which products generate the highest revenue?
SELECT 
    `product name`,
    ROUND(SUM(CAST(sales AS DECIMAL(10,2))), 2) AS total_sales
FROM sales_data
GROUP BY `product name`
ORDER BY total_sales DESC
LIMIT 10;
-- Insight:Identifies key revenue-driving products for strategic focus.

-- 5.What is the average shipping time?
SELECT 
    ROUND(AVG(CAST(`shipping days` AS DECIMAL(10,2))), 2) AS avg_shipping_days
FROM sales_data;
-- Insight:Measures operational efficiency and customer experience.

-- 6. Which region has highest average order value?
SELECT 
    region,
    ROUND(AVG(CAST(sales AS DECIMAL(10,2))), 2) AS avg_order_value
FROM sales_data
GROUP BY region
ORDER BY avg_order_value DESC;
-- Insight:Helps identify regions with higher spending customers.

-- 7. What are top products within each category?
SELECT 
    category,
    `product name`,
    ROUND(SUM(CAST(sales AS DECIMAL(10,2))), 2) AS total_sales
FROM sales_data
GROUP BY category, `product name`
ORDER BY category, total_sales DESC;
-- Insight:Helps understand product performance within each segment.

-- 8. Which orders had unusually high sales? (Outliers)
SELECT *
FROM sales_data
WHERE CAST(sales AS DECIMAL(10,2)) > (
    SELECT AVG(CAST(sales AS DECIMAL(10,2))) * 3 FROM sales_data
);
-- Insight:Identifies high-value transactions or anomalies.

-- 9. Rank Products by Sales
SELECT 
    `product name`,
    ROUND(SUM(CAST(sales AS DECIMAL(10,2))), 2) AS total_sales,
    RANK() OVER (ORDER BY SUM(CAST(sales AS DECIMAL(10,2))) DESC) AS rank_position
FROM sales_data
GROUP BY `product name`;
-- Insight:Provides ranking of products based on revenue contribution.

'''
Management would like to analyze their sales and customer data to improve marketing, customer relationship and revenue.

They need answers to the following questions:

1. What year/month generated the most revenue, so they can replicate campaigns and other factors that led to high sales.
2. What products are selling the most in volume and what is their comparison to profits, so they can increase profit margins for high selling volumes with low profits.
3. Which customers are in the bottom 25% based on sales, so they can improve on follow up and email campaigns to those customers.
'''

-- Before we start answering the questions, we would check if all sales data was imported then, we would create a view to hold all sales, 
-- products and customer data

-- Check that all years sales were imported into orders table
SELECT DISTINCT(EXTRACT(YEAR FROM order_date))
FROM orders;

-- we would create a view to hold sales for products and customers
CREATE VIEW all_sales_vw AS 
SELECT
	order_date,
	EXTRACT(YEAR FROM order_date) as order_year,
	EXTRACT(MONTH FROM order_date) as order_month,
	order_number,
	p.product_key,
	product_name,
	c.customer_key,
	concat(first_name,' ',last_name) as customer_name,
	email as customer_email,
	order_quantity,
	p.product_cost * o.order_quantity as costs,
	p.product_price * o.order_quantity as revenue
FROM orders o
LEFT JOIN products p ON o.product_key = p.product_key
LEFT JOIN customers c ON o.customer_key = c.customer_key;

SELECT * FROM all_sales_vw;


-- 1. What year/month generated the most revenue?
SELECT 
	order_year,
	order_month,
	round(sum(revenue),2) as total_revenue
FROM 
	all_sales_vw
GROUP BY 
	order_year,
	order_month
ORDER BY total_revenue desc;

--- June 2022 generated the highest revenue with $1,826,987.14


-- 2. What products are selling the most in volume and what is their comparison to profits?
SELECT 
	product_name,
	sum(order_quantity) as volume,
	sum(revenue - costs) as profits
FROM 
	all_sales_vw
GROUP BY 
	product_name
ORDER BY volume desc
LIMIT 10;

-- Water Bottle- 30oz has the highest volume with 7967 and a profit of $24,886.5179


-- 3. Which customers are in the bottom 25% based on sales?

CREATE VIEW bottom25_customers AS
WITH customer_sales AS
(
	SELECT
		customer_name,
		customer_email,
		sum(revenue) as revenue
	FROM
		all_sales_vw
	GROUP BY
		customer_name,
		customer_email
)

SELECT 
	customer_name,
	customer_email
FROM 
(
	SELECT *,
		NTILE(4) OVER(ORDER BY revenue) as customer_group
	FROM customer_sales
)x
WHERE x.customer_group = 4

SELECT * FROM bottom25_customers;

-- There are 4354 customer in the bottom 25% that would require more follow-up and email marketing
-- CREATE  ORDERS TABLE
CREATE TABLE orders
(
	order_date timestamp,
	stock_date timestamp,
	order_number character varying,
	product_key numeric,
	customer_key numeric,
	territory_key numeric,
	orderline_item numeric,
	order_quantity numeric
);


-- IMPORT DATA TO TABLE ORDERS
-- 2020 sales data
COPY 
	orders 
FROM 
	'D:/chichiumelo.com.ng/portfolio/Sales and Customer Analysis - SQL/dataset/Fact_Sales/ArizonaBikes_Sales_2020.csv' 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',');
	
-- 2021 sales data
COPY 
	orders 
FROM 
	'D:/chichiumelo.com.ng/portfolio/Sales and Customer Analysis - SQL/dataset/Fact_Sales/ArizonaBikes_Sales_2021.csv' 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',');

-- 2022 sales data
COPY 
	orders 
FROM 
	'D:/chichiumelo.com.ng/portfolio/Sales and Customer Analysis - SQL/dataset/Fact_Sales/ArizonaBikes_Sales_2022.csv' 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',');

SELECT * FROM orders;


-- CREATE PRODUCTS TABLE
CREATE TABLE products
(
	product_key numeric,
	product_name character varying,
	product_cost numeric,
	product_price numeric 
);

-- IMPORT PRODUCT DATA
COPY 
	products 
FROM 
	'D:/chichiumelo.com.ng/portfolio/Sales and Customer Analysis - SQL/dataset/Dim_Product.csv' 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',');
	
SELECT * FROM products;


-- CREATE CUSTOMER TABLE
CREATE TABLE customers
(
	customer_key numeric,
	prefix	text,
	first_name text,	
	last_name	text,
	birth_date	timestamp,
	marital_status text	,
	gender text	,
	email character varying,
	annual_income numeric
);

-- IMPORT CUSTOMER DATA
COPY 
	customers 
FROM 
	'D:/chichiumelo.com.ng/portfolio/Sales and Customer Analysis - SQL/dataset/Dim_Customer.csv' 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',', ENCODING 'WIN1252'); -- got encoding error wth UTF-8
	
SELECT * FROM customers;

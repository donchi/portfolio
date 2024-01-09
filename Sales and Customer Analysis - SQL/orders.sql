-- CREATE TABLE ORDERS
CREATE TABLE orders
(
	order_date timestamp,
	stock_date timestamp,
	order_number character varying,
	product_key numeric,
	customer_key numeric,
	territory_key numeric,
	orderline_item numeric,
	orderquantiy numeric
);

SELECT * FROM orders

-- IMPORT DATA TO TABLE ORDERS
COPY 
	orders 
FROM 
	'D:/chichiumelo.com.ng/portfolio/Sales and Customer Analysis - SQL/dataset/Fact_Sales/ArizonaBikes_Sales_2020.csv' 
	WITH (FORMAT CSV, HEADER true, DELIMITER ',');

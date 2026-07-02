CREATE DATABASE ecommerce;
USE ecommerce;
-- Create tables (adapted to Olist CSVs)
CREATE TABLE customers(customer_id VARCHAR(50),customer_unique_id VARCHAR(50),customer_zip_code_prefix INT,customer_city VARCHAR(100),customer_state VARCHAR(5));
CREATE TABLE orders(order_id VARCHAR(50),customer_id VARCHAR(50),order_status VARCHAR(30),order_purchase_timestamp DATETIME,order_approved_at DATETIME,order_delivered_carrier_date DATETIME,order_delivered_customer_date DATETIME,order_estimated_delivery_date DATETIME);
CREATE TABLE products(product_id VARCHAR(50),product_category_name VARCHAR(100),product_name_lenght INT,product_description_lenght INT,product_photos_qty INT,product_weight_g INT,product_length_cm INT,product_height_cm INT,product_width_cm INT);
CREATE TABLE order_items(order_id VARCHAR(50),order_item_id INT,product_id VARCHAR(50),seller_id VARCHAR(50),shipping_limit_date DATETIME,price DECIMAL(10,2),freight_value DECIMAL(10,2));
CREATE TABLE order_payments(order_id VARCHAR(50),payment_sequential INT,payment_type VARCHAR(30),payment_installments INT,payment_value DECIMAL(10,2));
-- Import CSVs with MySQL Table Data Import Wizard.
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders WHERE order_status='delivered';
SELECT * FROM products ORDER BY product_weight_g DESC;
SELECT customer_state,COUNT(*) total_customers FROM customers GROUP BY customer_state;
SELECT o.order_id,c.customer_city FROM orders o INNER JOIN customers c ON o.customer_id=c.customer_id;
SELECT c.customer_id,o.order_id FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id;
SELECT SUM(payment_value) revenue,AVG(payment_value) avg_payment FROM order_payments;
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*)>5);
CREATE VIEW customer_orders AS SELECT c.customer_id,COUNT(o.order_id) orders_count FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id;
SELECT * FROM customer_orders;
SELECT SUM(payment_value)/COUNT(DISTINCT customer_id) AS ARPU FROM orders JOIN order_payments USING(order_id);
CREATE INDEX idx_customer ON orders(customer_id);

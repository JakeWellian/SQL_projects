/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Project
-----------------------------------------------------------------------------------------------------------------------------------

Business Context:

A lot of people in the world share a common desire: to own a vehicle. A car or an automobile is seen as an object that gives the freedom of mobility. 
Many are now preferring pre-owned vehicles because they come at an affordable cost, but at the same time, they are also concerned about whether the after-sales
service provided by the resale vendors is as good as the care you may get from the actual manufacturers. New-Wheels, a vehicle resale company, has launched an app with
an end-to-end service from listing the vehicle on the platform to shipping it to the customer's location. This app also captures the overall after-sales feedback given by
the customer. 

Problem Statement:

New-Wheels sales have been dipping steadily in the past year, and due to the critical customer feedback and ratings online, 
there has been a drop in new customers every quarter, which is concerning to the business. 
The CEO of the company now wants a quarterly report with all the key metrics sent to him so he can assess the health of the business and make the necessary decisions.

Objective:

Create a pipeline to organize and maintain this data using a SQL database so that it becomes easy to answer questions in the future. 
Use the data to answer the questions posed and create a quarterly business report for the CEO. 	
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

DROP DATABASE IF EXISTS NEW_WHEELS;
CREATE DATABASE NEW_WHEELS;

USE NEW_WHEELS;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

-- Creating the strucutre for the main Database + a temporary database, and multiple related tables

-- To drop the table if already exists
DROP TABLE IF EXISTS vehicles_t; -- Change the name of table_name to the name you have given.      
CREATE TABLE vehicles_t ( # Main Database
	 shipper_id INTEGER,
	 shipper_name VARCHAR(50),
	 shipper_contact_details VARCHAR(30),
	 product_id INTEGER,
	 vehicle_maker VARCHAR(60),
	 vehicle_model VARCHAR(60),
	 vehicle_color VARCHAR(60),
	 vehicle_model_year INTEGER, 
	 vehicle_price DECIMAL(16,8),
	 quantity INTEGER,
	 discount DECIMAL(4,2),
	 customer_id VARCHAR(25),
	 customer_name VARCHAR(25),
	 gender VARCHAR(15),
	 job_title VARCHAR(50),
	 phone_number VARCHAR(20),
	 email_address VARCHAR(50),
	 city VARCHAR(25),
	 country VARCHAR(40),
	 state VARCHAR(40),
	 customer_address VARCHAR(50),
	 order_date DATE,
	 order_id VARCHAR(25),
	 ship_date DATE,
	 ship_mode VARCHAR(25),
	 shipping VARCHAR(30),
	 postal_code INTEGER,
	 credit_card_Type VARCHAR(40),
	 credit_card_Number BIGINT,
	 customer_feedback VARCHAR(20),
	 quarter_number INTEGER,
	 PRIMARY KEY (order_id, shipper_id, product_id, customer_id)
);                                              

DROP TABLE IF EXISTS temp_t; 
CREATE TABLE temp_t ( # Temporary Table
	 shipper_id INTEGER,
	 shipper_name VARCHAR(50),
	 shipper_contact_details VARCHAR(30),
	 product_id INTEGER,
	 vehicle_maker VARCHAR(60),
	 vehicle_model VARCHAR(60),
	 vehicle_color VARCHAR(60),
	 vehicle_model_year INTEGER, 
	 vehicle_price DECIMAL(16,8),
	 quantity INTEGER,
	 discount DECIMAL(4,2),
	 customer_id VARCHAR(25),
	 customer_name VARCHAR(25),
	 gender VARCHAR(15),
	 job_title VARCHAR(50),
	 phone_number VARCHAR(20),
	 email_address VARCHAR(50),
	 city VARCHAR(25),
	 country VARCHAR(40),
	 state VARCHAR(40),
	 customer_address VARCHAR(50),
	 order_date DATE,
	 order_id VARCHAR(25),
	 ship_date DATE,
	 ship_mode VARCHAR(25),
	 shipping VARCHAR(30),
	 postal_code INTEGER,
	 credit_card_Type VARCHAR(40),
	 credit_card_Number BIGINT,
	 customer_feedback VARCHAR(20),
	 quarter_number INTEGER,
	 PRIMARY KEY (order_id, shipper_id, product_id, customer_id)
);

DROP TABLE IF EXISTS order_t; 
CREATE TABLE order_t ( # Order Table
	order_id VARCHAR(25),
	customer_id VARCHAR(25),
    shipper_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    vehicle_price DECIMAL(16,8),
    order_date DATE,
    ship_date DATE,
    discount DECIMAL(4,2),
	ship_mode VARCHAR(25),
	shipping VARCHAR(30),
    customer_feedback VARCHAR(20),
    quarter_number INTEGER,
	PRIMARY KEY (order_id)
);

DROP TABLE IF EXISTS shipper_t; 
CREATE TABLE shipper_t ( # Shipper Table
	 shipper_id INTEGER,
	 shipper_name VARCHAR(50),
	 shipper_contact_details VARCHAR(30),
	 PRIMARY KEY (shipper_id)
);


DROP TABLE IF EXISTS product_t; 
CREATE TABLE product_t ( # Product Table
  product_id INTEGER,
  vehicle_maker VARCHAR(60),
  vehicle_model VARCHAR(60),
  vehicle_color VARCHAR(60),
  vehicle_model_year INTEGER,
  vehicle_price DECIMAL(16,8),
  PRIMARY KEY(product_id)
);


DROP TABLE IF EXISTS customer_t; 
CREATE TABLE customer_t ( # Customer Table
	customer_id VARCHAR(25), 
	customer_name VARCHAR(25), 
	gender VARCHAR(15), 
	job_title VARCHAR(50), 
	phone_number VARCHAR(20),
	email_address VARCHAR(50),
	city VARCHAR(25),
	country VARCHAR(40),
	state VARCHAR(40),
	customer_address VARCHAR(50),
	postal_code INTEGER, 
	credit_card_type VARCHAR(40) ,
	credit_card_number BIGINT,
	PRIMARY KEY(customer_id)
);



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

-- Stored Procedure Main Database- 
DROP PROCEDURE IF EXISTS vehicles_p;
DELIMITER $$ 
CREATE PROCEDURE vehicles_p()
BEGIN
       INSERT INTO vehicles_t (
              shipper_id,
              shipper_name,
              shipper_contact_details,
              product_id,
              vehicle_maker,
              vehicle_model,
              vehicle_color,
              vehicle_model_year,
              vehicle_price ,
              quantity,
              discount,
              customer_id,
              customer_name,
              gender,
              job_title,
              phone_number,
              email_address,       
              city,
              country,
              state,
              customer_address,
              order_date ,
              order_id ,
              ship_date,
              ship_mode ,      
              shipping ,
              postal_code ,
              credit_card_type,
              credit_card_number,
              customer_feedback ,
              quarter_number
) SELECT * FROM temp_t;
END;
    

-- Stored Procedure Order Table- 
DROP PROCEDURE IF EXISTS order_p;
DELIMITER $$ 
CREATE PROCEDURE order_p (qtr_number INTEGER)
BEGIN
	 INSERT INTO order_t
	(
	  order_id,
	  customer_id,
	  shipper_id,
	  product_id,
	  quantity,
	  vehicle_price,
	  discount,
	  order_date,
	  ship_date,
	  ship_mode,
	  shipping,
	  customer_feedback,
	  quarter_number
	) SELECT  
	  order_id,
	  customer_id,
	  shipper_id,
	  product_id,
	  quantity,
	  vehicle_price,
	  discount,
	  order_date,
	  ship_date,
	  ship_mode,
	  shipping,
	  customer_feedback,
	  quarter_number
	FROM
	 vehicles_t
	WHERE quarter_number = qtr_number;
END;
  

-- Stored Procedure Shipping Table- 
DROP PROCEDURE IF EXISTS shipper_p;
DELIMITER $$ 
CREATE PROCEDURE shipper_p()
BEGIN
	 INSERT INTO shipper_t
	(
	    shipper_id,
		shipper_name,
		shipper_contact_details
	) SELECT  
	 DISTINCT
		shipper_id,
		shipper_name,
		shipper_contact_details
	FROM
		vehicles_t
	WHERE shipper_id NOT IN (SELECT DISTINCT shipper_id FROM shipper_t);
END;
    


-- Stored Procedure Prodcut Table- 
DROP PROCEDURE IF EXISTS product_p;
DELIMITER $$ 
CREATE PROCEDURE product_p()
BEGIN
	 INSERT INTO product_t
	(
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price

	) SELECT  
	 DISTINCT
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
	FROM
		vehicles_t
	WHERE product_id NOT IN (SELECT DISTINCT product_id FROM product_t);
END;
    


-- Stored Procedure Customer Table- 
DROP PROCEDURE IF EXISTS customer_p;
DELIMITER $$ 
CREATE PROCEDURE customer_p()
BEGIN
	 INSERT INTO customer_t(
		  customer_id,
		  customer_name,
		  gender,
		  job_title,
		  phone_number,
		  email_address,       
		  city,
		  country,
		  state,
		  customer_address,
		  postal_code,
		  credit_card_type,
		  credit_card_number
	) SELECT DISTINCT
		  customer_id,
		  customer_name,
		  gender,
		  job_title,
		  phone_number,
		  email_address,       
		  city,
		  country,
		  state,
		  customer_address,
		  postal_code,
		  credit_card_type,
		  credit_card_number
	FROM vehicles_t
	WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM customer_t);
END;
    


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- Importing the data. We have data for weeks 1,2,3 & 4. 
SET GLOBAL local_infile=1;

truncate temp_t;
LOAD DATA LOCAL INFILE "C:/Users/Jake Wellian/Documents/Data analytics/SQL/GreatLearning/week 5 - project/Data/new_wheels_sales_qtr_4.csv"
INTO TABLE temp_t
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

Call vehicles_p();
Call order_p(4);
Call product_p();
Call shipper_p();
Call customer_p();


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

-- List of views to be created are "veh_prod_cust_v" , "veh_ord_cust_v"

-- View table for Order and Customer
DROP VIEW IF EXISTS veh_ord_cust_v;

CREATE VIEW veh_ord_cust_v AS
SELECT 
	 cust.customer_id,
	 cust.customer_name,
	 cust.city,
	 cust.state,
	 cust.credit_card_type,
	 ord.order_id,
	 ord.order_date,
	 ord.ship_date,
	 ord.vehicle_price,
	 ord.product_id,
	 ord.shipper_id,
	 ord.discount,
	 ord.customer_feedback,
	 ord.quantity,
	 ord.quarter_number
FROM order_t ord 
	INNER JOIN customer_t cust
	ON ord.customer_id = cust.customer_id;


 
 -- View Table for Product and Customer --
DROP VIEW IF EXISTS veh_prod_cust_v;

CREATE VIEW veh_prod_cust_v AS
	SELECT
		cust.customer_id,
		ord.order_id,
		cust.customer_name,
		cust.credit_card_type,
		cust.state,
		ord.customer_feedback,
		pro.product_id,
		pro.vehicle_maker,
		pro.vehicle_model,
		pro.vehicle_color,
		pro.vehicle_model_year
	FROM product_t pro 
		INNER JOIN order_t ord
		ON pro.product_id = ord.product_id
		INNER JOIN customer_t cust
		ON ord.customer_id = cust.customer_id;


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

-- Create the function calc_revenue_f
DROP FUNCTION IF EXISTS calc_revenue_f;
DELIMITER $$  
CREATE FUNCTION calc_revenue_f (vehicle_price DECIMAL(16,8), discount DECIMAL(4,2), quantity INTEGER) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  
  DECLARE revenue DECIMAL;
      SET revenue = quantity * (vehicle_price - ((discount/100)*vehicle_Price));  
  RETURN revenue;  
END;


-- Create the function days_to_ship_f-
DROP FUNCTION IF EXISTS days_to_ship_f;
DELIMITER $$
CREATE FUNCTION days_to_ship_f (order_date date, ship_date date) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  
    DECLARE ship_days INT;
        SET ship_days = DATEDIFF(ship_date, order_date);  
    RETURN ship_days;  
END;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
*/

Select count(DISTINCT customer_id) AS num_customers,
		state
FROM customer_t
group by state
order by count(*) desc;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.
*/

WITH cust_feedback AS
(
SELECT
quarter_number,
	CASE
		WHEN customer_feedback = "Very Bad" THEN 1
        WHEN customer_feedback = "Bad" THEN 2
        WHEN customer_feedback = "Okay" THEN 3
        WHEN customer_feedback = "Good" THEN 4
        WHEN customer_feedback = "Very Good" THEN 5
	END AS feedback_score
FROM veh_ord_cust_v
)
SELECT
	quarter_number,
    avg(feedback_score) AS feedback_avg_score
FROM cust_feedback
GROUP BY 1
ORDER BY 1;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?
*/
      
 
WITH CUST_FEEDBACK AS 
(Select  quarter_number,
  SUM(CASE WHEN  customer_feedback = 'VERY GOOD' THEN 1 ELSE 0 END) AS VERY_GOOD,
  SUM(CASE WHEN customer_feedback = 'Good' THEN 1 ELSE 0 END) AS good,
  SUM(CASE WHEN customer_feedback = 'Okay' THEN 1 ELSE 0 END) AS okay,
  SUM(CASE WHEN customer_feedback = 'Bad' THEN 1 ELSE 0 END) AS bad,
  SUM(CASE WHEN customer_feedback = 'Very Bad' THEN 1 ELSE 0 END) AS very_bad,
  COUNT(customer_feedback) AS TOTAL
From veh_ord_cust_v
GROUP BY 1)
SELECT QUARTER_NUMBER,
    (very_good/totaL)*100 perc_very_good,
        (good/total)*100 perc_good,
        (okay/total)*100 perc_okay,
        (bad/total)*100 perc_bad,
        (very_bad/total)*100 perc_very_bad
FROM CUST_FEEDBACK
GROUP BY 1
order by QUARTER_NUMBER;

-- Yes customers are getting dissatisfied over time. For example 30% of customers gave very good feedback in Quarter 1 but only 10% gave very good feedback in Quarter 4.
-- Similarly, 11% of customers gave very bad feedback in Quarter 1 and 31% in Quarter 4.


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.
*/


SELECT
	count(DISTINCT customer_id) AS num_customers,
    vehicle_maker
FROM veh_prod_cust_v
GROUP BY vehicle_maker
ORDER BY num_customers desc
LIMIT 5;


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?
*/

SELECT *
FROM 
(SELECT *, RANK() OVER(PARTITION BY STATE ORDER BY TOTAL DESC) AS RNK
FROM
(SELECT STATE,
    vehicle_maker,
       COUNT(customer_id) AS TOTAL
FROM veh_prod_cust_v
GROUP BY 1,2) A) B
WHERE RNK =1;




-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?
*/

SELECT 
	count(order_id) AS num_orders,
	quarter_number
FROM veh_ord_cust_v
GROUP BY 2
ORDER BY 1 DESC;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 
*/
      
SELECT *
   , 100*(revenue -lag(revenue) over(order by quarter_number) )/lag(revenue) over(order by quarter_number) as qoq
   FROM
  (SELECT  quarter_number,
    sum(calc_revenue_f(vehicle_price,discount,quantity)) as revenue
      
  FROM veh_ord_cust_v     
  GROUP BY 1) A;      
      
      
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?
*/

SELECT 
	quarter_number,
    COUNT(order_id) AS num_orders,
    SUM(calc_revenue_f (vehicle_price, discount, quantity)) AS Revenue
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 3 DESC;




-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?
*/

SELECT 
	credit_card_type,
	avg(discount) AS avg_discount
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 2 DESC;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.
*/

SELECT 
	quarter_number,
    avg(days_to_ship_f(order_date, ship_date)) AS avg_days_to_ship
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 2 DESC;

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------




-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql - project_p2;

-- create TABLE 
Create Table retail_sales 
                  (
				      transactions_id	INT PRIMARY KEY ,
					  sale_date	  DATE,
					  sale_time TIME,
					  customer_id INT,
					  gender varchar (15),
					  age INT,
					  category varchar (15),
					  quantity INT,
					  price_per_unit FLOAT,
 					  cogs FLOAT,
					  total_sale FLOAT
                       );
					   
SELECT * FROM RETAIL_SALES
LIMIT 10

SELECT 
        COUNT  (*) 
		FROM RETAIL_SALES
LIMIT 10

--

SELECT * FROM RETAIL_SALES
where transactions_id IN NULL 

SELECT * FROM RETAIL_SALES
where
    transactions_id IN NULL 
    OR
	sale_date IN NULL 
	OR 
	sale_time IN NULL 
	OR 
	gender IN NULL 
	OR 
	category IN NULL 
	OR 
	quantiy IN NULL  
	OR 
	cogs IN NULL 
	OR 
	total_sale IN NULL ;
	
----
DELETE FROM retail_sales 
WHERE  transactions_id IN NULL 
    OR
	sale_date IN NULL 
	OR 
	sale_time IN NULL 
	OR 
	gender IN NULL 
	OR 
	category IN NULL 
	OR 
	quantiy IN NULL  
	OR 
	cogs IN NULL 
	OR 
	total_sale IN NULL ;


-- data exploration 

--- how many sales we have ?

  SELECT COUNT (*) AS total_sale FROM retail_sales 

 --- how many customers we have 

  SELECT COUNT (*) AS total_sale FROM retail_sales 
  
  --- how many  Unique customers we have 

  SELECT COUNT (DISTINCT customer_id) AS total_sale FROM retail_sales 

  select  DISTINCT category FROM retail_sales 

  -- data analysis & business key problems & Answers 

 -- My analysis & finding 
 -- Q.1 write a SQL query to retrivre all columns from sales made on 2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

 -- Q.2 write a SQL query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022

 SELECT
    *
 FROM retail_sales
 WHERE 
     category = 'clothing'
     AND
	 TO_CHAR (sale_date, 'yyyy-MM') = '2022-11'
	 AND 
	 quantiy >= 4

	 
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
     category,
	 SUM(total_sale) as net_sale,
	 COUNT(*) as total_orders
     FROM retail_sales
	 GROUP BY 1

-- Write SQL query to find the average age of customers who purchased items from the "Beauty' category.

    SELECT
	 round (AVG (age), 2) AS avg_age
	FROM retail_sales
	WHERE category = 'Beauty'

-- Write a query to find all transactions where the total sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000

-- Write SQL query to find the total number of transactions (transaction_fd) made by each gender in each categery

SELECT 
     category, 
	 gender, 
	 COUNT (*) AS total_trans
FROM retail_sales
GROUP BY
       category,
       gender
ORDER BY  1


-- Q.7 Write SQL query to calculate the average sale for each month. Find out best selling month in each year query

	   SELECT 
	        YEAR,
			MONTH,
			avg_sale
	FROM		
	   (
	SELECT
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG (total_sale) as avg_sale,
	RANK () OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC ) AS RANK
	FROM retail_sales
	GROUP BY 1,2 
	) AS T1 
	WHERE RANK = 1 
-- ORDER BY 1, 3 DESC

-- Q.8 Write to find the top 5 customers based on the highest total sales

SELECT 
      customer_ID, 
	  SUM(total_sale) as total_sales
	  FROM retail_sales 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5

-- Q.9 Write SQL query to find the number of unique customers who purchased ftems from each category.

SELECT 
      category,
	  COUNT (DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category 

-- Q.10 SQL query to create each shift and number of orders (Example Morning *12, Afternoon Between 12 & 17, Eventng > 17)

WITH hourly_sale
AS
(
SELECT *,
   CASE
      WHEN  EXTRACT ( HOUR FROM sale_time) < 12 THEN 'Morning' 
	  WHEN  EXTRACT ( HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	  ELSE 'Evening'
	  END as shift 
FROM retail_sales
)
SELECT 
     shift,
     COUNT (*) as total_orders
FROM hourly_sale  
GROUP BY shift
-- END OF PROJECT 
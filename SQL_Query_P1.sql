select * from Retail_Sales
where
category is null
or
quantiy is null or
price_per_unit is null 
or cogs is null or total_sale is null

delete from Retail_Sales
where category is null
or
quantiy is null or
price_per_unit is null 
or cogs is null or total_sale is null

select count(*) from Retail_Sales

--Data Exploration
select count(*) as total_sales from Retail_Sales

--How many uniquee customers we have?
select count( distinct customer_id) as total_sales from Retail_Sales


--Data Analysis & business key Problms & Answers

--Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from Retail_Sales
where sale_date = '2022-11-05'

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
--the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM Retail_Sales
WHERE category = 'clothing'
AND quantiy >= 4
AND CONVERT(VARCHAR(7), sale_date) = '2022-11';

--Write a SQL query to calculate the total sales (total_sale) for each category
select category,sum(total_sale),count(*)
from Retail_Sales
group by category
--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select AVG(age)
from Retail_Sales
where category='Beauty'
--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from Retail_Sales
where total_sale>1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
select category,gender,COUNT(*)
from Retail_Sales
group by category,gender

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rank = 1;

--Write a SQL query to find the top 5 customers based on the highest total sales

SELECT TOP 5 
    customer_id, 
    SUM(total_sale) AS total_sales 
FROM Retail_Sales
GROUP BY customer_id
ORDER BY total_sales DESC;

--Write a SQL query to find the number of unique customers who purchased items from each category.:
select category,
count(distinct customer_id)
from Retail_Sales
group by category

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

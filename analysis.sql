-- Project: The Urban Palate Analysis
-- Description: A SQL-based analysis of food delivery operations, focusing on repeat purchase patterns, restaurant performance, and monthly revenue trends.

---------------------------------------------------------
-- Q1: MOST POPULAR CUISINE TYPES
---------------------------------------------------------
SELECT cuisine_type, COUNT(order_id) AS total_orders
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY cuisine_type
ORDER BY total_orders DESC;

---------------------------------------------------------
-- Q2: TOP 5 RESTAURANTS BY REVENUE
---------------------------------------------------------
SELECT r.name, SUM(o.total_amount) AS revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.name
ORDER BY revenue DESC
LIMIT 5;

---------------------------------------------------------
-- Q3: CUSTOMERS WITH ZERO ORDERS
---------------------------------------------------------
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

---------------------------------------------------------
-- Q4: AVERAGE DELIVERY TIME PER CITY
---------------------------------------------------------
SELECT r.city, AVG(d.delivery_time) AS avg_time
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
JOIN deliveries d ON o.order_id = d.order_id
GROUP BY r.city;

---------------------------------------------------------
-- Q5: MONTHLY ORDER TRENDS
---------------------------------------------------------
SELECT DATE_TRUNC('month', order_date) AS month, COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;

---------------------------------------------------------
-- Q6: REPEAT VS ONE-TIME PURCHASERS
---------------------------------------------------------
WITH customer_classification AS (
    SELECT customer_id, 
           COUNT(order_id) AS order_count,
           CASE WHEN COUNT(order_id) > 1 THEN 'Repeat'
                ELSE 'One Time'
           END AS customer_type
    FROM orders 
    GROUP BY customer_id 
) 
SELECT customer_type, COUNT(customer_id) AS total_customers 
FROM customer_classification
GROUP BY customer_type;

---------------------------------------------------------
-- Q7: TOP 3 RESTAURANTS PER CITY BY RATING
---------------------------------------------------------
WITH restaurant_rating AS (
    SELECT name, city, avg_rating,
           DENSE_RANK() OVER (PARTITION BY city ORDER BY avg_rating DESC) AS rank
    FROM restaurants
)
SELECT name, city, avg_rating, rank
FROM restaurant_rating
WHERE rank <= 3;

---------------------------------------------------------
-- Q8: MONTH-OVER-MONTH REVENUE GROWTH
---------------------------------------------------------
WITH MonthlySales AS (
    SELECT DATE_TRUNC('month', order_date) AS sales_month,
           SUM(total_amount) AS current_revenue
    FROM orders
    WHERE status = 'Completed'
    GROUP BY 1
)
SELECT sales_month,
       current_revenue,
       LAG(current_revenue) OVER (ORDER BY sales_month) AS previous_month_revenue,
       (current_revenue - LAG(current_revenue) OVER (ORDER BY sales_month)) AS revenue_diff
FROM MonthlySales
ORDER BY sales_month;
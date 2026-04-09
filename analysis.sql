-- ============================================
-- Project  : The Urban Palate
-- File     : analysis.sql
-- Desc     : 8 business questions answered
--            using SQL — clauses, JOINs,
--            CTEs, and window functions
-- ============================================


---------------------------------------------------------
-- Q1: MOST POPULAR CUISINE TYPES
-- Business ask: Which cuisines drive the most
-- orders? Helps prioritise restaurant onboarding.
-- Skills: INNER JOIN, GROUP BY, COUNT, ORDER BY
---------------------------------------------------------

SELECT   r.cuisine_type,
         COUNT(o.order_id) AS total_orders
FROM     restaurants r
JOIN     orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_orders DESC;


---------------------------------------------------------
-- Q2: TOP 5 RESTAURANTS BY REVENUE
-- Business ask: Identify top earners to reward
-- and replicate their success model.
-- Skills: INNER JOIN, GROUP BY, SUM, LIMIT
---------------------------------------------------------

SELECT   r.name,
         SUM(o.total_amount) AS total_revenue
FROM     restaurants r
JOIN     orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.name
ORDER BY total_revenue DESC
LIMIT 5;


---------------------------------------------------------
-- Q3: CUSTOMERS WITH ZERO ORDERS
-- Business ask: Find inactive customers for
-- re-engagement and win-back campaigns.
-- Skills: LEFT JOIN, IS NULL
---------------------------------------------------------

SELECT c.name
FROM   customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE  o.order_id IS NULL;


---------------------------------------------------------
-- Q4: AVERAGE DELIVERY TIME PER CITY
-- Business ask: Identify cities with slowest
-- delivery for ops improvement initiatives.
-- Note: Using restaurants.city as delivery time
-- reflects restaurant location, not customer.
-- Skills: 3-table JOIN, GROUP BY, AVG, ROUND
---------------------------------------------------------

SELECT   r.city,
         ROUND(AVG(d.delivery_time), 1) AS avg_delivery_mins
FROM     restaurants r
JOIN     orders o     ON r.restaurant_id = o.restaurant_id
JOIN     deliveries d ON o.order_id      = d.order_id
GROUP BY r.city
ORDER BY avg_delivery_mins ASC;


---------------------------------------------------------
-- Q5: MONTHLY ORDER TRENDS
-- Business ask: Track order volume and revenue
-- growth month by month for the growth team.
-- Skills: DATE_FORMAT, GROUP BY, COUNT, SUM
---------------------------------------------------------

SELECT   DATE_FORMAT(order_date, '%Y-%m') AS order_month,
         COUNT(order_id)                  AS total_orders,
         SUM(total_amount)                AS total_revenue
FROM     orders
GROUP BY order_month
ORDER BY order_month ASC;


---------------------------------------------------------
-- Q6: REPEAT VS ONE-TIME CUSTOMERS
-- Business ask: Measure customer loyalty —
-- what share of customers come back?
-- Skills: CTE, CASE WHEN, GROUP BY, COUNT
---------------------------------------------------------

WITH customer_classification AS (
    SELECT customer_id,
           COUNT(order_id) AS order_count,
           CASE WHEN COUNT(order_id) > 1 THEN 'Repeat'
                ELSE 'One Time'
           END AS customer_type
    FROM   orders
    GROUP BY customer_id
)
SELECT   customer_type,
         COUNT(customer_id) AS total_customers
FROM     customer_classification
GROUP BY customer_type;


---------------------------------------------------------
-- Q7: TOP 3 RESTAURANTS PER CITY BY RATING
-- Business ask: Build a city-wise leaderboard
-- to surface the best performing restaurants.
-- Skills: CTE, DENSE_RANK, PARTITION BY, OVER()
---------------------------------------------------------

WITH restaurant_ranking AS (
    SELECT name,
           city,
           avg_rating,
           DENSE_RANK() OVER (
               PARTITION BY city
               ORDER BY avg_rating DESC
           ) AS rank_in_city
    FROM restaurants
)
SELECT   name,
         city,
         avg_rating,
         rank_in_city
FROM     restaurant_ranking
WHERE    rank_in_city <= 3
ORDER BY city, rank_in_city;


---------------------------------------------------------
-- Q8: MONTH OVER MONTH REVENUE GROWTH
-- Business ask: Finance team needs to track
-- revenue momentum — are we growing or declining?
-- Skills: CTE, LAG(), Window Function, ROUND
---------------------------------------------------------

WITH monthly_revenue AS (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
           SUM(total_amount)                AS current_revenue
    FROM   orders
    WHERE  status = 'Completed'
    GROUP BY sales_month
)
SELECT sales_month,
       current_revenue,
       LAG(current_revenue) OVER (
           ORDER BY sales_month
       ) AS previous_revenue,
       current_revenue - LAG(current_revenue) OVER (
           ORDER BY sales_month
       ) AS revenue_diff,
       ROUND(
           (current_revenue - LAG(current_revenue) OVER (ORDER BY sales_month))
           / LAG(current_revenue) OVER (ORDER BY sales_month) * 100, 2
       ) AS growth_pct
FROM   monthly_revenue
ORDER BY sales_month;

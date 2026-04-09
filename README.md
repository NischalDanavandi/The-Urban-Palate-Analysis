# The Urban Palate — Food Delivery SQL Analytics

An end-to-end SQL analytics project simulating real business questions for a food delivery platform (Swiggy / Zomato style). Built to demonstrate data analyst SQL skills across clauses, JOINs, CTEs, and window functions.

---

## Database Schema

```
customers    (customer_id, name, city, signup_date)
restaurants  (restaurant_id, name, city, cuisine_type, avg_rating)
orders       (order_id, customer_id, restaurant_id, order_date, total_amount, status)
deliveries   (delivery_id, order_id, delivery_time, distance_km, rating)
```

**How tables connect:**
```
customers ──► orders ──► deliveries
                │
           restaurants
```

---

## Business Questions Answered

| # | Business Question | SQL Concepts |
|---|---|---|
| 1 | Which cuisine types drive the most orders? | JOIN, GROUP BY, COUNT |
| 2 | Who are the top 5 restaurants by revenue? | JOIN, SUM, LIMIT |
| 3 | Which customers have never placed an order? | LEFT JOIN, IS NULL |
| 4 | Which cities have the slowest delivery times? | 3-table JOIN, AVG, ROUND |
| 5 | How are orders and revenue trending monthly? | DATE_FORMAT, GROUP BY |
| 6 | What share of customers are repeat buyers? | CTE, CASE WHEN |
| 7 | Which are the top 3 restaurants per city? | CTE, DENSE_RANK, PARTITION BY |
| 8 | What is the month over month revenue growth? | CTE, LAG, Window Function |

---

## Skills Demonstrated

| Skill | Used in |
|---|---|
| INNER JOIN across 2-3 tables | Q1, Q2, Q4 |
| LEFT JOIN + NULL handling | Q3 |
| GROUP BY + aggregates (COUNT, SUM, AVG) | Q1–Q5 |
| Date formatting and time series | Q5, Q8 |
| CTEs — single and chained | Q6, Q7, Q8 |
| CASE WHEN classification | Q6 |
| Window functions (DENSE_RANK, LAG) | Q7, Q8 |
| Business framing of SQL questions | All |

---

## Key Insights (from sample data)

- **North Indian and South Indian** cuisines drive the highest order volumes
- **Repeat customers** generate the majority of total revenue
- **Bengaluru restaurants** show faster avg delivery times than other cities
- **Month over month growth** reveals clear demand seasonality

---

## Files

| File | Description |
|---|---|
| `schema.sql` | CREATE TABLE statements + 18 sample orders across 10 customers |
| `analysis.sql` | All 8 business questions with inline comments |

---

## How to Run

```sql
-- MySQL 8.0+
SOURCE schema.sql;   -- creates tables and inserts data
SOURCE analysis.sql; -- runs all 8 analyses
```

---

## Tools

- SQL — MySQL 8.0
- Designed for integration with Power BI dashboards

---

*Part of a data analyst portfolio. Open to analyst roles — connect on LinkedIn.*

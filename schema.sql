-- Project: The Urban Palate Analysis
-- Description: Creating tables and inserting sample data for a food delivery database.

---------------------------------------------------------
-- STEP 1: CREATE THE TABLES
---------------------------------------------------------

CREATE TABLE customers (
    customer_id INT PRIMARY KEY, 
    name VARCHAR(50), 
    city VARCHAR(50), 
    signup_date DATE
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY, 
    name VARCHAR(50), 
    city VARCHAR(50), 
    cuisine_type VARCHAR(50), 
    avg_rating DECIMAL(3,1)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    restaurant_id INT, 
    order_date DATE, 
    total_amount DECIMAL(10,2), 
    status VARCHAR(20)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY, 
    order_id INT, 
    delivery_time INT, 
    distance_km DECIMAL(5,2), 
    rating INT
);

---------------------------------------------------------
-- STEP 2: INSERT SAMPLE DATA
---------------------------------------------------------

INSERT INTO customers VALUES 
(1, 'Rahul', 'Bengaluru', '2024-01-10'), 
(2, 'Anjali', 'Mumbai', '2024-02-15'),
(3, 'Vikram', 'Bengaluru', '2024-03-01');

INSERT INTO restaurants VALUES 
(101, 'Biryani Central', 'Bengaluru', 'Indian', 4.5), 
(102, 'Pizza Hut', 'Mumbai', 'Italian', 4.2),
(103, 'Sagar Ratna', 'Bengaluru', 'South Indian', 4.8);

INSERT INTO orders VALUES 
(5001, 1, 101, '2026-01-01', 500.00, 'Completed'), 
(5002, 1, 101, '2026-02-05', 450.00, 'Completed'),
(5003, 2, 102, '2026-02-10', 300.00, 'Completed');

INSERT INTO deliveries VALUES 
(9001, 5001, 30, 5.2, 5), 
(9002, 5002, 45, 8.1, 4);
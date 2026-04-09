-- ============================================
-- Project  : The Urban Palate
-- File     : schema.sql
-- Desc     : Table definitions + sample data
--            for a food delivery analytics DB
-- ============================================

---------------------------------------------------------
-- STEP 1: CREATE TABLES
---------------------------------------------------------

CREATE TABLE customers (
    customer_id  INT PRIMARY KEY,
    name         VARCHAR(100),
    city         VARCHAR(50),
    signup_date  DATE
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name          VARCHAR(100),
    city          VARCHAR(50),
    cuisine_type  VARCHAR(50),
    avg_rating    DECIMAL(3,1)
);

CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    restaurant_id INT,
    order_date    DATE,
    total_amount  DECIMAL(10,2),
    status        VARCHAR(20),
    FOREIGN KEY (customer_id)   REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE deliveries (
    delivery_id   INT PRIMARY KEY,
    order_id      INT,
    delivery_time INT,           -- in minutes
    distance_km   DECIMAL(5,2),
    rating        DECIMAL(3,1),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

---------------------------------------------------------
-- STEP 2: INSERT SAMPLE DATA
---------------------------------------------------------

INSERT INTO customers VALUES
(1,  'Rahul Sharma',   'Bengaluru', '2024-01-10'),
(2,  'Anjali Mehta',   'Mumbai',    '2024-02-15'),
(3,  'Vikram Singh',   'Bengaluru', '2024-03-01'),
(4,  'Priya Nair',     'Delhi',     '2024-03-18'),
(5,  'Karan Gupta',    'Mumbai',    '2024-04-05'),
(6,  'Sneha Reddy',    'Bengaluru', '2024-04-22'),
(7,  'Arjun Iyer',     'Delhi',     '2024-05-10'),
(8,  'Divya Menon',    'Mumbai',    '2024-05-28'),
(9,  'Rohan Patel',    'Bengaluru', '2024-06-14'),
(10, 'Meera Kumar',    'Delhi',     '2024-07-01');

INSERT INTO restaurants VALUES
(101, 'Biryani Central',   'Bengaluru', 'North Indian',  4.5),
(102, 'Pizza Palace',      'Mumbai',    'Italian',        4.2),
(103, 'Sagar Ratna',       'Bengaluru', 'South Indian',  4.8),
(104, 'Burger Barn',       'Delhi',     'Fast Food',      4.0),
(105, 'Sushi Sakura',      'Mumbai',    'Japanese',       4.7),
(106, 'Tandoor Tales',     'Delhi',     'North Indian',  4.3),
(107, 'Wok This Way',      'Bengaluru', 'Chinese',        4.1),
(108, 'Curry Corner',      'Mumbai',    'South Indian',  4.6),
(109, 'The Spice Route',   'Bengaluru', 'North Indian',  4.4),
(110, 'Dosa Delight',      'Delhi',     'South Indian',  4.9);

INSERT INTO orders VALUES
(5001, 1,  101, '2026-01-05', 500.00,  'Completed'),
(5002, 1,  101, '2026-02-05', 450.00,  'Completed'),
(5003, 2,  102, '2026-02-10', 300.00,  'Completed'),
(5004, 3,  103, '2026-02-18', 620.00,  'Completed'),
(5005, 4,  104, '2026-03-02', 280.00,  'Completed'),
(5006, 5,  105, '2026-03-15', 950.00,  'Completed'),
(5007, 6,  106, '2026-03-22', 410.00,  'Completed'),
(5008, 2,  107, '2026-04-01', 370.00,  'Completed'),
(5009, 7,  108, '2026-04-14', 810.00,  'Completed'),
(5010, 1,  109, '2026-04-20', 560.00,  'Completed'),
(5011, 8,  101, '2026-05-03', 490.00,  'Completed'),
(5012, 3,  102, '2026-05-17', 740.00,  'Completed'),
(5013, 9,  103, '2026-05-25', 320.00,  'Completed'),
(5014, 4,  110, '2026-06-08', 680.00,  'Completed'),
(5015, 10, 105, '2026-06-22', 1100.00, 'Completed'),
(5016, 5,  106, '2026-06-28', 430.00,  'Cancelled'),
(5017, 6,  107, '2026-07-04', 290.00,  'Completed'),
(5018, 7,  108, '2026-07-19', 870.00,  'Completed');

INSERT INTO deliveries VALUES
(9001, 5001, 30, 5.2, 4.5),
(9002, 5002, 45, 8.1, 4.0),
(9003, 5003, 28, 3.4, 4.8),
(9004, 5004, 35, 4.9, 4.2),
(9005, 5005, 42, 6.3, 3.9),
(9006, 5006, 38, 5.7, 4.7),
(9007, 5007, 50, 7.8, 4.1),
(9008, 5008, 32, 4.1, 4.4),
(9009, 5009, 27, 2.8, 4.9),
(9010, 5010, 44, 6.6, 4.3),
(9011, 5011, 31, 3.9, 4.6),
(9012, 5012, 48, 7.2, 4.0),
(9013, 5013, 25, 2.1, 4.8),
(9014, 5014, 39, 5.5, 4.2),
(9015, 5015, 55, 9.1, 4.5);

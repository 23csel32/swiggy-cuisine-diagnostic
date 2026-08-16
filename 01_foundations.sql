-- 01_foundations.sql
-- Foundational SQL queries against swiggy_capstone.db

-- 1. SELECT / WHERE: restaurants in a specific city (Mumbai)
SELECT restaurant_id, name, cuisine, city
FROM restaurants
WHERE city = 'Mumbai';

-- 2. DISTINCT: list every distinct cuisine
SELECT DISTINCT cuisine
FROM restaurants;

-- 3. ORDER BY + LIMIT: the 5 highest-value orders by amount_inr
SELECT order_id, customer_id, restaurant_id, amount_inr
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- 4. LIKE with %: find a restaurant whose name contains a keyword ("Spice")
SELECT restaurant_id, name, cuisine, city
FROM restaurants
WHERE name LIKE '%Spice%';

-- 5. IN: customers whose city is in a 2-city list (Mumbai, Delhi)
SELECT customer_id, name, city
FROM customers
WHERE city IN ('Mumbai', 'Delhi');

-- 6. BETWEEN: orders with amount_inr within a stated range (500 to 1500 inclusive)
SELECT order_id, amount_inr
FROM orders
WHERE amount_inr BETWEEN 500 AND 1500;

-- 6b. NOT BETWEEN: orders with amount_inr outside that same range
SELECT order_id, amount_inr
FROM orders
WHERE amount_inr NOT BETWEEN 500 AND 1500;

-- 7. IS NULL: orders with no rating recorded
-- (these are exactly the Cancelled/Pending orders, which never receive a rating:
--  62 rows here = 35 Cancelled + 27 Pending from verify_output.txt)
SELECT order_id, status, rating
FROM orders
WHERE rating IS NULL;

-- verify.sql
-- Run against swiggy_capstone.db to confirm the deterministic dataset loaded correctly.
-- Expected results (see verify_output.txt for the actual run):
--   restaurants: 15 | customers: 50 | orders: 420 | cuisine_targets: 6
--   orders.status -> Delivered: 358, Cancelled: 35, Pending: 27

SELECT COUNT(*) AS restaurant_count FROM restaurants;
SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS order_count FROM orders;
SELECT COUNT(*) AS cuisine_target_count FROM cuisine_targets;

SELECT status, COUNT(*) AS num_orders
FROM orders
GROUP BY status;

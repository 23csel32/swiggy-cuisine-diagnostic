-- 02_aggregation_joins.sql

-- (a) INNER JOIN orders -> restaurants, GROUP BY cuisine,
--     Delivered orders only, HAVING total_revenue > 40000
SELECT r.cuisine,
       COUNT(*)            AS num_orders,
       SUM(o.amount_inr)   AS total_revenue,
       AVG(o.amount_inr)   AS avg_revenue
FROM orders o
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine
HAVING total_revenue > 40000
ORDER BY total_revenue DESC;

-- (b) LEFT JOIN restaurants -> orders, GROUP BY restaurant,
--     counts ALL statuses so a restaurant with zero matching orders
--     would still appear with a count of 0 (COUNT(o.order_id) skips NULLs
--     from unmatched rows, unlike COUNT(*)), ordered ascending to surface
--     the least-active restaurants first.
SELECT r.restaurant_id,
       r.name,
       COUNT(o.order_id) AS total_orders
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY total_orders ASC;

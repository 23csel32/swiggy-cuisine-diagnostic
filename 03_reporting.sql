-- 03_reporting.sql

-- (a) CASE WHEN tiering: tier every restaurant by its total Delivered revenue
SELECT r.restaurant_id,
       r.name,
       SUM(o.amount_inr) AS total_revenue,
       CASE
           WHEN SUM(o.amount_inr) >= 50000 THEN 'High'
           WHEN SUM(o.amount_inr) >= 20000 THEN 'Medium'
           ELSE 'Low'
       END AS tier
FROM orders o
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.restaurant_id, r.name
ORDER BY total_revenue DESC;

-- (b) Monthly-by-cuisine business report (Delivered orders only).
--     This is the exact query exported to monthly_cuisine_revenue.csv (Task 6).
SELECT r.cuisine,
       strftime('%Y-%m', o.order_date) AS month,
       COUNT(*)          AS order_count,
       SUM(o.amount_inr) AS total_revenue,
       AVG(o.amount_inr) AS avg_revenue
FROM orders o
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine, month
ORDER BY r.cuisine, month;

-- (c) Derived-fields query: cuisine-level total revenue vs. target,
--     with variance, percentage_variance (forced float division), and status tag.
SELECT cr.cuisine,
       cr.total_revenue,
       ct.target_revenue_inr,
       (ct.target_revenue_inr - cr.total_revenue) AS variance,
       ((cr.total_revenue - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr AS percentage_variance,
       CASE
           WHEN cr.total_revenue >= ct.target_revenue_inr THEN 'Above Target'
           WHEN ((ct.target_revenue_inr - cr.total_revenue) * 100.0) / ct.target_revenue_inr <= 15 THEN 'Below Target - Watch'
           ELSE 'Below Target - Critical'
       END AS status_tag
FROM (
    SELECT r.cuisine, SUM(o.amount_inr) AS total_revenue
    FROM orders o
    INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    WHERE o.status = 'Delivered'
    GROUP BY r.cuisine
) cr
INNER JOIN cuisine_targets ct ON cr.cuisine = ct.cuisine
ORDER BY percentage_variance DESC;

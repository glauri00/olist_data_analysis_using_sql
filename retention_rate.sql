WITH customers_count_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(o.order_id) AS orders_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN orders_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        (SUM(CASE WHEN orders_count > 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS retention_rate_percentage
FROM customers_count_orders

SELECT 
    c.customer_unique_id,
    c.customer_city,
    ROUND(SUM(payment_value), 2) AS total_spending_lifetime,
    RANK() OVER(ORDER BY SUM(payment_value) DESC) AS customers_rank
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_payments op ON op.order_id = o.order_id
GROUP BY c.customer_unique_id, c.customer_city
ORDER BY customers_rank
LIMIT 100;
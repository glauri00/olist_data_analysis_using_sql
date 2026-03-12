WITH daily_sales AS (
    SELECT 
        DATE(o.order_purchase_timestamp) AS ord_date,
        ROUND(SUM(op.payment_value), 2) AS daily_total_sales
    FROM order_payments op
    JOIN orders o ON op.order_id = o.order_id
    WHERE DAYOFWEEK(DATE(o.order_purchase_timestamp)) NOT IN (1, 7)
    GROUP BY DATE(o.order_purchase_timestamp)
),
moving_avg AS (
    SELECT
        ord_date,
        daily_total_sales,
        ROUND(AVG(daily_total_sales) OVER(ORDER BY ord_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS mov_avg_7_days
    FROM daily_sales
)
SELECT *
FROM moving_avg
ORDER BY ord_date;
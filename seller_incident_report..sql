WITH average_delivery_time_per_state AS(
	SELECT
		seller_state,
        ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_delivered_carrier_date)),0) AS average_delivery_days
	FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    INNER JOIN sellers s ON s.seller_id = oi.seller_id
    WHERE order_status = 'delivered'
    GROUP BY seller_state
), 
average_delivery_time_per_customer AS(
	SELECT 
		s.seller_id AS id_seller,
		seller_state,
		ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_delivered_carrier_date)),0) AS avg_customer_delivery_days
	FROM sellers s
	INNER JOIN order_items oi ON s.seller_id = oi.seller_id
	INNER JOIN orders o ON o.order_id = oi.order_id
    WHERE order_status = 'delivered'
    GROUP BY s.seller_id, seller_state
)
SELECT 
	id_seller,
    adc.seller_state,
    avg_customer_delivery_days
FROM average_delivery_time_per_customer adc
INNER JOIN average_delivery_time_per_state ads ON ads.seller_state = adc.seller_state
WHERE avg_customer_delivery_days > 1.2 * average_delivery_days
ORDER BY avg_customer_delivery_days DESC
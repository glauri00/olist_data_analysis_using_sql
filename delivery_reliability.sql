WITH delivery_details AS(
	SELECT 
		customer_state AS State,
		DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS delayed_delivery
	FROM orders o
	INNER JOIN customers c ON o.customer_id = c.customer_id
	WHERE order_status = 'delivered'
)

SELECT 
	State, ROUND(AVG(delayed_delivery) ,0) AS Average_Days_Late
FROM delivery_details d
WHERE delayed_delivery>0
GROUP BY State
ORDER BY Average_Days_Late DESC


WITH last_order_per_customer AS(
	SELECT
		customer_unique_id,
        MAX(order_purchase_timestamp) AS last_order_date
        FROM orders o 
        INNER JOIN customers c ON c.customer_id = o.customer_id
        WHERE order_status = 'delivered'
		GROUP BY customer_unique_id
),
total_orders_per_customer AS(
	SELECT
		customer_unique_id,
        COUNT(order_id) AS total_orders
        FROM orders o 
        INNER JOIN customers c ON c.customer_id = o.customer_id
        WHERE order_status = 'delivered'
        GROUP BY customer_unique_id
),
total_spent_per_order AS(
	SELECT
		oi.order_id AS id_order,
        (price + freight_value) AS spent_per_order
        FROM order_items oi
        INNER JOIN orders o ON oi.order_id = o.order_id
        WHERE order_status = 'delivered'
        
),
total_spent_per_customer AS(
	SELECT 
		customer_unique_id,
        SUM(spent_per_order) AS total_amount_spent_per_customer
        FROM total_spent_per_order ts
        INNER JOIN orders o ON o.order_id = ts.id_order
        INNER JOIN customers c ON c.customer_id = o.customer_id
        GROUP BY customer_unique_id
),
customer_recency AS(
	SELECT 
		lo.customer_unique_id,
		last_order_date,
        (SELECT MAX(order_purchase_timestamp) FROM orders) AS max_date,
		DATEDIFF( (SELECT MAX(order_purchase_timestamp) FROM orders), last_order_date) AS recency
	FROM last_order_per_customer lo
	ORDER BY recency DESC
),
rfm_analysis AS(
	SELECT 
		cr.customer_unique_id, 
		last_order_date, 
		total_amount_spent_per_customer, 
		recency, 
		NTILE(5) OVER(ORDER BY last_order_date DESC) AS customer_group_order_date,
		NTILE(5) OVER(ORDER BY total_amount_spent_per_customer ASC) AS customer_group_total_amount,
		NTILE(5) OVER(ORDER BY recency ASC) AS customer_group_recency
	FROM customer_recency cr
	INNER JOIN total_orders_per_customer topc ON cr.customer_unique_id = topc.customer_unique_id
	INNER JOIN total_spent_per_customer ts ON cr.customer_unique_id = ts.customer_unique_id
)

SELECT 
	customer_unique_id,
    customer_group_order_date,
    customer_group_total_amount,
    customer_group_recency
FROM rfm_analysis
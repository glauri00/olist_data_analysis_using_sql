WITH customer_first_order AS(
	SELECT
		customer_unique_id,
        MIN(order_purchase_timestamp) AS first_order_date
	FROM orders o
	INNER JOIN customers c ON o.customer_id = c.customer_id
    WHERE order_status = 'delivered'
	GROUP BY customer_unique_id
),
first_order_in_january_2017 AS(
	SELECT 
		customer_unique_id,
		first_order_date
	FROM customer_first_order
    WHERE first_order_date > '2017-01-01' AND first_order_date < '2017-02-01'
),
subsequent_purchase AS(
	SELECT
		fo.customer_unique_id,
        first_order_date,
        DATE_ADD(first_order_date, INTERVAL 6 month) AS end_date,
        COUNT(order_id) AS total_orders
    FROM first_order_in_january_2017 fo
    INNER JOIN customers c ON c.customer_unique_id = fo.customer_unique_id
	INNER JOIN orders o ON o.customer_id = c.customer_id
    WHERE order_purchase_timestamp > first_order_date AND order_purchase_timestamp <= DATE_ADD(first_order_date, INTERVAL 6 month)
    GROUP BY customer_unique_id
)

SELECT 
	COUNT(DISTINCT sp.customer_unique_id) AS number_of_customers_comeback,
    (SELECT COUNT(*) FROM first_order_in_january_2017) AS number_of_customers_january,
    AVG(total_orders) AS avg_orders
FROM subsequent_purchase sp
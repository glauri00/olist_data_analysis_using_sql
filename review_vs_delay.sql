WITH delivery_status AS(
	SELECT 
        o.order_id,
        AVG(review_score) AS avg_rev_score,
        DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS delivery_diff,
        CASE
			WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'In ritardo' 
            ELSE 'In tempo' END AS delivery_stat
    FROM order_reviews ordrev
    INNER JOIN orders o ON ordrev.order_id = o.order_id
    WHERE order_status='delivered'
    GROUP BY o.order_id
)

SELECT delivery_stat, ROUND(AVG(avg_rev_score),2)
FROM delivery_status
GROUP BY delivery_stat
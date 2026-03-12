WITH sellers_identification AS(
	SELECT
		s.seller_id,
        count(product_id) AS products_selled,
        count(distinct oi.order_id) AS total_orders,
        avg(review_score) AS avg_score
        FROM sellers s
        INNER JOIN order_items oi ON oi.seller_id = s.seller_id
        INNER JOIN order_reviews ordrev ON ordrev.order_id = oi.order_id
        group by s.seller_id
        HAVING avg(review_score) <3.0 AND count(product_id) > 50
)

SELECT seller_id, avg_score, total_orders
FROM sellers_identification
WITH sales_per_category AS(
	SELECT
		customer_state AS State,
        SUM(price + freight_value) AS total_sales,
        product_category_name_english AS product_category
        FROM order_items oi
        INNER JOIN products p ON oi.product_id = p.product_id
        INNER JOIN product_category_name_translation pt ON p.product_category_name = pt.product_category_name
        INNER JOIN orders o ON oi.order_id = o.order_id
		INNER JOIN customers c ON o.customer_id = c.customer_id
        WHERE order_status = 'delivered'
        GROUP BY State, product_category
),
sales_rank AS(
	SELECT 
    State,
    product_category,
    total_sales,
    RANK() OVER(PARTITION BY State ORDER BY total_sales DESC) AS rank_per_state
    FROM sales_per_category
)
SELECT *
FROM sales_rank
WHERE rank_per_state<=3
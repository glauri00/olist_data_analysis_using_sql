/* Analisi del Fatturato Mensile: Calcola il fatturato totale 
e il numero di ordini per ogni mese e anno. 
Ordina i risultati cronologicamente.*/
WITH Order_Summary AS(
	SELECT 
		DISTINCT(EXTRACT(year from o.order_purchase_timestamp)) AS Year,
		EXTRACT(month from o.order_purchase_timestamp) AS Month,
		seller_id AS Seller,
        oi.order_id,
		(oi.price + oi.freight_value) AS item_total_value
	FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    WHERE order_status = 'delivered'
)
SELECT 
	Year,
    Month,
    Seller,
    ROUND(SUM(item_total_value), 2) AS fatturato_mensile,
    COUNT(DISTINCT order_id) AS numero_ordini
FROM Order_summary
GROUP BY Year, Month
ORDER BY Year DESC, Month DESC, fatturato_mensile DESC;


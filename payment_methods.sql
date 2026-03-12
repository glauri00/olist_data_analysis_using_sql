WITH Payment_Stats AS (
    SELECT 
        payment_type,
        COUNT(DISTINCT order_id1) AS numero_transazioni,
        SUM(payment_value) AS volume_totale,
        AVG(payment_value) AS ticket_medio
    FROM order_payments
    GROUP BY payment_type
)
SELECT 
    payment_type,
    numero_transazioni,
    ROUND((numero_transazioni * 100.0) / SUM(numero_transazioni) OVER(), 2) AS perc_utilizzo,
    ROUND(ticket_medio, 2) AS valore_medio_transazione,
    ROUND(volume_totale, 2) AS volume_totale_incassato
FROM Payment_Stats
ORDER BY perc_utilizzo DESC;
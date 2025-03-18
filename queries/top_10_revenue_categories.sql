-- TODO: Esta consulta devolverá una tabla con las 10 categorías con mayores ingresos
-- (en inglés), el número de pedidos y sus ingresos totales. La primera columna será
-- Category, que contendrá las 10 categorías con mayores ingresos; la segunda será
-- Num_order, con el total de pedidos de cada categoría; y la última será Revenue,
-- con el ingreso total de cada categoría.
-- PISTA: Todos los pedidos deben tener un estado 'delivered' y tanto la categoría
-- como la fecha real de entrega no deben ser nulas.
SELECT product_category_name_english AS Category,
    COUNT(DISTINCT oo.order_id) AS Num_order,
    SUM(payment_value) AS Revenue
FROM olist_orders oo
    INNER JOIN olist_order_items ooi ON ooi.order_id = oo.order_id
    INNER JOIN olist_products op ON op.product_id = ooi.product_id
    INNER JOIN product_category_name_translation pcnt ON pcnt.product_category_name = op.product_category_name
    INNER JOIN olist_order_payments oop ON oop.order_id = oo.order_id
WHERE (
        oo.order_status = "delivered"
        AND op.product_category_name IS NOT NULL
        AND oo.order_delivered_customer_date IS NOT NULL
    )
GROUP BY Category
ORDER BY Revenue DESC
LIMIT 10
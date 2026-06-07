
SELECT 'customers'    AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'sellers',       COUNT(*) FROM sellers
UNION ALL
SELECT 'products',      COUNT(*) FROM products
UNION ALL
SELECT 'orders',        COUNT(*) FROM orders
UNION ALL
SELECT 'order_items',   COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments',COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'geolocation',   COUNT(*) FROM geolocation;




-- Understand the difference between customer_id and customer_unique_id
SELECT 
    COUNT(customer_id)        AS total_orders,
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers;



-- Understand what order_status values exist
SELECT order_status, COUNT(*) AS count
FROM orders
GROUP BY order_status
ORDER BY count DESC;


-- Understand what payment types exist
SELECT payment_type, COUNT(*) AS count
FROM order_payments
GROUP BY payment_type
ORDER BY count DESC;



-- Understand review scores
SELECT review_score, COUNT(*) AS count
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;


-- Understand what order_item_id actually is
SELECT order_id, COUNT(order_item_id) AS items_in_order
FROM order_items
GROUP BY order_id
ORDER BY items_in_order DESC
LIMIT 5;



SELECT
o.order_id,
o.order_status,
o.order_purchase_timestamp,
c.customer_unique_id,
c.customer_city,
c.customer_state,
oi.product_id,
oi.price,
oi.freight_value,
p.product_category_name,
t.product_category_name_english,
s.seller_id,
s.seller_city,
s.seller_state,
op.payment_type,
op.payment_value,
r.review_score
FROM orders o
JOIN customers c
   ON o.customer_id = c.customer_id
JOIN order_items oi
   ON o.order_id = oi.order_id
JOIN products p
   ON oi.product_id = p.product_id
JOIN product_category_name_translation t
   ON p.product_category_name = t.product_category_name
JOIN sellers s
   ON oi.seller_id = s.seller_id
JOIN order_payments op
   ON o.order_id = op.order_id
LEFT JOIN order_reviews r
   ON o.order_id = r.order_id
LIMIT 10;




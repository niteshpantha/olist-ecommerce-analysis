# Olist Brazilian E-Commerce — Data Dictionary

> **Database:** olist_db  
> **Total Tables:** 9  
> **Source:** [Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
> **Last Updated:** June 2026

---

## Table Relationship Summary

| Child Table | Foreign Key | Parent Table |
|---|---|---|
| orders | customer_id | customers |
| order_items | order_id | orders |
| order_items | product_id | products |
| order_items | seller_id | sellers |
| order_payments | order_id | orders |
| order_reviews | order_id | orders |
| geolocation | *(soft join via zip code)* | customers, sellers |
| product_category_name_translation | *(soft join via category name)* | products |

---

## 1. customers

Contains one row per order placed. Note: a single real customer can appear multiple times with different `customer_id` values (one per order), but always has the same `customer_unique_id`.

> **Key insight:** 99,441 total rows but only 96,096 unique customers — meaning 3,345 customers ordered more than once.

| Column | Data Type | Description |
|---|---|---|
| customer_id | VARCHAR(50) | **Primary Key.** Unique ID per order — one customer can have multiple of these. Do NOT use to count unique customers. |
| customer_unique_id | VARCHAR(50) | True unique identifier per customer. Always use this when counting distinct customers. |
| customer_zip_code_prefix | VARCHAR(10) | First 5 digits of customer's zip code. Used to join with geolocation table. |
| customer_city | VARCHAR(100) | City where the customer is located. |
| customer_state | CHAR(2) | Brazilian state abbreviation (e.g. SP = São Paulo, RJ = Rio de Janeiro). |

---

## 2. sellers

Contains one row per registered seller on the Olist platform.

| Column | Data Type | Description |
|---|---|---|
| seller_id | VARCHAR(50) | **Primary Key.** Unique identifier for each seller. |
| seller_zip_code_prefix | VARCHAR(10) | First 5 digits of seller's zip code. Used to join with geolocation table. |
| seller_city | VARCHAR(100) | City where the seller operates. |
| seller_state | CHAR(2) | Brazilian state abbreviation where the seller is located. |

---

## 3. products

Contains one row per product listed on Olist. Physical dimensions are used for freight calculation.

| Column | Data Type | Description |
|---|---|---|
| product_id | VARCHAR(50) | **Primary Key.** Unique identifier for each product. |
| product_category_name | VARCHAR(100) | Product category name in Portuguese. Join with product_category_name_translation to get English name. |
| product_name_lenght | INT | Number of characters in the product name. (Note: typo in original dataset — should be "length") |
| product_description_lenght | INT | Number of characters in the product description. (Note: typo in original dataset) |
| product_photos_qty | INT | Number of photos published for this product. |
| product_weight_g | NUMERIC | Product weight in grams. Used to calculate freight cost. |
| product_length_cm | NUMERIC | Product length in centimetres. |
| product_height_cm | NUMERIC | Product height in centimetres. |
| product_width_cm | NUMERIC | Product width in centimetres. |

---

## 4. product_category_name_translation

Lookup table that translates Portuguese product category names to English. Joins to products via product_category_name.

| Column | Data Type | Description |
|---|---|---|
| product_category_name | VARCHAR(100) | **Primary Key.** Category name in Portuguese (matches products table). |
| product_category_name_english | VARCHAR(100) | Category name translated to English. Always use this in reports and dashboards. |

---

## 5. geolocation

Contains GPS coordinates mapped to Brazilian zip codes. Has no primary key because one zip code has multiple coordinate readings from different deliveries.

> **Usage note:** Always aggregate with AVG(lat) and AVG(lng) grouped by zip code before joining to other tables.

| Column | Data Type | Description |
|---|---|---|
| geolocation_zip_code_prefix | VARCHAR(10) | 5-digit zip code prefix. Not unique — one zip code has many rows. |
| geolocation_lat | NUMERIC(9,6) | Latitude coordinate. Average per zip code for reliable location mapping. |
| geolocation_lng | NUMERIC(9,6) | Longitude coordinate. Average per zip code for reliable location mapping. |
| geolocation_city | VARCHAR(100) | City name for this zip code area. |
| geolocation_state | CHAR(2) | Brazilian state abbreviation. |

---

## 6. orders

Central table of the database. Each row is one order. All other transactional tables (items, payments, reviews) connect back to this table via order_id.

> **Key insight:** 96,478 out of 99,441 orders (97%) were successfully delivered.

| Column | Data Type | Description |
|---|---|---|
| order_id | VARCHAR(50) | **Primary Key.** Unique identifier for each order. |
| customer_id | VARCHAR(50) | **Foreign Key → customers.** Links each order to a customer. |
| order_status | VARCHAR(20) | Current status of the order. Possible values: `created`, `approved`, `invoiced`, `processing`, `shipped`, `delivered`, `canceled`, `unavailable`. |
| order_purchase_timestamp | TIMESTAMP | Date and time when the customer placed the order. |
| order_approved_at | TIMESTAMP | Date and time when payment was approved. |
| order_delivered_carrier_date | TIMESTAMP | Date and time the order was handed to the logistics carrier. |
| order_delivered_customer_date | TIMESTAMP | Actual date and time the order was delivered to the customer. NULL if not yet delivered. |
| order_estimated_delivery_date | TIMESTAMP | Estimated delivery date shown to the customer at purchase. Used to calculate delivery delay. |

---

## 7. order_items

Contains one row per item within an order. A single order can have multiple items (max seen: 21 items in one order).

> **Key insight:** order_item_id is NOT a unique identifier — it is simply a sequence number (1, 2, 3...) counting items within one order.

| Column | Data Type | Description |
|---|---|---|
| order_id | VARCHAR(50) | **Primary Key (composite) + Foreign Key → orders.** The order this item belongs to. |
| order_item_id | INT | **Primary Key (composite).** Sequence number of this item within the order (1 = first item, 2 = second item, etc.). |
| product_id | VARCHAR(50) | **Foreign Key → products.** The product that was purchased. |
| seller_id | VARCHAR(50) | **Foreign Key → sellers.** The seller who sold this item. |
| shipping_limit_date | TIMESTAMP | Deadline by which the seller must hand the item to the carrier. |
| price | NUMERIC(10,2) | Price of the item in Brazilian Reais (BRL). Excludes freight. |
| freight_value | NUMERIC(10,2) | Freight/shipping cost for this item in BRL. When one order has multiple items, freight is split across items. |

---

## 8. order_payments

Contains payment information for each order. One order can have multiple payment rows if the customer used multiple payment methods (e.g. credit card + voucher).

> **Key insight:** Credit card is the dominant payment method (74%). Boleto is a uniquely Brazilian bank slip payment system — 19% of orders.

| Column | Data Type | Description |
|---|---|---|
| order_id | VARCHAR(50) | **Primary Key (composite) + Foreign Key → orders.** The order this payment belongs to. |
| payment_sequential | INT | **Primary Key (composite).** Sequence number when multiple payment methods are used for one order (1 = first payment method). |
| payment_type | VARCHAR(20) | Payment method used. Values: `credit_card`, `boleto`, `voucher`, `debit_card`, `not_defined`. |
| payment_installments | INT | Number of installments chosen by the customer. Common in Brazil for credit card purchases. 1 = paid in full. |
| payment_value | NUMERIC(10,2) | Amount paid via this payment method in BRL. |

---

## 9. order_reviews

Contains customer reviews submitted after delivery. One order gets one review, but the primary key is composite because of duplicate review_id entries in the raw data.

> **Key insight:** 57% of customers gave 5 stars. The distribution is U-shaped — customers either love (5★) or hate (1★), with few neutral reviews.

| Column | Data Type | Description |
|---|---|---|
| review_id | VARCHAR(50) | **Primary Key (composite).** Unique identifier for the review. |
| order_id | VARCHAR(50) | **Primary Key (composite) + Foreign Key → orders.** The order being reviewed. |
| review_score | INT | Star rating given by the customer. Scale: 1 (worst) to 5 (best). |
| review_comment_title | VARCHAR(100) | Optional short title of the review written by the customer. Often NULL. |
| review_comment_message | TEXT | Optional full review text written by the customer in Portuguese. Often NULL. |
| review_creation_date | TIMESTAMP | Date the review form was sent to the customer. |
| review_answer_timestamp | TIMESTAMP | Date and time the customer submitted the review. |

---

## Quick Reference — Key Joins

```sql
-- The master join: orders + items + products + sellers + customers
SELECT *
FROM orders o
JOIN customers c    ON o.customer_id   = c.customer_id
JOIN order_items oi ON o.order_id      = oi.order_id
JOIN products p     ON oi.product_id   = p.product_id
JOIN sellers s      ON oi.seller_id    = s.seller_id;

-- Add English category names
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name

-- Add payments
JOIN order_payments op ON o.order_id = op.order_id

-- Add reviews
JOIN order_reviews r ON o.order_id = r.order_id

-- Add geolocation (always aggregate first)
JOIN (
    SELECT geolocation_zip_code_prefix,
           AVG(geolocation_lat) AS lat,
           AVG(geolocation_lng) AS lng
    FROM geolocation
    GROUP BY geolocation_zip_code_prefix
) g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
```

---

*Data Dictionary prepared as part of the Olist E-Commerce Data Analysis Portfolio Project.*

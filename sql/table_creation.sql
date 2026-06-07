CREATE table customers (
	customer_id varchar(50)PRIMARY KEY,
	customer_unique_id varchar(50),
	customer_zip_code_prefix varchar(10),
	customer_city varchar(100),
	customer_state char(100)
);

CREATE table sellers (
	seller_id varchar(50) PRIMARY KEY,
	seller_zip_code_prefix varchar(10),
	seller_city varchar(100),
	seller_state char(10)
);

CREATE table products (
	product_id varchar(50) PRIMARY KEY,
	product_category_name varchar(100),
	product_name_length INT,
	product_description_length INT,
	product_photos_qty INT,
	product_weight_g NUMERIC,
	product_length_cm NUMERIC,
	product_height_cm NUMERIC,
	product_weight_cm NUMERIC
);

CREATE table product_category_name_translation (
	product_category_name varchar(100) PRIMARY KEY,
	product_category_name_english varchar(100)
);

CREATE table geolocation (
	geolocation_zip_code_prefix varchar(50),
	geolocation_lat NUMERIC(9,6),
	geolocation_lng NUMERIC(9,6),
	geolocation_city varchar(100),
	geolocation_state char(100)
);

CREATE table orders (
	order_id varchar(50) primary key,
	customer_id varchar(50) REFERENCES customers(customer_id),
	order_status varchar(20),
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP
);
CREATE table order_items (
	order_id varchar(50) REFERENCES orders(order_id),
	order_item_id INT,
	product_id varchar(50)  REFERENCES products(product_id),
	seller_id varchar(50) REFERENCES sellers(seller_id),
	shipping_limit_date TIMESTAMP,
	price NUMERIC(10,2),
	freight_value NUMERIC(10,2),
	PRIMARY KEY (order_id, order_item_id)
);

CREATE table order_payments (
	order_id varchar(50) REFERENCES orders(order_id),
	payment_sequential INT,
	payment_type varchar(20),
	payment_installments INT,
	payment_value NUMERIC(10,2),
	PRIMARY KEY (order_id, payment_sequential)
);

CREATE table order_reviews (
	review_id varchar(50),
	order_id varchar(50) REFERENCES orders(order_id),
	review_score INT,
	review_comment_title varchar(100),
	review_comment_message TEXT,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP,
	PRIMARY KEY (review_id, order_id)
);

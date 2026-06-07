-- ============================================
-- Q1: Monthly Revenue Trend
-- Business Question: How is Olist growing over time?
-- ============================================
select
	date_trunc('month', o.order_purchase_timestamp) as order_month,
	count(distinct o.order_id) as total_orders,
	ROUND(sum(op.payment_value), 2) as total_revenue,
	ROUND(avg(op.payment_value), 2) as avg_order_value
from orders o
join order_payments op
	on o.order_id = op.order_id
where o.order_status = 'delivered'
group by order_month
order by order_month;



-- ============================================
-- Q2: Top Product Categories by Revenue
-- Business Question: Which categories drive the most revenue?
-- ============================================

select
	t.product_category_name_english as category_name,
	round(sum(oi.price), 2) as total_revenue
from
	product_category_name_translation t
join products p
on
	t.product_category_name = p.product_category_name
join order_items oi
on
	p.product_id = oi.product_id
join orders o
on 
	oi.order_id = o.order_id
where o.order_status = 'delivered'
group by category_name
order by total_revenue DESC
limit 10;


-- ============================================
-- Q3: Customer Distribution by State
-- Business Question: Which Brazilian states have the most customers?
-- ============================================
select 
	c.customer_state as brazilian_state,
	count(distinct c.customer_unique_id) as unique_customers
from customers c
group by customer_state
order by unique_customers desc 
limit 5;


-- ============================================
-- Q4: Delivery Performance by State
-- Business Question: Which states have the worst delivery delays?
-- ============================================

select 
	c.customer_state as state,
	count(distinct o.order_id) as total_orders,
	round(avg(
		extract(epoch from (
			o.order_delivered_customer_date -
			order_purchase_timestamp)) / 86400
	), 2) as avg_delivery_days,

	round(avg(
		extract(epoch from (
			order_estimated_delivery_date -
			order_delivered_customer_date)) / 86400
	), 2) as avg_days_early_late,
	sum(case 
		when o.order_delivered_customer_date > o.order_estimated_delivery_date
		then 1 else 0
	end) as late_orders,
	round(100* sum(case
					when o.order_delivered_customer_date > o.order_estimated_delivery_date
					then 1 else 0
					end) / count(distinct o.order_id), 2) as late_pct
from orders o
join customers c
	on o.customer_id = c.customer_id
where o.order_status = 'delivered'
	and o.order_delivered_customer_date is not null
group by c.customer_state
order by late_pct DESC;

-- ============================================
-- Q5: Impact of Delivery Delay on Review Scores
-- Business Question: Does late delivery hurt customer satisfaction?
-- ============================================

select 
	(case
		when o.order_delivered_customer_date <= o.order_estimated_delivery_date
		then 'on time'
		else 'late'
		end)  as delivery_status,
	round(avg(r.review_score) :: decimal) as avg_review_score,
	count(distinct o.order_id) as total_orders
from order_reviews r
join orders o
on r.order_id = o.order_id
group by delivery_status
order by total_orders DESC;


-- ============================================
-- Q6: Top Seller Performance
-- Business Question: Who are the best sellers on Olist?

-- ============================================

select 
	s.seller_id,
	s.seller_city,
	s.seller_state,
	count(distinct oi.order_id) as total_orders,
	round(avg(oi.price), 2) as avg_item_price,
	round(sum(oi.price), 2) as total_revenue,
	round(avg(r.review_score) :: decimal) as avg_review_score,
	rank() over ( order by sum(oi.price)) as revenue_rank
from sellers s
join order_items oi
on s.seller_id = oi.seller_id
join order_reviews r
on oi.order_id = r.order_id
group by s.seller_id, s.seller_city, s.seller_state
order by total_revenue desc
limit 10;


-- ============================================
-- Q7: Customer Retention
-- Business Question: How many customers purchase more than once?
-- ============================================

with customer_orders as (
select 
	c.customer_unique_id,
	count(o.order_id) as total_orders
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.customer_unique_id
)
select 
	case 
	when total_orders = 1 then '1 order'
	when total_orders = 2 then '2 orders'
	when total_orders = 3 then '3 orders'
	else '4+ orders'
	end as customer_segment,
	count(*) as total_customers,
	 ROUND(100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (), 2) AS pct_of_customers
from customer_orders
group by customer_segment
order by customer_segment;









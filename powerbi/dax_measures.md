##total revenue

Total Revenue = 
SUMX(
    order_payments,
    order_payments[payment_value]
)


##total orders

Total Orders = 
DISTINCTCOUNT(orders[order_id])


##total customers
Total Customers = 
DISTINCTCOUNT(customers[customer_unique_id])


#average order value

Avg Order Value = 
DIVIDE(
    [Total Revenue],
    [Total Orders],
    0
)


#average review score 

Avg Review Score = 
AVERAGE(order_reviews[review_score])


##On Time Delivery %

On Time Delivery % = 
VAR delivered_orders =
    CALCULATE(
        COUNTROWS(orders),
        orders[order_status] = "delivered",
        NOT ISBLANK(orders[order_delivered_customer_date])
    )
VAR on_time =
    CALCULATE(
        COUNTROWS(orders),
        orders[order_status] = "delivered",
        NOT ISBLANK(orders[order_delivered_customer_date]),
        orders[order_delivered_customer_date] <= orders[order_estimated_delivery_date]
    )
RETURN
    DIVIDE(on_time, delivered_orders, 0) * 100

    
##Late Orders

Late Orders = 
CALCULATE(
    COUNTROWS(orders),
    orders[order_status] = "delivered",
    NOT ISBLANK(orders[order_delivered_customer_date]),
    orders[order_delivered_customer_date] > orders[order_estimated_delivery_date]
)


##Total Revenue By Product

Total Product Revenue = 
SUMX(
    order_items,
    order_items[price]
)

/*
 This model expands the orders seed file with the information of the clients
*/

{{ config(materialized='table') }}

select 
    orders.order_id,
    orders.client_name,
    orders.product,
    orders.quantity,
    orders.price,
    clients.street,
    clients.city,
    clients.country,
    count(orders.order_id) OVER(PARTITION BY orders.product,clients.country) AS no_orders_per_product_per_country
from {{ref("orders")}} as orders
left join {{ref("clients")}} as clients
on orders.client_name = clients.client_name


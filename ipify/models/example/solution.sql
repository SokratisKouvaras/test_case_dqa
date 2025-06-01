
/*
A small table that answers the following question: “Per country, which product is the most frequently purchased?”
*/
{{ config(materialized='table') }}

with load_data as (
select 
base.*,
max(base.no_orders_per_product_per_country) OVER(PARTITION BY base.country) AS max_count
from {{ref("mart_orders")}} as base
)
select 
    country as "Country",
    product as "Product",
    max_count as "Order Count"
from load_data 
where no_orders_per_product_per_country = max_count
group by country,product,max_count

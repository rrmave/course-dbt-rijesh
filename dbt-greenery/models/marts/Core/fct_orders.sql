{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    user_guid,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    status as order_status,
    count(product_id) total_type_of_products,
    sum(quantity) total_num_of_items_per_order
FROM {{ ref('stg_orders') }}
LEFT JOIN {{ref('stg_order_items')}} 
USING (order_id)
GROUP BY order_id,
    user_guid,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    order_status
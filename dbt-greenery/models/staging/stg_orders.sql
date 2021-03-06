{{
  config(
    materialized='table'
  )
}}

SELECT 
    id as my_orders_id,
    order_id,
    user_id as user_guid,
    promo_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
FROM {{ source('tutorial', 'orders') }}
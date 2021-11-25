{{
  config(
    materialized='table'
  )
}}

SELECT 
    id as my_order_item_id,
    order_id,
    product_id,
    quantity
FROM {{ source('tutorial', 'order_items') }}
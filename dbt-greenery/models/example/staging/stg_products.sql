{{
  config(
    materialized='table'
  )
}}

SELECT 
    id as my_product_id,
    product_id,
    name,
    price,
    quantity 
FROM {{ source('tutorial', 'products') }}
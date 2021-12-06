{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id as product_guid,
    name as product_name,
    quantity as product_in_stock
FROM 
    {{ref('stg_products')}}
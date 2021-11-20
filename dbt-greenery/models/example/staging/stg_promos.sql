{{
  config(
    materialized='table'
  )
}}

SELECT 
  id as my_promo_id,
  promo_id,
  discout as discount,
  status
FROM {{ source('tutorial', 'promos') }}
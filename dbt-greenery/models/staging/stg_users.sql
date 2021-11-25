{{
  config(
    materialized='table'
  )
}}

SELECT 
    id as my_user_id,
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
FROM {{ source('tutorial', 'users') }}
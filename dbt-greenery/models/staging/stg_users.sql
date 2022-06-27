{{
  config(
    materialized='table'
  )
}}

SELECT 
    id as my_user_id,
    user_id as user_guid,
    first_name as firstname,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
FROM {{ source('tutorial', 'users') }}
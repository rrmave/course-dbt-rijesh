{{
  config(
    materialized='table'
  )
}}

SELECT 
  id as my_addresses_id,
  address_id,
  address,
  zipcode,
  state,
  country 
FROM {{ source('tutorial', 'addresses') }}
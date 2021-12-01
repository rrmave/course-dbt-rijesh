{{
  config(
    materialized='table'
  )
}}

SELECT user_guid,
      first_name,
      last_name,
      email,
      zipcode,
      state,
      country 
FROM {{ref('stg_users')}} LEFT JOIN {{ref('stg_addresses')}} USING (address_id)
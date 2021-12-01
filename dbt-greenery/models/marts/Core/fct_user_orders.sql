{{
  config(
    materialized='table'
  )
}}

SELECT user_guid,
        count(1) as num_orders
        FROM {{ ref('dim_users') }}  
        JOIN {{ref('fct_orders')}}  
        USING (user_guid)
        group by user_guid
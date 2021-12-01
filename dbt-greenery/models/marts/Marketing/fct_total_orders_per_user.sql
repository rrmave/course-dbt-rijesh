{{
  config(
    materialized='table'
  )
}}

select user_guid,
      country,
      count(order_id) as total_order_count,
      sum(order_cost) as total_order_cost,
     sum(shipping_cost) as total_shipping_cost,
     sum(order_total) as total_order
    FROM {{ref('int_user_order_facts')}}
    GROUP BY user_guid,
      country
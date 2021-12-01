{{
  config(
    materialized='table'
  )
}}

select user_guid,
      email,
      zipcode,
      state,
      country,
      order_id,
      created_at,
      order_cost,
      shipping_cost,
      order_total,
      order_status,
      total_type_of_products,
      total_num_of_items_per_order
FROM {{ref('dim_users')}} LEFT JOIN 
    {{ref('fct_orders')}} USING (user_guid)
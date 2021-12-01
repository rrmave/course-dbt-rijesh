{{
  config(
    materialized='table'
  )
}}

select user_guid,
        SUM(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) as total_add_to_cart,
        SUM(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) as total_checkout,
        SUM(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) as total_delete_from_cart,
        SUM(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) as total_package_shipped,
        SUM(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) as total_page_view,
        SUM(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) as total_account_created
FROM {{ref('stg_events')}}
group by user_guid

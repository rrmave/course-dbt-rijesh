{{
  config(
    materialized='table'
  )
}}

select
      user_guid
      email,
        total_add_to_cart,
        total_checkout,
        total_delete_from_cart,
        total_package_shipped,
        total_page_view,
        total_account_created
FROM {{ref('dim_users')}} LEFT JOIN {{ref('int_type_of_events_per_user')}} USING (user_guid)
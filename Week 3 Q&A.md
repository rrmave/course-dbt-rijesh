
## Q1. What is our overall conversion rate?

Conversion Rate is 36.10%

```
{{
  config(
    materialized='view'
  )
}}

WITH session_count AS (
    SELECT COUNT(CASE WHEN event_type='checkout' THEN 1 ELSE NULL END) AS checkout_sessions_count,
    COUNT(distinct session_id) AS session_count
    FROM {{ref('stg_events')}}
)

SELECT round(((checkout_sessions_count::NUMERIC)/(session_count::NUMERIC))*100,2) AS conversion_rate_percentage 
from session_count
```

## Q1. What is our conversion rate by product?

```
{{
  config(
    materialized='view'
  )
}}

with get_product_guid as (

  select
 session_id,
    split_part(page_url, '/',5) as product_guid,
    event_type
    from {{ ref('stg_events') }}
),
products_added_to_cart_and_sessions AS (
        SELECT product_guid,
        product_name,
        session_id
        FROM get_product_guid 
        LEFT JOIN {{ref('dim_products')}} USING (product_guid)
        WHERE event_type='add_to_cart'
),
session__count_by_product AS (
    SELECT count(distinct session_id) count_sessions_by_product,
        product_guid,
        product_name
    FROM products_added_to_cart_and_sessions  
    group by product_guid,product_name
),
session__count_checkout_by_product AS (
    SELECT count(distinct session_id) count_checkout_sessions_by_product,
        product_guid,
        product_name checkedout_product_name
    FROM products_added_to_cart_and_sessions LEFT JOIN {{ref('stg_events')}} USING (session_id)
    where event_type='checkout'
    group by product_guid,product_name   
)

SELECT product_name,round(((count_checkout_sessions_by_product::NUMERIC)/(count_sessions_by_product::NUMERIC))*100,2) AS conversion_rate_by_product_percentage 
FROM session__count_checkout_by_product JOIN session__count_by_product USING (product_guid)
```

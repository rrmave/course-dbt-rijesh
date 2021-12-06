
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

| product_name        | conversion_rate_by_product_percentage |
|---------------------|---------------------------------------|
| Bird of Paradise    |                                 57.58 |
| Devil's Ivy         |                                 33.33 |
| Dragon Tree         |                                 57.14 |
| Pothos              |                                 50.00 |
| Philodendron        |                                 47.06 |
| Rubber Plant        |                                 37.14 |
| Angel Wings Begonia |                                 46.67 |
| Pilea Peperomioides |                                 48.48 |
| Majesty Palm        |                                 59.46 |
| Aloe Vera           |                                 42.86 |
| Spider Plant        |                                 54.84 |
| Bamboo              |                                 56.76 |
| Alocasia Polly      |                                 38.46 |
| Arrow Head          |                                 50.00 |
| Pink Anthurium      |                                 54.29 |
| Ficus               |                                 38.89 |
| Jade Plant          |                                 41.67 |
| ZZ Plant            |                                 58.97 |
| Calathea Makoyana   |                                 51.61 |
| Birds Nest Fern     |                                 58.82 |
| Monstera            |                                 66.67 |
| Cactus              |                                 53.13 |
| Orchid              |                                 63.89 |
| Money Tree          |                                 50.00 |
| Ponytail Palm       |                                 36.67 |
| Boston Fern         |                                 51.72 |
| Peace Lily          |                                 62.96 |
| Fiddle Leaf Fig     |                                 51.72 |
| Snake Plant         |                                 48.48 |
| String of pearls    |                                 60.98 |

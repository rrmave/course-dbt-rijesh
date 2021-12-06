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
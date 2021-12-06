{{
  config(
    materialized='table'
  )
}}

/*
{% set event_types = dbt_utils.get_query_results_as_dict(
  "SELECT DISTINCT event_type FROM" ~ ref('stg_events')) %}
*/
select user_guid,
	{% for event_type in event_types['event_type'] %}
        SUM(CASE WHEN event_type='{{event_type}}' THEN 1 ELSE 0 END) as total_{{event_type}}
        {% if not loop.last %},{% endif %}
	{% endfor %}
	FROM {{ref('stg_events')}}
	group by user_guid
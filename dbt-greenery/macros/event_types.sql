{% set event_types = dbt_utils.get_query_results_as_dict(
  "SELECT DISTINCT event_type FROM" ~ ref('stg_events')) %}
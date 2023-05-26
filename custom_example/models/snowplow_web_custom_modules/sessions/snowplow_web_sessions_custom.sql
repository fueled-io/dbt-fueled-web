{{
  config(
    materialized='incremental',
    unique_key='domain_sessionid',
    upsert_date_key='start_tstamp',
    sort='start_tstamp',
    dist='domain_sessionid',
    partition_by = fueled_utils.get_value_by_target_type(bigquery_val = {
      "field": "start_tstamp",
      "data_type": "timestamp"
    }, databricks_val='start_tstamp_date'),
    cluster_by=fueled_web.web_cluster_by_fields_sessions(),
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt')),
    fueled_optimize= true
  )
}}


select
  s.*,
  {% if target.type in ['databricks', 'spark'] -%}
  , DATE(start_tstamp) as start_tstamp_date
  {%- endif %}
  c.is_session_w_intent,
  c.is_session_w_conversion

from {{ ref('fueled_web_sessions_this_run') }} s -- join sessions_this_run to sessions_conversion_this_run to produce complete sessions table
left join {{ ref('fueled_web_sessions_conversion_this_run')}} c
on s.domain_sessionid = c.domain_sessionid

where {{ fueled_utils.is_run_with_new_events('fueled_web') }} --returns false if run doesn't contain new events.

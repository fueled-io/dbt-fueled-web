{{
  config(
    materialized='incremental',
    unique_key='user_primary_key',
    upsert_date_key='start_tstamp',
    sort='start_tstamp',
    dist='user_primary_key',
    partition_by = fueled_utils.get_value_by_target_type(bigquery_val = {
      "field": "start_tstamp",
      "data_type": "timestamp"
    }, databricks_val='start_tstamp_date'),
    cluster_by=fueled_web.web_cluster_by_fields_users(),
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt')),
    fueled_optimize=true
  )
}}


select distinct
  {{ dbt.concat(["u.domain_userid", "'-'", "s.user_ipaddress"]) }} as user_primary_key,
  u.*
  {% if target.type in ['databricks', 'spark'] -%}
  , DATE(start_tstamp) as start_tstamp_date
  {%- endif %}

from {{ ref('fueled_web_users_this_run') }} u -- join sessions_this_run to sessions_conversion_this_run to produce complete sessions table
left join {{ ref('fueled_web_sessions')}} s on u.domain_userid = s.domain_userid
where {{ fueled_utils.is_run_with_new_events('fueled_web') }} --returns false if run doesn't contain new events.

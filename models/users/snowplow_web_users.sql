{{
  config(
    materialized='incremental',
    unique_key='domain_userid',
    upsert_date_key='start_tstamp',
    disable_upsert_lookback=true,
    sort='start_tstamp',
    dist='domain_userid',
    partition_by = fueled_utils.get_value_by_target_type(bigquery_val={
      "field": "start_tstamp",
      "data_type": "timestamp"
    }, databricks_val='start_tstamp_date'),
    cluster_by=fueled_web.web_cluster_by_fields_users(),
    tags=["derived"],
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt')),
    tblproperties={
      'delta.autoOptimize.optimizeWrite' : 'true',
      'delta.autoOptimize.autoCompact' : 'true'
    },
    fueled_optimize = true
  )
}}

select *
  {% if target.type in ['databricks', 'spark'] -%}
  , DATE(start_tstamp) as start_tstamp_date
  {%- endif %}
from {{ ref('fueled_web_users_this_run') }}
where {{ fueled_utils.is_run_with_new_events('fueled_web') }} --returns false if run doesn't contain new events.

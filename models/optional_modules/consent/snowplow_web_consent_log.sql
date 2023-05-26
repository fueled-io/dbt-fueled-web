{{
  config(
    materialized= 'incremental',
    unique_key='event_id',
    upsert_date_key='derived_tstamp',
    sort='derived_tstamp',
    dist='event_id',
    tags=["derived"],
    partition_by = fueled_utils.get_value_by_target_type(bigquery_val = {
      "field": "derived_tstamp",
      "data_type": "timestamp"
    }, databricks_val = 'derived_tstamp_date'),
    cluster_by=fueled_web.web_cluster_by_fields_consent(),
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt')),
    tblproperties={
      'delta.autoOptimize.optimizeWrite' : 'true',
      'delta.autoOptimize.autoCompact' : 'true'
    },
    fueled_optimize= true
  )
}}

select
  *
  {% if target.type in ['databricks', 'spark'] -%}
  , DATE(derived_tstamp) as derived_tstamp_date
  {%- endif %}

from {{ ref('fueled_web_consent_events_this_run') }}

where {{ fueled_utils.is_run_with_new_events('fueled_web') }} --returns false if run doesn't contain new events.

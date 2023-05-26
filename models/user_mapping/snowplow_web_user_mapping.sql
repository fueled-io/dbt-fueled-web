{{
  config(
    materialized='incremental',
    unique_key='domain_userid',
    sort='end_tstamp',
    dist='domain_userid',
    partition_by = fueled_utils.get_value_by_target_type(bigquery_val={
      "field": "end_tstamp",
      "data_type": "timestamp"
    }),
    tags=["derived"],
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt'))
  )
}}


select distinct
  domain_userid,
  last_value(user_id) over(
    partition by domain_userid
    order by collector_tstamp
    rows between unbounded preceding and unbounded following
  ) as user_id,
  max(collector_tstamp) over (partition by domain_userid) as end_tstamp

from {{ ref('fueled_web_base_events_this_run') }}

where {{ fueled_utils.is_run_with_new_events('fueled_web') }} --returns false if run doesn't contain new events.
and user_id is not null
and domain_userid is not null

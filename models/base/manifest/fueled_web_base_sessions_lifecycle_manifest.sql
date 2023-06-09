{{
  config(
    materialized='incremental',
    unique_key='session_id',
    upsert_date_key='start_tstamp',
    sort='start_tstamp',
    dist='session_id',
    partition_by = fueled_utils.get_value_by_target_type(bigquery_val={
      "field": "start_tstamp",
      "data_type": "timestamp"
    }, databricks_val='start_tstamp_date'),
    cluster_by=fueled_web.web_cluster_by_fields_sessions_lifecycle(),
    full_refresh=fueled_web.allow_refresh(),
    tags=["manifest"],
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt')),
    tblproperties={
      'delta.autoOptimize.optimizeWrite' : 'true',
      'delta.autoOptimize.autoCompact' : 'true'
    },
    fueled_optimize = true
  )
}}

-- Known edge cases:
-- 1: Rare case with multiple domain_userid per session.

{% set lower_limit, upper_limit, _ = fueled_utils.return_base_new_event_limits(ref('fueled_web_base_new_event_limits')) %}
{% set session_lookback_limit = fueled_utils.get_session_lookback_limit(lower_limit) %}
{% set is_run_with_new_events = fueled_utils.is_run_with_new_events('fueled_web') %}

with new_events_session_ids as (
  select
    e.context_anonymous_id as session_id,
    max(e.user_id) as domain_userid, -- Edge case 1: Arbitary selection to avoid window function like first_value.
    min(e.original_timestamp) as start_tstamp,
    max(e.original_timestamp) as end_tstamp

  from {{ var('fueled__events') }} e

  where
    e.context_anonymous_id is not null
    and not exists (select 1 from {{ ref('fueled_web_base_quarantined_sessions') }} as a where a.session_id = e.context_anonymous_id) -- don't continue processing v.long sessions
    and e.original_timestamp <= {{ fueled_utils.timestamp_add('day', var("fueled__days_late_allowed", 3), 'original_timestamp') }} -- don't process data that's too late
    and e.original_timestamp >= {{ lower_limit }}
    and e.original_timestamp <= {{ upper_limit }}
    and {{ fueled_utils.app_id_filter(var("fueled__app_id",[])) }}
    and {{ is_run_with_new_events }} --don't reprocess sessions that have already been processed.
    {% if var('fueled__derived_tstamp_partitioned', true) and target.type == 'bigquery' | as_bool() %} -- BQ only
      and e.derived_tstamp >= {{ lower_limit }}
      and e.derived_tstamp <= {{ upper_limit }}
    {% endif %}

  group by 1
  )

{% if is_incremental() %}

, previous_sessions as (
  select *

  from {{ this }}

  where start_tstamp >= {{ session_lookback_limit }}
  and {{ is_run_with_new_events }} --don't reprocess sessions that have already been processed.
)

, session_lifecycle as (
  select
    ns.session_id,
    coalesce(self.domain_userid, ns.domain_userid) as domain_userid, -- Edge case 1: Take previous value to keep domain_userid consistent. Not deterministic but performant
    least(ns.start_tstamp, coalesce(self.start_tstamp, ns.start_tstamp)) as start_tstamp,
    greatest(ns.end_tstamp, coalesce(self.end_tstamp, ns.end_tstamp)) as end_tstamp -- BQ 1 NULL will return null hence coalesce

  from new_events_session_ids ns
  left join previous_sessions as self
    on ns.session_id = self.session_id

  where
    self.session_id is null -- process all new sessions
    or self.end_tstamp < {{ fueled_utils.timestamp_add('day', var("fueled__max_session_days", 3), 'self.start_tstamp') }} --stop updating sessions exceeding 3 days
  )

{% else %}

, session_lifecycle as (

  select * from new_events_session_ids

)

{% endif %}

select
  sl.session_id,
  sl.domain_userid,
  sl.start_tstamp,
  least({{ fueled_utils.timestamp_add('day', var("fueled__max_session_days", 3), 'sl.start_tstamp') }}, sl.end_tstamp) as end_tstamp -- limit session length to max_session_days
  {% if target.type in ['databricks', 'spark'] -%}
  , DATE(start_tstamp) as start_tstamp_date
  {%- endif %}

from session_lifecycle sl

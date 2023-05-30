{{
  config(
    tags=["this_run"]
  )
}}

{%- set lower_limit, upper_limit = fueled_utils.return_limits_from_model(ref('fueled_web_base_sessions_this_run'),
                                                                          'start_tstamp',
                                                                          'end_tstamp') %}

-- without downstream joins, it's safe to dedupe by picking the first event_id found.
select
  array_agg(e order by e.collector_tstamp limit 1)[offset(0)].*

from (

  select
    a.contexts_com_fueledanalytics_fueled_web_page_1_0_0[safe_offset(0)].id as page_view_id,
    b.domain_userid, -- take domain_userid from manifest. This ensures only 1 domain_userid per session.
    a.* except(contexts_com_fueledanalytics_fueled_web_page_1_0_0, domain_userid)

  from {{ var('fueled__events') }} as a
  inner join {{ ref('fueled_web_base_sessions_this_run') }} as b
  on a.domain_sessionid = b.session_id

  where a.collector_tstamp <= {{ fueled_utils.timestamp_add('day', var("fueled__max_session_days", 3), 'b.start_tstamp') }}
  and a.dvce_sent_tstamp <= {{ fueled_utils.timestamp_add('day', var("fueled__days_late_allowed", 3), 'a.dvce_created_tstamp') }}
  and a.collector_tstamp >= {{ lower_limit }}
  and a.collector_tstamp <= {{ upper_limit }}
  {% if var('fueled__derived_tstamp_partitioned', true) and target.type == 'bigquery' | as_bool() %}
    and a.derived_tstamp >= {{ fueled_utils.timestamp_add('hour', -1, lower_limit) }}
    and a.derived_tstamp <= {{ upper_limit }}
  {% endif %}
  and {{ fueled_utils.app_id_filter(var("fueled__app_id",[])) }}

) e
group by e.event_id
{{
  config(
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt'))
  )
}}

select
  ev.page_view_id,
  {% if var('fueled__limit_page_views_to_session', true) %}
  ev.domain_sessionid,
  {% endif %}
  max(ev.collector_tstamp) as end_tstamp,

  -- aggregate pings:
    -- divides epoch tstamps by fueled__heartbeat to get distinct intervals
    -- floor rounds to nearest integer - duplicates all evaluate to the same number
    -- count(distinct) counts duplicates only once
    -- adding fueled__min_visit_length accounts for the page view event itself.

  {{ var("fueled__heartbeat", 10) }} * (count(distinct(floor({{ fueled_utils.to_unixtstamp('ev.dvce_created_tstamp') }}/{{ var("fueled__heartbeat", 10) }}))) - 1) + {{ var("fueled__min_visit_length", 5) }} as engaged_time_in_s

from {{ ref('fueled_web_base_events_this_run') }} as ev

where ev.event_name = 'page_ping'
and ev.page_view_id is not null

group by 1 {% if var('fueled__limit_page_views_to_session', true) %}, 2 {% endif %}

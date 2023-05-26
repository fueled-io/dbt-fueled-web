
select
  min(collector_tstamp) as lower_limit,
  max(collector_tstamp) as upper_limit

from {{ ref('fueled_web_base_events_this_run') }}

where page_view_id is not null

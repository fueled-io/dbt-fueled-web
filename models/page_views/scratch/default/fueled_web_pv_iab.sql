{{
  config(
    enabled=(var('fueled__enable_iab', false) and target.type in ['redshift', 'postgres'] | as_bool())
  )
}}

with base as (
  select
    pv.page_view_id,

    iab.category,
    iab.primary_impact,
    iab.reason,
    iab.spider_or_robot,
    row_number() over (partition by pv.page_view_id order by pv.collector_tstamp) as dedupe_index

  from {{ var('fueled__iab_context') }} iab

  inner join {{ ref('fueled_web_page_view_events') }} pv
  on iab.root_id = pv.event_id
  and iab.root_tstamp = pv.collector_tstamp

  where iab.root_tstamp >= (select lower_limit from {{ ref('fueled_web_pv_limits') }})
    and iab.root_tstamp <= (select upper_limit from {{ ref('fueled_web_pv_limits') }})

)

select *

from base

where dedupe_index = 1

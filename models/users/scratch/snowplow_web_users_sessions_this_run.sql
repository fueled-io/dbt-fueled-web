{{
  config(
    tags=["this_run"],
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt'))
  )
}}

with user_ids_this_run as (
  select
      distinct domain_userid

  from {{ ref('fueled_web_base_sessions_this_run') }}
  where domain_userid is not null
)

select
  a.*,
  min(a.start_tstamp) over(partition by a.domain_userid) as user_start_tstamp,
  max(a.end_tstamp) over(partition by a.domain_userid) as user_end_tstamp

from {{ var('fueled__sessions_table') }} a
inner join user_ids_this_run b
on a.domain_userid = b.domain_userid

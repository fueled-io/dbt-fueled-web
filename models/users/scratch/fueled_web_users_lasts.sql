{{
  config(
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt'))
  )
}}


select
  a.domain_userid,
  a.last_page_title,

  a.last_page_url,

  a.last_page_urlscheme,
  a.last_page_urlhost,
  a.last_page_urlpath,
  a.last_page_urlquery,
  a.last_page_urlfragment

from {{ ref('fueled_web_users_sessions_this_run') }} a

inner join {{ ref('fueled_web_users_aggs') }} b
on a.domain_sessionid = b.last_domain_sessionid

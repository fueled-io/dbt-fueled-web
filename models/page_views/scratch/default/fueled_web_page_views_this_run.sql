{{
  config(
    tags=["this_run"]
  )
}}


select
  ev.page_view_id,
  ev.event_id,

  ev.app_id,

  -- user fields
  ev.user_id,
  ev.domain_userid,
  ev.network_userid,

  -- session fields
  ev.domain_sessionid,
  /*
  ev.domain_sessionidx,
  */

  ev.page_view_in_session_index,
  max(ev.page_view_in_session_index) over (partition by ev.domain_sessionid) as page_views_in_session,

  -- timestamp fields
  ev.dvce_created_tstamp,
  ev.collector_tstamp,
  ev.derived_tstamp,
  ev.start_tstamp,
  coalesce(t.end_tstamp, ev.derived_tstamp) as end_tstamp, -- only page views with pings will have a row in table t
  {{ fueled_utils.current_timestamp_in_utc() }} as model_tstamp,

  coalesce(t.engaged_time_in_s, 0) as engaged_time_in_s, -- where there are no pings, engaged time is 0.
  {{ datediff('ev.derived_tstamp', 'coalesce(t.end_tstamp, ev.derived_tstamp)', 'second') }} as absolute_time_in_s,

  /*  
  sd.hmax as horizontal_pixels_scrolled,
  sd.vmax as vertical_pixels_scrolled,

  sd.relative_hmax as horizontal_percentage_scrolled,
  sd.relative_vmax as vertical_percentage_scrolled,
  */

  ev.doc_width,
  ev.doc_height,

  ev.page_title,
  ev.page_url,
  /*
  ev.page_urlscheme,
  ev.page_urlhost,
  ev.page_urlpath,
  ev.page_urlquery,
  ev.page_urlfragment,

  ev.mkt_medium,
  ev.mkt_source,
  ev.mkt_term,
  ev.mkt_content,
  ev.mkt_campaign,
  ev.mkt_clickid,
  ev.mkt_network,
  */

  ev.page_referrer,
  /*
  ev.refr_urlscheme,
  ev.refr_urlhost,
  ev.refr_urlpath,
  ev.refr_urlquery,
  ev.refr_urlfragment,
  ev.refr_medium,
  ev.refr_source,
  ev.refr_term,

  ev.geo_country,
  ev.geo_region,
  ev.geo_region_name,
  ev.geo_city,
  ev.geo_zipcode,
  ev.geo_latitude,
  ev.geo_longitude,
  ev.geo_timezone,
  */

  ev.user_ipaddress,

  /*
  ev.useragent,

  ev.br_lang,
  ev.br_viewwidth,
  ev.br_viewheight,
  ev.br_colordepth,
  ev.br_renderengine,

  ev.os_timezone,
  */

  -- optional fields, only populated if enabled.

  -- iab enrichment fields: set iab variable to true to enable
  {{fueled_web.get_iab_context_fields('iab')}},

  -- ua parser enrichment fields
  {{fueled_web.get_ua_context_fields('ua')}},

  -- yauaa enrichment fields
  {{fueled_web.get_yauaa_context_fields('ya')}}

from {{ ref('fueled_web_page_view_events') }} ev

left join {{ ref('fueled_web_pv_engaged_time') }} t
on ev.page_view_id = t.page_view_id {% if var('fueled__limit_page_views_to_session', true) %} and ev.domain_sessionid = t.domain_sessionid {% endif %}

{% if var('fueled__enable_iab', false) -%}

  left join {{ ref('fueled_web_pv_iab') }} iab
  on ev.page_view_id = iab.page_view_id

{% endif -%}

{% if var('fueled__enable_ua', false) -%}

  left join {{ ref('fueled_web_pv_ua_parser') }} ua
  on ev.page_view_id = ua.page_view_id

{% endif -%}

{% if var('fueled__enable_yauaa', false) -%}

  left join {{ ref('fueled_web_pv_yauaa') }} ya
  on ev.page_view_id = ya.page_view_id

{%- endif -%}

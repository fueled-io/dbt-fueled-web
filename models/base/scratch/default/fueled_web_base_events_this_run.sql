{{
  config(
    sort='collector_tstamp',
    dist='event_id',
    tags=["this_run"]
  )
}}

{%- set lower_limit, upper_limit = fueled_utils.return_limits_from_model(ref('fueled_web_base_sessions_this_run'),
                                                                          'start_tstamp',
                                                                          'end_tstamp') %}

/* Dedupe logic: Per dupe event_id keep earliest row ordered by collector_tstamp.
   If multiple earliest rows, take arbitrary one using row_number(). */

with events_this_run AS (
  select
    a.app_id,
    a.platform,
    a.etl_tstamp,
    a.collector_tstamp,
    a.dvce_created_tstamp,
    a.event,
    a.event_id,
    a.txn_id,
    a.name_tracker,
    a.v_tracker,
    a.v_collector,
    a.v_etl,
    a.user_id,
    a.user_ipaddress,
    a.user_fingerprint,
    b.domain_userid, -- take domain_userid from manifest. This ensures only 1 domain_userid per session.
    a.domain_sessionidx,
    a.network_userid,
    a.geo_country,
    a.geo_region,
    a.geo_city,
    a.geo_zipcode,
    a.geo_latitude,
    a.geo_longitude,
    a.geo_region_name,
    a.ip_isp,
    a.ip_organization,
    a.ip_domain,
    a.ip_netspeed,
    a.page_url,
    a.page_title,
    a.page_referrer,
    a.page_urlscheme,
    a.page_urlhost,
    a.page_urlport,
    a.page_urlpath,
    a.page_urlquery,
    a.page_urlfragment,
    a.refr_urlscheme,
    a.refr_urlhost,
    a.refr_urlport,
    a.refr_urlpath,
    a.refr_urlquery,
    a.refr_urlfragment,
    a.refr_medium,
    a.refr_source,
    a.refr_term,
    a.mkt_medium,
    a.mkt_source,
    a.mkt_term,
    a.mkt_content,
    a.mkt_campaign,
    a.se_category,
    a.se_action,
    a.se_label,
    a.se_property,
    a.se_value,
    a.tr_orderid,
    a.tr_affiliation,
    a.tr_total,
    a.tr_tax,
    a.tr_shipping,
    a.tr_city,
    a.tr_state,
    a.tr_country,
    a.ti_orderid,
    a.ti_sku,
    a.ti_name,
    a.ti_category,
    a.ti_price,
    a.ti_quantity,
    a.pp_xoffset_min,
    a.pp_xoffset_max,
    a.pp_yoffset_min,
    a.pp_yoffset_max,
    a.useragent,
    a.br_name,
    a.br_family,
    a.br_version,
    a.br_type,
    a.br_renderengine,
    a.br_lang,
    a.br_features_pdf,
    a.br_features_flash,
    a.br_features_java,
    a.br_features_director,
    a.br_features_quicktime,
    a.br_features_realplayer,
    a.br_features_windowsmedia,
    a.br_features_gears,
    a.br_features_silverlight,
    a.br_cookies,
    a.br_colordepth,
    a.br_viewwidth,
    a.br_viewheight,
    a.os_name,
    a.os_family,
    a.os_manufacturer,
    a.os_timezone,
    a.dvce_type,
    a.dvce_ismobile,
    a.dvce_screenwidth,
    a.dvce_screenheight,
    a.doc_charset,
    a.doc_width,
    a.doc_height,
    a.tr_currency,
    a.tr_total_base,
    a.tr_tax_base,
    a.tr_shipping_base,
    a.ti_currency,
    a.ti_price_base,
    a.base_currency,
    a.geo_timezone,
    a.mkt_clickid,
    a.mkt_network,
    a.etl_tags,
    a.dvce_sent_tstamp,
    a.refr_domain_userid,
    a.refr_dvce_tstamp,
    a.domain_sessionid,
    a.derived_tstamp,
    a.event_vendor,
    a.event_name,
    a.event_format,
    a.event_version,
    a.event_fingerprint,
    a.true_tstamp,
    {% if var('fueled__enable_load_tstamp', true) %}
      a.load_tstamp,
    {% endif %}
    row_number() over (partition by a.event_id order by a.collector_tstamp) as event_id_dedupe_index

  from {{ var('fueled__events') }} as a
  inner join {{ ref('fueled_web_base_sessions_this_run') }} as b
  on a.domain_sessionid = b.session_id

  where a.collector_tstamp <= {{ fueled_utils.timestamp_add('day', var("fueled__max_session_days", 3), 'b.start_tstamp') }}
  and a.dvce_sent_tstamp <= {{ fueled_utils.timestamp_add('day', var("fueled__days_late_allowed", 3), 'a.dvce_created_tstamp') }}
  and a.collector_tstamp >= {{ lower_limit }}
  and a.collector_tstamp <= {{ upper_limit }}
  and {{ fueled_utils.app_id_filter(var("fueled__app_id",[])) }}
)

, page_context as (
  select
    root_id,
    root_tstamp,
    id as page_view_id,
    row_number() over (partition by root_id order by root_tstamp) as page_context_dedupe_index

  from {{ var('fueled__page_view_context') }}
  where
    root_tstamp >= {{ lower_limit }}
    and root_tstamp <= {{ upper_limit }}
)

, page_context_dedupe as (
  select
   *

  from page_context
  where page_context_dedupe_index = 1
)

select
  e.*,
  pc.page_view_id

from events_this_run as e
left join page_context_dedupe as pc
on e.event_id = pc.root_id
and e.collector_tstamp = pc.root_tstamp

where e.event_id_dedupe_index = 1

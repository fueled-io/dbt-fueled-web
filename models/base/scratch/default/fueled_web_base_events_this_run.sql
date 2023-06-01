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
    'fueled-analytics-client' as app_id,
    'web' as platform,
    a.sent_at as etl_tstamp,
    a.original_timestamp as collector_tstamp,
    a.original_timestamp as dvce_created_tstamp,
    'page_view' as event,
    a.id as event_id,
    a.id as page_view_id,
    a.context_source_id as name_tracker,
    a.context_library_version as v_tracker,
    a.context_destination_id as v_collector,
    a.context_destination_type as v_etl,
    a.user_id as user_id,
    a.context_ip as user_ipaddress,
    b.domain_userid, -- take domain_userid from manifest. This ensures only 1 domain_userid per session.
    a.context_anonymous_id as network_userid,
    a.url as page_url,
    a.title as page_title,
    a.context_source_type as page_urlscheme,
    {{ dbt_utils.get_url_host(field='a.url') }} as page_urlhost,
    a.path as page_urlpath,
    a.search as page_urlquery,
    a.referrer as page_referrer,
    {{ dbt_utils.get_url_host(field='a.referrer') }} as refr_urlhost, 
    {{ dbt_utils.get_url_path(field='a.referrer') }} as refr_path,
    /*
    a.useragent,
    a.refr_medium,
    a.refr_source,
    a.refr_term,
    a.mkt_medium,
    a.mkt_source,
    a.mkt_term,
    a.mkt_content,
    a.mkt_campaign,
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
    */
    a.width as doc_width,
    a.height as doc_height,
    a.original_timestamp as dvce_sent_tstamp,
    a.context_anonymous_id as domain_sessionid,
    a.original_timestamp as derived_tstamp,
    'fueled' as event_vendor,
    'page_view' as event_name,
    'jsonschema' as event_format,
    a.context_library_version as event_version,
    {% if var('fueled__enable_load_tstamp', false) %}
      a.load_tstamp,
    {% endif %}
    row_number() over (partition by a.id order by a.original_timestamp) as event_id_dedupe_index

  from {{ var('fueled__events') }} as a
  inner join {{ ref('fueled_web_base_sessions_this_run') }} as b
  on a.context_anonymous_id = b.session_id

  where a.original_timestamp <= {{ fueled_utils.timestamp_add('day', var("fueled__max_session_days", 3), 'b.start_tstamp') }}
  and a.original_timestamp <= {{ fueled_utils.timestamp_add('day', var("fueled__days_late_allowed", 3), 'a.original_timestamp') }}
  and a.original_timestamp >= {{ lower_limit }}
  and a.original_timestamp <= {{ upper_limit }}
  and {{ fueled_utils.app_id_filter(var("fueled__app_id",[])) }}
)

select * from events_this_run
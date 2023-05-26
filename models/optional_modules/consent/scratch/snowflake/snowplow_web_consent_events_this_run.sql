{{
  config(
    tags=["this_run"],
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt'))
  )
}}

with prep as (

  select
    e.event_id,
    e.domain_userid,
    e.user_id,
    e.geo_country,
    e.page_view_id,
    e.domain_sessionid,
    e.derived_tstamp,
    e.load_tstamp,
    e.event_name,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:eventType::varchar as event_type,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:basisForProcessing::varchar as basis_for_processing,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:consentUrl::varchar as consent_url,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:consentVersion::varchar as consent_version,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:consentScopes::array as consent_scopes,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:domainsApplied::array as domains_applied,
    e.unstruct_event_com_fueledanalytics_fueled_consent_preferences_1:gdprApplies::boolean as gdpr_applies,
    e.unstruct_event_com_fueledanalytics_fueled_cmp_visible_1:elapsedTime::float as cmp_load_time

  from {{ ref("fueled_web_base_events_this_run") }} as e

  where event_name in ('cmp_visible', 'consent_preferences')

  and {{ fueled_utils.is_run_with_new_events('fueled_web') }} --returns false if run doesn't contain new events.

)

select
  p.event_id,
  p.domain_userid,
  p.user_id,
  p.geo_country,
  p.page_view_id,
  p.domain_sessionid,
  p.derived_tstamp,
  p.load_tstamp,
  p.event_name,
  p.event_type,
  p.basis_for_processing,
  p.consent_url,
  p.consent_version,
  {{ fueled_utils.get_array_to_string('consent_scopes', 'p', ', ') }} as consent_scopes,
  {{ fueled_utils.get_array_to_string('domains_applied', 'p', ', ') }} as domains_applied,
  coalesce(p.gdpr_applies, false) as gdpr_applies,
  p.cmp_load_time

from prep p

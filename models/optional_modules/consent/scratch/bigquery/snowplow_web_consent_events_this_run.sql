{{
  config(
    tags=["this_run"]
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
    {{ fueled_utils.get_optional_fields(
        enabled= true,
        fields=consent_fields(),
        col_prefix='unstruct_event_com_fueledanalytics_fueled_consent_preferences_1',
        relation=ref('fueled_web_base_events_this_run'),
        relation_alias='e') }},
    {{ fueled_utils.get_optional_fields(
        enabled= true,
        fields=[{'field': 'elapsed_time', 'dtype': 'string'}],
        col_prefix='unstruct_event_com_fueledanalytics_fueled_cmp_visible_1',
        relation=ref('fueled_web_base_events_this_run'),
        relation_alias='e') }}

    from {{ ref("fueled_web_base_events_this_run") }} as e

    where e.event_name in ('cmp_visible', 'consent_preferences')

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
  coalesce(safe_cast(p.gdpr_applies as boolean), false) gdpr_applies,
  cast(p.elapsed_time as {{ dbt.type_float() }}) as cmp_load_time

  from prep p


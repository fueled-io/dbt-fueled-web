{{
  config(
    materialized='table',
  )
}}

with arrays as (

  select
    u.domain_userid,
    {{ fueled_utils.get_split_to_array('last_consent_scopes', 'u', ', ') }} as scope_array

  from {{ ref('fueled_web_consent_users') }} u

  where is_latest_version

  )

  , unnesting as (

    {{ fueled_utils.unnest('domain_userid', 'scope_array', 'consent_scope', 'arrays') }}

  )

select
  replace(replace(replace(cast(consent_scope as {{ fueled_utils.type_max_string() }}), '"', ''), '[', ''), ']', '') as scope,
  count(*) as total_consent

from unnesting

group by 1

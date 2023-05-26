
select
  root_id,
  root_tstamp::timestamp,
  elapsed_time

from {{ ref('fueled_web_consent_cmp_visible') }}

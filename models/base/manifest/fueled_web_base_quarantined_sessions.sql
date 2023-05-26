{{
  config(
    materialized='incremental',
    full_refresh=fueled_web.allow_refresh(),
    sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt')),
    tblproperties={
      'delta.autoOptimize.optimizeWrite' : 'true',
      'delta.autoOptimize.autoCompact' : 'true'
    }
  )
}}

/*
Boilerplate to generate table.
Table updated as part of post-hook on sessions_this_run
Any sessions exceeding max_session_days are quarantined
Once quarantined, any subsequent events from the session will not be processed.
This significantly reduces table scans
*/

with prep as (
  select
    cast(null as {{ fueled_utils.type_max_string() }}) session_id
)

select *

from prep
where false

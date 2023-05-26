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

-- Boilerplate to generate table.
-- Table updated as part of end-run hook

with prep as (
  select
    cast(null as {{ fueled_utils.type_max_string() }}) model,
    cast('1970-01-01' as {{ type_timestamp() }}) as last_success
)

select *

from prep
where false

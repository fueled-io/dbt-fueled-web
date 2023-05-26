{% macro get_iab_context_fields(table_prefix = none) %}
    {{ return(adapter.dispatch('get_iab_context_fields', 'fueled_web')(table_prefix)) }}
{%- endmacro -%}

{% macro get_ua_context_fields(table_prefix = none) %}
    {{ return(adapter.dispatch('get_ua_context_fields', 'fueled_web')(table_prefix)) }}
{%- endmacro -%}

{% macro get_yauaa_context_fields(table_prefix = none) %}
    {{ return(adapter.dispatch('get_yauaa_context_fields', 'fueled_web')(table_prefix)) }}
{%- endmacro -%}

{# iab fields #}
{% macro postgres__get_iab_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_iab', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}category,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}primary_impact,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}reason,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}spider_or_robot
    {%- else -%}
        cast(null as {{ fueled_utils.type_max_string() }}) as category,
        cast(null as {{ fueled_utils.type_max_string() }}) as primary_impact,
        cast(null as {{ fueled_utils.type_max_string() }}) as reason,
        cast(null as boolean) as spider_or_robot
    {%- endif -%}
{% endmacro %}

{% macro bigquery__get_iab_context_fields(table_prefix = none) %}
    {% if execute %}
        {% do exceptions.raise_compiler_error('get_iab_context_fields is not defined for bigquery, please use fueled_utils.get_optional_fields instead') %}
    {% endif %}
{% endmacro %}

{% macro spark__get_iab_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_iab', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0].category::STRING as category,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0].primary_impact::STRING as primary_impact,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0].reason::STRING as reason,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0].spider_or_robot::BOOLEAN as spider_or_robot
    {%- else -%}
        cast(null as {{ type_string() }}) as category,
        cast(null as {{ type_string() }}) as primary_impact,
        cast(null as {{ type_string() }}) as reason,
        cast(null as boolean) as spider_or_robot
    {%- endif -%}
{% endmacro %}

{% macro snowflake__get_iab_context_fields(table_prefix = none) %}

    {%- if var('fueled__enable_iab', false) %}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0]:category::VARCHAR as category,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0]:primaryImpact::VARCHAR as primary_impact,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0]:reason::VARCHAR as reason,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_iab_fueled_spiders_and_robots_1[0]:spiderOrRobot::BOOLEAN as spider_or_robot
    {%- else -%}
        cast(null as {{ type_string() }}) as category,
        cast(null as {{ type_string() }}) as primary_impact,
        cast(null as {{ type_string() }}) as reason,
        cast(null as boolean) as spider_or_robot
    {%- endif -%}
{% endmacro %}

{# ua fields #}
{% macro postgres__get_ua_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_ua', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}useragent_family,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}useragent_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}useragent_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}useragent_patch,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}useragent_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}os_family,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}os_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}os_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}os_patch,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}os_patch_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}os_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}device_family
    {%- else -%}
        cast(null as {{ fueled_utils.type_max_string() }}) as useragent_family,
        cast(null as {{ fueled_utils.type_max_string() }}) as useragent_major,
        cast(null as {{ fueled_utils.type_max_string() }}) as useragent_minor,
        cast(null as {{ fueled_utils.type_max_string() }}) as useragent_patch,
        cast(null as {{ fueled_utils.type_max_string() }}) as useragent_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as os_family,
        cast(null as {{ fueled_utils.type_max_string() }}) as os_major,
        cast(null as {{ fueled_utils.type_max_string() }}) as os_minor,
        cast(null as {{ fueled_utils.type_max_string() }}) as os_patch,
        cast(null as {{ fueled_utils.type_max_string() }}) as os_patch_minor,
        cast(null as {{ fueled_utils.type_max_string() }}) as os_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as device_family
    {%- endif -%}
{% endmacro %}

{% macro bigquery__get_ua_context_fields(table_prefix = none) %}
    {% if execute %}
        {% do exceptions.raise_compiler_error('get_ua_context_fields is not defined for bigquery, please use fueled_utils.get_optional_fields instead') %}
    {% endif %}
{% endmacro %}

{% macro spark__get_ua_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_ua', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].useragent_family::STRING as useragent_family,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].useragent_major::STRING as useragent_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].useragent_minor::STRING as useragent_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].useragent_patch::STRING as useragent_patch,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].useragent_version::STRING as useragent_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].os_family::STRING as os_family,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].os_major::STRING as os_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].os_minor::STRING as os_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].os_patch::STRING as os_patch,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].os_patch_minor::STRING as os_patch_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].os_version::STRING as os_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0].device_family::STRING as device_family
    {%- else -%}
        cast(null as {{ type_string() }}) as useragent_family,
        cast(null as {{ type_string() }}) as useragent_major,
        cast(null as {{ type_string() }}) as useragent_minor,
        cast(null as {{ type_string() }}) as useragent_patch,
        cast(null as {{ type_string() }}) as useragent_version,
        cast(null as {{ type_string() }}) as os_family,
        cast(null as {{ type_string() }}) as os_major,
        cast(null as {{ type_string() }}) as os_minor,
        cast(null as {{ type_string() }}) as os_patch,
        cast(null as {{ type_string() }}) as os_patch_minor,
        cast(null as {{ type_string() }}) as os_version,
        cast(null as {{ type_string() }}) as device_family
    {%- endif -%}
{% endmacro %}

{% macro snowflake__get_ua_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_ua', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:useragentFamily::VARCHAR as useragent_family,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:useragentMajor::VARCHAR as useragent_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:useragentMinor::VARCHAR as useragent_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:useragentPatch::VARCHAR as useragent_patch,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:useragentVersion::VARCHAR as useragent_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:osFamily::VARCHAR as os_family,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:osMajor::VARCHAR as os_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:osMinor::VARCHAR as os_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:osPatch::VARCHAR as os_patch,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:osPatchMinor::VARCHAR as os_patch_minor,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:osVersion::VARCHAR as os_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_com_fueledanalytics_fueled_ua_parser_context_1[0]:deviceFamily::VARCHAR as device_family
    {%- else -%}
        cast(null as {{ type_string() }}) as useragent_family,
        cast(null as {{ type_string() }}) as useragent_major,
        cast(null as {{ type_string() }}) as useragent_minor,
        cast(null as {{ type_string() }}) as useragent_patch,
        cast(null as {{ type_string() }}) as useragent_version,
        cast(null as {{ type_string() }}) as os_family,
        cast(null as {{ type_string() }}) as os_major,
        cast(null as {{ type_string() }}) as os_minor,
        cast(null as {{ type_string() }}) as os_patch,
        cast(null as {{ type_string() }}) as os_patch_minor,
        cast(null as {{ type_string() }}) as os_version,
        cast(null as {{ type_string() }}) as device_family
    {% endif %}

{% endmacro %}

{# yauaa fields #}
{% macro postgres__get_yauaa_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_yauaa', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}device_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}agent_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}agent_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}agent_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}agent_name_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}agent_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}agent_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}device_brand,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}device_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}device_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}layout_engine_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}layout_engine_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}layout_engine_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}layout_engine_name_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}layout_engine_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}layout_engine_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}operating_system_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}operating_system_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}operating_system_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}operating_system_version
    {%- else -%}
        cast(null as {{ fueled_utils.type_max_string() }}) as device_class,
        cast(null as {{ fueled_utils.type_max_string() }}) as agent_class,
        cast(null as {{ fueled_utils.type_max_string() }}) as agent_name,
        cast(null as {{ fueled_utils.type_max_string() }}) as agent_name_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as agent_name_version_major,
        cast(null as {{ fueled_utils.type_max_string() }}) as agent_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as agent_version_major,
        cast(null as {{ fueled_utils.type_max_string() }}) as device_brand,
        cast(null as {{ fueled_utils.type_max_string() }}) as device_name,
        cast(null as {{ fueled_utils.type_max_string() }}) as device_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as layout_engine_class,
        cast(null as {{ fueled_utils.type_max_string() }}) as layout_engine_name,
        cast(null as {{ fueled_utils.type_max_string() }}) as layout_engine_name_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as layout_engine_name_version_major,
        cast(null as {{ fueled_utils.type_max_string() }}) as layout_engine_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as layout_engine_version_major,
        cast(null as {{ fueled_utils.type_max_string() }}) as operating_system_class,
        cast(null as {{ fueled_utils.type_max_string() }}) as operating_system_name,
        cast(null as {{ fueled_utils.type_max_string() }}) as operating_system_name_version,
        cast(null as {{ fueled_utils.type_max_string() }}) as operating_system_version
    {%- endif -%}
{% endmacro %}

{% macro bigquery__get_yauaa_context_fields(table_prefix = none) %}
    {% if execute %}
        {% do exceptions.raise_compiler_error('get_yauaa_context_fields is not defined for bigquery, please use fueled_utils.get_optional_fields instead') %}
    {% endif %}
{% endmacro %}

{% macro spark__get_yauaa_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_yauaa', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].device_class::STRING as device_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].agent_class::STRING as agent_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].agent_name::STRING as agent_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].agent_name_version::STRING as agent_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].agent_name_version_major::STRING as agent_name_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].agent_version::STRING as agent_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].agent_version_major::STRING as agent_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].device_brand::STRING as device_brand,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].device_name::STRING as device_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].device_version::STRING as device_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].layout_engine_class::STRING as layout_engine_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].layout_engine_name::STRING as layout_engine_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].layout_engine_name_version::STRING as layout_engine_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].layout_engine_name_version_major::STRING as layout_engine_name_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].layout_engine_version::STRING as layout_engine_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].layout_engine_version_major::STRING as layout_engine_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].operating_system_class::STRING as operating_system_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].operating_system_name::STRING as operating_system_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].operating_system_name_version::STRING as operating_system_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0].operating_system_version::STRING as operating_system_version
    {%- else -%}
        cast(null as {{ type_string() }}) as device_class,
        cast(null as {{ type_string() }}) as agent_class,
        cast(null as {{ type_string() }}) as agent_name,
        cast(null as {{ type_string() }}) as agent_name_version,
        cast(null as {{ type_string() }}) as agent_name_version_major,
        cast(null as {{ type_string() }}) as agent_version,
        cast(null as {{ type_string() }}) as agent_version_major,
        cast(null as {{ type_string() }}) as device_brand,
        cast(null as {{ type_string() }}) as device_name,
        cast(null as {{ type_string() }}) as device_version,
        cast(null as {{ type_string() }}) as layout_engine_class,
        cast(null as {{ type_string() }}) as layout_engine_name,
        cast(null as {{ type_string() }}) as layout_engine_name_version,
        cast(null as {{ type_string() }}) as layout_engine_name_version_major,
        cast(null as {{ type_string() }}) as layout_engine_version,
        cast(null as {{ type_string() }}) as layout_engine_version_major,
        cast(null as {{ type_string() }}) as operating_system_class,
        cast(null as {{ type_string() }}) as operating_system_name,
        cast(null as {{ type_string() }}) as operating_system_name_version,
        cast(null as {{ type_string() }}) as operating_system_version
    {%- endif -%}
{% endmacro %}

{% macro snowflake__get_yauaa_context_fields(table_prefix = none) %}
    {%- if var('fueled__enable_yauaa', false) -%}
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:deviceClass::VARCHAR as device_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:agentClass::VARCHAR as agent_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:agentName::VARCHAR as agent_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:agentNameVersion::VARCHAR as agent_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:agentNameVersionMajor::VARCHAR as agent_name_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:agentVersion::VARCHAR as agent_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:agentVersionMajor::VARCHAR as agent_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:deviceBrand::VARCHAR as device_brand,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:deviceName::VARCHAR as device_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:deviceVersion::VARCHAR as device_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:layoutEngineClass::VARCHAR as layout_engine_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:layoutEngineName::VARCHAR as layout_engine_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:layoutEngineNameVersion::VARCHAR as layout_engine_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:layoutEngineNameVersionMajor::VARCHAR as layout_engine_name_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:layoutEngineVersion::VARCHAR as layout_engine_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:layoutEngineVersionMajor::VARCHAR as layout_engine_version_major,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:operatingSystemClass::VARCHAR as operating_system_class,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:operatingSystemName::VARCHAR as operating_system_name,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:operatingSystemNameVersion::VARCHAR as operating_system_name_version,
        {% if table_prefix %}{{ table_prefix~"." }}{% endif %}contexts_nl_basjes_yauaa_context_1[0]:operatingSystemVersion::VARCHAR as operating_system_version
    {%- else -%}
        cast(null as {{ type_string() }}) as device_class,
        cast(null as {{ type_string() }}) as agent_class,
        cast(null as {{ type_string() }}) as agent_name,
        cast(null as {{ type_string() }}) as agent_name_version,
        cast(null as {{ type_string() }}) as agent_name_version_major,
        cast(null as {{ type_string() }}) as agent_version,
        cast(null as {{ type_string() }}) as agent_version_major,
        cast(null as {{ type_string() }}) as device_brand,
        cast(null as {{ type_string() }}) as device_name,
        cast(null as {{ type_string() }}) as device_version,
        cast(null as {{ type_string() }}) as layout_engine_class,
        cast(null as {{ type_string() }}) as layout_engine_name,
        cast(null as {{ type_string() }}) as layout_engine_name_version,
        cast(null as {{ type_string() }}) as layout_engine_name_version_major,
        cast(null as {{ type_string() }}) as layout_engine_version,
        cast(null as {{ type_string() }}) as layout_engine_version_major,
        cast(null as {{ type_string() }}) as operating_system_class,
        cast(null as {{ type_string() }}) as operating_system_name,
        cast(null as {{ type_string() }}) as operating_system_name_version,
        cast(null as {{ type_string() }}) as operating_system_version
    {%- endif -%}
{% endmacro %}

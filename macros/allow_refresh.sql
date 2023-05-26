{# Default: Allow refresh in dev, block refresh otherwise. dev defined by fueled__dev_target_name #}

{% macro allow_refresh() %}
  {{ return(adapter.dispatch('allow_refresh', 'fueled_web')()) }}
{% endmacro %}

{% macro default__allow_refresh() %}
  
  {% set allow_refresh = fueled_utils.get_value_by_target(
                                    dev_value=none,
                                    default_value=var('fueled__allow_refresh'),
                                    dev_target_name=var('fueled__dev_target_name')
                                    ) %}

  {{ return(allow_refresh) }}

{% endmacro %}

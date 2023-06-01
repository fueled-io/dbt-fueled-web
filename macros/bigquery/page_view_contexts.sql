{% macro iab_fields() %}
  
  {% set iab_fields = [
      {'field':'category', 'dtype':'string'},
      {'field':'primary_impact', 'dtype':'string'},
      {'field':'reason', 'dtype':'string'},
      {'field':'spider_or_robot', 'dtype':'boolean'}
    ] %}

  {{ return(iab_fields) }}

{% endmacro %}

{% macro ua_fields() %}
  
  {% set ua_fields = [
      {'field': 'useragent_family', 'dtype': 'string'},
      {'field': 'useragent_major', 'dtype': 'string'},
      {'field': 'useragent_minor', 'dtype': 'string'},
      {'field': 'useragent_patch', 'dtype': 'string'},
      {'field': 'useragent_version', 'dtype': 'string'},
      {'field': 'os_family', 'dtype': 'string'},
      {'field': 'os_major', 'dtype': 'string'},
      {'field': 'os_minor', 'dtype': 'string'},
      {'field': 'os_patch', 'dtype': 'string'},
      {'field': 'os_patch_minor', 'dtype': 'string'},
      {'field': 'os_version', 'dtype': 'string'},
      {'field': 'device_family', 'dtype': 'string'}
    ] %}

  {{ return(ua_fields) }}

{% endmacro %}
{% macro web_cluster_by_fields_sessions_lifecycle() %}

  {{ return(adapter.dispatch('web_cluster_by_fields_sessions_lifecycle', 'fueled_web')()) }}

{% endmacro %}

{% macro default__web_cluster_by_fields_sessions_lifecycle() %}

  {{ return(fueled_utils.get_value_by_target_type(bigquery_val=["session_id"], snowflake_val=["to_date(start_tstamp)"])) }}

{% endmacro %}


{% macro web_cluster_by_fields_page_views() %}

  {{ return(adapter.dispatch('web_cluster_by_fields_page_views', 'fueled_web')()) }}

{% endmacro %}

{% macro default__web_cluster_by_fields_page_views() %}

  {{ return(fueled_utils.get_value_by_target_type(bigquery_val=["domain_userid","domain_sessionid"], snowflake_val=["to_date(start_tstamp)"])) }}

{% endmacro %}


{% macro web_cluster_by_fields_sessions() %}

  {{ return(adapter.dispatch('web_cluster_by_fields_sessions', 'fueled_web')()) }}

{% endmacro %}

{% macro default__web_cluster_by_fields_sessions() %}

  {{ return(fueled_utils.get_value_by_target_type(bigquery_val=["domain_userid"], snowflake_val=["to_date(start_tstamp)"])) }}

{% endmacro %}


{% macro web_cluster_by_fields_users() %}

  {{ return(adapter.dispatch('web_cluster_by_fields_users', 'fueled_web')()) }}

{% endmacro %}

{% macro default__web_cluster_by_fields_users() %}

  {{ return(fueled_utils.get_value_by_target_type(bigquery_val=["user_id","domain_userid"], snowflake_val=["to_date(start_tstamp)"])) }}

{% endmacro %}

{% macro web_cluster_by_fields_consent() %}

  {{ return(adapter.dispatch('web_cluster_by_fields_consent', 'fueled_web')()) }}

{% endmacro %}

{% macro default__web_cluster_by_fields_consent() %}

  {{ return(fueled_utils.get_value_by_target_type(bigquery_val=["event_id","domain_userid"], snowflake_val=["to_date(load_tstamp)"])) }}

{% endmacro %}

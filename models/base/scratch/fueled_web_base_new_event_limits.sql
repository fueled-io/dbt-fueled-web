{{ config(
   post_hook=["{{fueled_utils.print_run_limits(this)}}"],
   sql_header=fueled_utils.set_query_tag(var('fueled__query_tag', 'fueled_dbt'))
   )
}}


{%- set models_in_run = fueled_utils.get_enabled_fueled_models('fueled_web') -%}

{% set min_last_success,
         max_last_success,
         models_matched_from_manifest,
         has_matched_all_models = fueled_utils.get_incremental_manifest_status(ref('fueled_web_incremental_manifest'),
                                                                                 models_in_run) -%}


{% set run_limits_query = fueled_utils.get_run_limits(min_last_success,
                                                          max_last_success,
                                                          models_matched_from_manifest,
                                                          has_matched_all_models,
                                                          var("fueled__start_date","2020-01-01")) -%}


{{ run_limits_query }}

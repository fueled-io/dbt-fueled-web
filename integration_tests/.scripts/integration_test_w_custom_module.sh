#!/bin/bash

# Expected input:
# -d (database) target database for dbt

while getopts 'd:' opt
do
  case $opt in
    d) DATABASE=$OPTARG
  esac
done

declare -a SUPPORTED_DATABASES=("bigquery" "databricks" "postgres" "redshift" "snowflake")

# set to lower case
DATABASE="$(echo $DATABASE | tr '[:upper:]' '[:lower:]')"

if [[ $DATABASE == "all" ]]; then
  DATABASES=( "${SUPPORTED_DATABASES[@]}" )
else
  DATABASES=$DATABASE
fi

for db in ${DATABASES[@]}; do

  echo "Fueled web integration tests: Seeding data"

  eval "dbt seed --target $db --full-refresh" || exit 1;

  echo "Fueled web integration tests: Run 1: standard modules"

  eval "dbt run --target $db --full-refresh --vars '{fueled__allow_refresh: true, fueled__backfill_limit_days: 243}'" || exit 1;

  echo "Fueled web integration tests: Run 2: standard modules"

  eval "dbt run --target $db" || exit 1;

  echo "Fueled web integration tests: Run 3: Partial backfill of custom module + standard modules"
  # This tests the functionality of the fueled_utils.is_run_with_new_events() macro
  # Could be a scenario when a new custom module is added where:
  # - the main scheduled fueled job runs i.e. all modules + custom backfill
  # - then the user manually runs a job in dbt cloud to just backfill new custom module.
  # This results in the derived tables being partially backfilled

  eval "dbt run --target $db --vars '{fueled__enable_custom_example: true, fueled__backfill_limit_days: 243}'" || exit 1;

  echo "Fueled web integration tests: Run 4: Partial backfill of custom module only"

  eval "dbt run --models +fueled_web_pv_channels --target $db --vars 'fueled__enable_custom_example: true'" || exit 1;

  for i in {5..6}
  do
    echo "Fueled web integration tests: Run $i/6: Standard increment - all modules"

    eval "dbt run --target $db --vars 'fueled__enable_custom_example: true'" || exit 1;
  done

  echo "Fueled web integration tests: Test models"

  eval "dbt test --target $db --store-failures" || exit 1;

  echo "Fueled web integration tests: All tests passed"

done

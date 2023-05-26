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

  echo "Fueled web integration tests: Execute models - run 1/4 (no contexts)"

  eval "dbt run --target $db --full-refresh --vars '{fueled__allow_refresh: true, fueled__backfill_limit_days: 243, fueled__enable_iab: false, fueled__enable_ua: false, fueled__enable_yauaa: false }'" || exit 1;

  echo "Fueled web integration tests: Execute models - run 1/4"

  eval "dbt run --target $db --full-refresh --vars '{fueled__allow_refresh: true, fueled__backfill_limit_days: 243}'" || exit 1;

  for i in {2..4}
  do
    echo "Fueled web integration tests: Execute models - run $i/4"

    eval "dbt run --target $db" || exit 1;
  done

  echo "Fueled web integration tests: Test models"

  eval "dbt test --target $db --store-failures" || exit 1;

  echo "Fueled web integration tests: All tests passed"

done

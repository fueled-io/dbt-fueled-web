
# fueled-web

This dbt package:

- Transforms and aggregates raw web event data collected from the [Snowplow JavaScript tracker][tracker-docs] into a set of derived tables: page views, sessions and users, plus an optional set of consent tables.
- Derives a mapping between user identifiers, allowing for 'session stitching' and the development of a single customer view.
- Processes **all web events incrementally**. It is not just constrained to page view events - any custom events you are tracking will also be incrementally processed.
- Is designed in a modular manner, allowing you to easily integrate your own custom dbt models into the incremental framework provided by the package.

### Credits

This project started off as a mirror of Snowplow Analytics' [dbt-snowplow-web](https://github.com/snowplow/dbt-snowplow-web)

### Adapter Support

The latest version of the fueled-web package supports BigQuery, Databricks, Redshift, Snowflake & Postgres. For previous versions see our [package docs](https://docs.snowplow.io/docs/modeling-your-data/modeling-your-data-with-dbt/).

### Requirements

- A dataset of web events from Fueled's javascript client for Shopify or BigCommerce must be available in the database.
- dbt-core version 1.4.0 or greater

### Models

The package contains multiple staging models however the output models are as follows:

| Model                             | Description                                                                                                  |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| snowplow_web_page_views           | A table of page views, including engagement metrics such as scroll depth and engaged time.                   |
| snowplow_web_sessions             | An aggregated table of page views, grouped on `domain_sessionid`.                                            |
| snowplow_web_users                | An aggregated table of sessions to a user level, grouped on `domain_userid`.                                 |
| snowplow_web_user_mapping         | Provides a mapping between user identifiers, `domain_userid` and `user_id`.                                  |

# Copyright and license

The fueled-web package is based upon Snowplow Analytic's original Copyright 2021-2022.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[license]: http://www.apache.org/licenses/LICENSE-2.0

# Significant Changes

Snowplow's dbt-snowplow-web package has been mirrored by Fueled to work with Fueled's base event structures.
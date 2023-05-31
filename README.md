
# fueled-web

This dbt package:

- Transforms and aggregates raw web event data collected from the Fueled's Shopify and BigCommerce javascript event tracker into a set of derived tables: page views, sessions and users.
- Derives a mapping between user identifiers, allowing for 'session stitching' and the development of a single customer view.
- Processes **all web events incrementally**. It is not just constrained to page view events - any custom events you are tracking will also be incrementally processed.
- Is designed in a modular manner, allowing you to easily integrate your own custom dbt models into the incremental framework provided by the package.

### Credits

This project started off as a mirror of Snowplow Analytics' [dbt-snowplow-web](https://github.com/snowplow/dbt-snowplow-web)

### Data Warehouse Support

The latest version of the fueled-web package supports BigQuery, Databricks, Redshift, Snowflake & Postgres.
Note: Our team primarily leverages RedShift, BigQuery, and Snowflake. Support is limited for Databricks at this time.

### Requirements

- A dataset of web events from Fueled's javascript client for Shopify or BigCommerce must be available in the database.
- dbt-core version 1.5.0 or greater

### Models

The package contains multiple staging models however the output models are as follows:

| Model                             | Description                                                                                                  |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| fueled_web_page_views           | A table of page views, including engagement metrics.                   |
| fueled_web_sessions             | An aggregated table of page views, grouped on `domain_sessionid`.                                            |
| fueled_web_users                | An aggregated table of sessions to a user level, grouped on `domain_userid`.                                 |
| fueled_web_user_mapping         | Provides a mapping between user identifiers, `domain_userid` and `user_id`.                                  |

### To Dos

- Add UA Parser to get abstract browser, device, and OS metrics from userAgent.
- Add Referrer Parser to get Source, Medium, and Search Term metrics from referring URLs.
- Add Campaign Parser to get Source, Medium, Search, and Marketing Click metrics from page URLs.

### Copyright and license

The fueled-web package is based upon Snowplow Analytic's original Copyright 2021-2022.

DBT-Fueled-Web is copyrighted 2023.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[license]: http://www.apache.org/licenses/LICENSE-2.0

### Significant Changes

Snowplow's dbt-snowplow-web package has been mirrored by Fueled to work with Fueled's base event structures.
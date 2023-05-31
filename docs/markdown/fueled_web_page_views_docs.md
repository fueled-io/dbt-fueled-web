{% docs table_page_views_this_run %}

This staging table contains all the page views for the given run of the Web model. It possess all the same columns as `fueled_web_page_views`. If building a custom module that requires page view events, this is the table you should reference.

{% enddocs %}


{% docs table_page_views %}

This derived incremental table contains all historic page views and should be the end point for any analysis or BI tools.

{% enddocs %}


{% docs table_page_view_events %}

This is a staging table containing all the page view events for a given run of the Web model. It is the first step in the page views module and therefore does not contain metrics such as engaged time and scroll depth which are calculated in subsequent models. It is also where the de-duping of `page_view_id`'s occurs

{% enddocs %}


{% docs table_pv_engaged_time %}

This model calculates the time a visitor spent engaged on a given page view. This is calculated using the number of page ping events received for that page view.

{% enddocs %}


{% docs table_pv_limits %}

This model calculates the lower and upper limit for the page views events in the given run. This is based taking the min and max `collector_tstamp` across all page views. It is used to improve performance when selected rows from the various context tables such as the UA parser table. 

{% enddocs %}

{% docs col_channel %}
`server`, `web`, etc. - The channel through which the Fueled event hits our data warehouse adaptor.
{% enddocs %}

{% docs col_app_id %}
Application ID e.g. ‘angry-birds’ is used to distinguish different applications that are being tracked by the same Fueled stack, e.g. production versus dev.
{% enddocs %}

{% docs col_platform %}
Platform e.g. ‘web’
{% enddocs %}

{% docs col_hash %}
TODO - Document me...
{% enddocs %}

{% docs col_sent %}
Timestamp event began ETL e.g. ‘2017-01-26 00:01:25.292’. Translated into `elt_tstamp`.
{% enddocs %}

{% docs col_etl_tstamp %}
Timestamp event began ETL e.g. ‘2017-01-26 00:01:25.292’
{% enddocs %}

{% docs col_original_timestamp %}
Time stamp for the event recorded by the collector e.g. ‘2013-11-26 00:02:05’. Translated into `collector_tstamp`.
{% enddocs %}

{% docs col_received_at %}
TODO - Document me...
{% enddocs %}

{% docs col_sent_at %}
TODO - Document me...
{% enddocs %}

{% docs col_timestamp %}
TODO - Document me...
{% enddocs %}

{% docs col_uuid_ts %}
TODO - Document me...
{% enddocs %}

{% docs col_collector_tstamp %}
Time stamp for the event recorded by the collector e.g. ‘2013-11-26 00:02:05’
{% enddocs %}

{% docs col_dvce_created_tstamp %}
Timestamp event was recorded on the client device e.g. ‘2013-11-26 00:03:57.885’
{% enddocs %}

{% docs col_event %}
The type of event recorded e.g. ‘page_view’
{% enddocs %}

{% docs col_id %}
A UUID for each event e.g. ‘c6ef3124-b53a-4b13-a233-0088f79dcbcb’. Translated into `event_id` and later transformed into `page_view_id`.
{% enddocs %}

{% docs col_event_id %}
A UUID for each event e.g. ‘c6ef3124-b53a-4b13-a233-0088f79dcbcb’
{% enddocs %}

{% docs col_context_source_id %}
Tracker namespace e.g. ‘sp1’. Translated into `name_tracker`.
{% enddocs %}

{% docs col_name_tracker %}
Tracker namespace e.g. ‘sp1’
{% enddocs %}

{% docs col_context_library_name %}
TODO - Document me...
{% enddocs %}

{% docs col_context_library_version %}
Tracker version e.g. ‘js-3.0.0’. Translated into `v_tracker`.
{% enddocs %}

{% docs col_v_tracker %}
Tracker version e.g. ‘js-3.0.0’
{% enddocs %}

{% docs col_context_destination_id %}
Collector version e.g. ‘ssc-2.1.0-kinesis’. Translated into `v_collector`.
{% enddocs %}

{% docs col_v_collector %}
Collector version e.g. ‘ssc-2.1.0-kinesis’
{% enddocs %}

{% docs col_context_destination_type %}
ETL version e.g. ‘fueled-micro-1.1.0-common-1.4.2’. Translated into `v_etl`.
{% enddocs %}

{% docs col_v_etl %}
ETL version e.g. ‘fueled-micro-1.1.0-common-1.4.2’
{% enddocs %}


{% docs col_client_id %}
The Google Analytics 4 client ID, if Fueled's GA4 integration is turned on.
{% enddocs %}


{% docs col_user_id %}
Unique ID set by business e.g. ‘jon.doe@email.com’. Generally a SHA256 hash of email address.
{% enddocs %}

{% docs col_context_session_id %}
Google Analytics 4 session ID, if available.
{% enddocs %}

{% docs col_request_ip %}
User IP address e.g. ‘92.231.54.234’. Same as `context_ip`.
{% enddocs %}

{% docs col_context_ip %}
User IP address e.g. ‘92.231.54.234’. Translated into `user_ipaddress`.
{% enddocs %}

{% docs col_user_ipaddress %}
User IP address e.g. ‘92.231.54.234’
{% enddocs %}

{% docs col_context_anonymous_id %}
User ID set by Fueled using 1st party cookie e.g. ‘ecdff4d0-9175-40ac-a8bb-325c49733607’.
_Note: Fueled sets this identifier and then it's used for `domain_userid` and `network_userid` in these models, to better align with other attribution stacks, like Snowplow._
{% enddocs %}

{% docs col_domain_userid %}
User ID set by Fueled using 1st party cookie e.g. ‘ecdff4d0-9175-40ac-a8bb-325c49733607’
{% enddocs %}

{% docs col_network_userid %}
User ID set by Fueled using 3rd party cookie e.g. ‘ecdff4d0-9175-40ac-a8bb-325c49733607’
{% enddocs %}

{% docs col_geo_country %}
ISO 3166-1 code for the country the visitor is located in e.g. ‘GB’, ‘US’
{% enddocs %}

{% docs col_geo_region %}
ISO-3166-2 code for country region the visitor is in e.g. ‘I9’, ‘TX’
{% enddocs %}

{% docs col_geo_city %}
City the visitor is in e.g. ‘New York’, ‘London’
{% enddocs %}

{% docs col_geo_zipcode %}
Postcode the visitor is in e.g. ‘94109’
{% enddocs %}

{% docs col_geo_latitude %}
Visitor location latitude e.g. 37.443604
{% enddocs %}

{% docs col_geo_longitude %}
Visitor location longitude e.g. -122.4124
{% enddocs %}

{% docs col_geo_region_name %}
Visitor region name e.g. ‘Florida’
{% enddocs %}

{% docs col_url %}
The page URL e.g. ‘http://www.example.com’. Translated into `page_url`.
{% enddocs %}

{% docs col_page_url %}
The page URL e.g. ‘http://www.example.com’
{% enddocs %}

{% docs col_name %}
Web site name e.g. ‘Fueled Docs’.
{% enddocs %}

{% docs col_title %}
Web page title e.g. ‘Fueled Docs – Understanding the structure of Fueled data’. Transformed into `page_title`.
{% enddocs %}

{% docs col_page_title %}
Web page title e.g. ‘Fueled Docs – Understanding the structure of Fueled data’
{% enddocs %}

{% docs col_referrer %}
URL of the referrer e.g. ‘http://www.referrer.com’. Transformed into `page_referrer`.
{% enddocs %}

{% docs col_page_referrer %}
URL of the referrer e.g. ‘http://www.referrer.com’
{% enddocs %}

{% docs col_context_source_type %}
Scheme aka protocol e.g. ‘https’
{% enddocs %}

{% docs col_page_urlscheme %}
Scheme aka protocol e.g. ‘https’
{% enddocs %}

{% docs col_page_urlhost %}
Host aka domain e.g. ‘www.fueled.io’
{% enddocs %}

{% docs col_path %}
Path to page e.g. ‘/product/index.html’. Translated into `page_urlpath`.
{% enddocs %}

{% docs col_page_urlpath %}
Path to page e.g. ‘/product/index.html’
{% enddocs %}

{% docs col_search %}
Querystring e.g. ‘id=GTM-DLRG’. Translated into `page_urlquery`.
{% enddocs %}

{% docs col_page_urlquery %}
Querystring e.g. ‘id=GTM-DLRG’
{% enddocs %}

{% docs col_refr_urlhost %}
Referer host e.g. ‘www.bing.com’
{% enddocs %}

{% docs col_refr_urlpath %}
Referer page path e.g. ‘/images/search’
{% enddocs %}

{% docs col_refr_urlquery %}
Referer URL querystring e.g. ‘q=psychic+oracle+cards’
{% enddocs %}

{% docs col_refr_medium %}
Type of referer e.g. ‘search’, ‘internal’
{% enddocs %}

{% docs col_refr_source %}
Name of referer if recognised e.g. ‘Bing images’
{% enddocs %}

{% docs col_refr_term %}
Keywords if source is a search engine e.g. ‘psychic oracle cards’
{% enddocs %}

{% docs col_mkt_medium %}
Type of traffic source e.g. ‘cpc’, ‘affiliate’, ‘organic’, ‘social’
{% enddocs %}

{% docs col_mkt_source %}
The company / website where the traffic came from e.g. ‘Google’, ‘Facebook’
{% enddocs %}

{% docs col_mkt_term %}
Any keywords associated with the referrer e.g. ‘new age tarot decks’
{% enddocs %}

{% docs col_mkt_content %}
The content of the ad. (Or an ID so that it can be looked up.) e.g. 13894723
{% enddocs %}

{% docs col_mkt_campaign %}
The campaign ID e.g. ‘diageo-123’
{% enddocs %}

{% docs col_useragent %}
Raw useragent
{% enddocs %}

{% docs col_br_name %}
Browser name e.g. ‘Firefox 12’
{% enddocs %}

{% docs col_br_family %}
Browser family e.g. ‘Firefox’
{% enddocs %}

{% docs col_br_version %}
Browser version e.g. ‘12.0’
{% enddocs %}

{% docs col_br_type %}
Browser type e.g. ‘Browser’
{% enddocs %}

{% docs col_br_renderengine %}
Browser rendering engine e.g. ‘GECKO’
{% enddocs %}

{% docs col_br_lang %}
Language the browser is set to e.g. ‘en-GB’
{% enddocs %}

{% docs col_br_features_pdf %}
Whether the browser recognizes PDFs e.g. True
{% enddocs %}

{% docs col_br_features_flash %}
Whether Flash is installed e.g. True
{% enddocs %}

{% docs col_br_features_java %}
Whether Java is installed e.g. True
{% enddocs %}

{% docs col_br_features_director %}
Whether Adobe Shockwave is installed e.g. True
{% enddocs %}

{% docs col_br_features_quicktime %}
Whether QuickTime is installed e.g. True
{% enddocs %}

{% docs col_br_features_realplayer %}
Whether RealPlayer is installed e.g. True
{% enddocs %}

{% docs col_br_features_windowsmedia %}
Whether mplayer2 is installed e.g. True
{% enddocs %}

{% docs col_br_features_gears %}
Whether Google Gears is installed e.g. True
{% enddocs %}

{% docs col_br_features_silverlight %}
Whether Microsoft Silverlight is installed e.g. True
{% enddocs %}

{% docs col_br_cookies %}
Whether cookies are enabled e.g. True
{% enddocs %}

{% docs col_br_colordepth %}
Bit depth of the browser color palette e.g. 24
{% enddocs %}

{% docs col_br_viewwidth %}
Viewport width e.g. 1000
{% enddocs %}

{% docs col_br_viewheight %}
Viewport height e.g. 1000
{% enddocs %}

{% docs col_os_name %}
Name of operating system e.g. ‘Android’
{% enddocs %}

{% docs col_os_family %}
Operating system family e.g. ‘Linux’
{% enddocs %}

{% docs col_os_manufacturer %}
Company responsible for OS e.g. ‘Apple’
{% enddocs %}

{% docs col_os_timezone %}
Client operating system timezone e.g. ‘Europe/London’
{% enddocs %}

{% docs col_dvce_type %}
Type of device e.g. ‘Computer’
{% enddocs %}

{% docs col_dvce_ismobile %}
Is the device mobile? e.g. True
{% enddocs %}

{% docs col_dvce_screenwidth %}
Screen width in pixels e.g. 1900
{% enddocs %}

{% docs col_dvce_screenheight %}
Screen height in pixels e.g. 1024
{% enddocs %}

{% docs col_doc_charset %}
The page’s character encoding e.g. , ‘UTF-8’
{% enddocs %}

{% docs col_width %}
The page’s width in pixels e.g. 1024. Translated to `doc_width`.
{% enddocs %}

{% docs col_doc_width %}
The page’s width in pixels e.g. 1024
{% enddocs %}

{% docs col_height %}
The page’s height in pixels e.g. 3000. Tranlated to `doc_height.
{% enddocs %}

{% docs col_doc_height %}
The page’s height in pixels e.g. 3000
{% enddocs %}

{% docs col_geo_timezone %}
Visitor timezone name e.g. ‘Europe/London’
{% enddocs %}

{% docs col_mkt_clickid %}
The click ID e.g. ‘ac3d8e459’
{% enddocs %}

{% docs col_mkt_network %}
The ad network to which the click ID belongs e.g. ‘DoubleClick’
{% enddocs %}

{% docs col_etl_tags %}
JSON of tags for this ETL run e.g. “[‘prod’]”
{% enddocs %}

{% docs col_dvce_sent_tstamp %}
When the event was sent by the client device e.g. ‘2013-11-26 00:03:58.032’
{% enddocs %}

{% docs col_refr_domain_userid %}
The Fueled domain_userid of the referring website e.g. ‘bc2e92ec6c204a14’
{% enddocs %}

{% docs col_refr_dvce_tstamp %}
The time of attaching the domain_userid to the inbound link e.g. ‘2013-11-26 00:02:05’
{% enddocs %}

{% docs col_domain_sessionid %}
A visit / session UUID e.g. ‘c6ef3124-b53a-4b13-a233-0088f79dcbcb’
{% enddocs %}

{% docs col_derived_tstamp %}
Timestamp making allowance for innaccurate device clock e.g. ‘2013-11-26 00:02:04’
{% enddocs %}

{% docs col_event_vendor %}
Who defined the event e.g. ‘com.acme’
{% enddocs %}

{% docs col_event_name %}
Event name e.g. ‘link_click’
{% enddocs %}

{% docs col_event_format %}
Format for event e.g. ‘jsonschema’
{% enddocs %}

{% docs col_event_version %}
Version of event schema e.g. ‘1-0-2’
{% enddocs %}

{% docs col_page_view_id %}
A UUID for each page view e.g. ‘c6ef3124-b53a-4b13-a233-0088f79dcbcb’
{% enddocs %}

{% docs col_category %}
Category based on activity if the IP/UA is a spider or robot, BROWSER otherwise
{% enddocs %}

{% docs col_primary_impact %}
Whether the spider or robot would affect page impression measurement, ad impression measurement, both or none
{% enddocs %}

{% docs col_reason %}
Type of failed check if the IP/UA is a spider or robot, PASSED_ALL otherwise
{% enddocs %}

{% docs col_spider_or_robot %}
True if the IP address or user agent checked against the list is a spider or robot, false otherwise
{% enddocs %}

{% docs col_device_family %}
Device type
{% enddocs %}

<!-- Breaking naming convention to avoid clash with same col name from atomic.events -->

{% docs col_ua_os_family %}
Operation system name
{% enddocs %}

{% docs col_useragent_family %}
Useragent family (browser) name
{% enddocs %}

{% docs col_os_major %}
Operation system major version
{% enddocs %}

{% docs col_os_minor %}
Operation system minor version
{% enddocs %}

{% docs col_os_patch %}
Operation system patch version
{% enddocs %}

{% docs col_os_patch_minor %}
Operation system patch minor version
{% enddocs %}

{% docs col_os_version %}
Operation system full version
{% enddocs %}

{% docs col_useragent_major %}
Useragent major version
{% enddocs %}

{% docs col_useragent_minor %}
Useragent minor version
{% enddocs %}

{% docs col_useragent_patch %}
Useragent patch version
{% enddocs %}

{% docs col_useragent_version %}
Full version of the useragent
{% enddocs %}

{% docs col_device_class %}
Class of device e.g. phone
{% enddocs %}

{% docs col_agent_class %}
Class of agent e.g. browser
{% enddocs %}

{% docs col_agent_name %}
Name of agent e.g. Chrome
{% enddocs %}

{% docs col_agent_name_version %}
Name and version of agent e.g. Chrome 53.0.2785.124
{% enddocs %}

{% docs col_agent_name_version_major %}
Name and major version of agent e.g. Chrome 53
{% enddocs %}

{% docs col_agent_version %}
Version of agent e.g. 53.0.2785.124
{% enddocs %}

{% docs col_agent_version_major %}
Major version of agent e.g. 53
{% enddocs %}

{% docs col_device_brand %}
Brand of device e.g. Google
{% enddocs %}

{% docs col_device_name %}
Name of device e.g. Google Nexus 6
{% enddocs %}

{% docs col_device_version %}
Version of device e.g. 6.0
{% enddocs %}

{% docs col_layout_engine_class %}
Class of layout engine e.g. Browser
{% enddocs %}

{% docs col_layout_engine_name %}
Name of layout engine e.g. Blink
{% enddocs %}

{% docs col_layout_engine_name_version %}
Name and version of layout engine e.g. Blink 53.0
{% enddocs %}

{% docs col_layout_engine_name_version_major %}
Name and major version of layout engine e.g. Blink 53
{% enddocs %}

{% docs col_layout_engine_version %}
Version of layout engine e.g. 53.0
{% enddocs %}

{% docs col_layout_engine_version_major %}
Major version of layout engine e.g. 53
{% enddocs %}

{% docs col_operating_system_class %}
Class of the OS e.g. Mobile
{% enddocs %}

{% docs col_operating_system_name %}
Name of the OS e.g. Android
{% enddocs %}

{% docs col_operating_system_name_version %}
Name and version of the OS e.g. Android 7.0
{% enddocs %}

{% docs col_operating_system_version %}
Version of the OS e.g. 7.0
{% enddocs %}

{% docs col_model_tstamp %}
The current timestamp when the model processed this row.
{% enddocs %}

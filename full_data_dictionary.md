### AB_MEMBER

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| MEMBER_ID | User ID | 18b7762e933fe1f59c8ec1a49e23b9ff | nan |
| TEST_ID | Test Number | 20 | nan |
| GROUP_NAME | Test Group Name (represented as a letter) | C | "@" = control group. Mosr times "A" is commonly test group and other letters are control groups. |
| _FIVETRAN_DELETED | Is Deleted? | False | Filters should alwayse include "_FIVETRAN_DELETED = FALSE" |
| _FIVETRAN_SYNCED | Date | 2023-11-28 06:40:17.163000000 +00:00 | Needs to be converted into Datetime/Date format ("_FIVETRAN_SYNCED::datetime") |
| JOIN_DATE | Join Test Datetime | 2023-11-28 03:50:30 | The date a user joined the test |

---

### AB_PROPERTY

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | User ID | 56 | nan |
| TEST_ID | Test Number | 10 | nan |
| GROUP_NAME | Test Group Name (represented as a letter) | B | nan |
| PROPERTY | empty column | nan | nan |
| TYPE | empty column | nan | nan |
| VALUE | empty column | nan | nan |
| _FIVETRAN_DELETED | Is Deleted? | True | Filters should alwayse include "_FIVETRAN_DELETED = FALSE" |
| _FIVETRAN_SYNCED | Date | 2021-10-14 08:47:51.396000000 +00:00 | Needs to be converted into Datetime/Date format ("_FIVETRAN_SYNCED::datetime") |
| PROPERTIES_CHANGED_DATE | Date the property changed | nan | The date a certain test started a new property (control into test, for example) |
| PROPERTIES | New property | {
  "show_skip_onboarding_button": true
} | New property for the group listed |

---

### APPSFLYER

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| METADATA$FILENAME | File name containing metadata | EV2SNBASMGG0K.2023-11-03-00.c6047b5d.gz | nan |
| LOAD_TS | Timestamp of data load | 2023-11-05 06:21:31.662000 | nan |
| CF_DATE | Date of a certain event | 2023-11-03 00:00:00 | nan |
| CF_TIME | Time of a certain event | 00:49:07 | nan |
| PARAMS | JSON-formatted parameters | {
  "advertising_id": "d3cd52f1-0ca5-488c-85ab-7af988744f30",
  "af_ad": "uac_half&half_stripes_beach_1200x1500.jpg_105",
  "af_ad_id": "23861457577890710",
  "af_adset": "AAA_Android_T2_Pur-Manual-Creatives_04.10.23",
  "af_adset_id": "23861457577800710",
  "af_attribution_lookback": "7d",
  "af_c_id": "23861457577810710",
  "af_channel": "Facebook",
  "api_version": "2.0",
  "app_id": "com.gurushots.app",
  "app_name": "GuruShots - Photography",
  "app_version": "5.28.2",
  "appsflyer_id": "1698811503838-647100570385722663",
  "attributed_touch_time": "2023-11-01 03:48:33.000",
  "attributed_touch_time_selected_timezone": "2023-11-01 03:48:33.000+0000",
  "attributed_touch_type": "click",
  "bundle_id": "com.gurushots.app",
  "campaign": "AAA_Android_T2_Pur-Manual-Creatives_04.10.23",
  "campaign_type": "ua",
  "carrier": "Lebara",
  "city": "Eppelborn",
  "conversion_type": "install",
  "country_code": "DE",
  "customer_user_id": "d44e3d47a241def9881d074abaa31acb",
  "device_category": "phone",
  "device_download_time": "2023-11-01 04:04:37.000",
  "device_download_time_selected_timezone": "2023-11-01 04:04:37.000+0000",
  "device_model": "xiaomi::Redmi Note 8T",
  "dma": "276003",
  "event_name": "app_start",
  "event_revenue_currency": "USD",
  "event_source": "SDK",
  "event_time": "2023-11-03 00:49:04.897",
  "event_time_selected_timezone": "2023-11-03 00:49:04.897+0000",
  "event_value": "{}",
  "install_time": "2023-11-01 04:05:07.925",
  "install_time_selected_timezone": "2023-11-01 04:05:07.925+0000",
  "ip": "95.91.223.153",
  "is_primary_attribution": "true",
  "is_retargeting": "false",
  "language": "Deutsch",
  "match_type": "gp_referrer",
  "media_source": "Facebook Ads",
  "network_account_id": "1121135764590774",
  "operator": "Lebara",
  "os_version": "11",
  "platform": "android",
  "postal_code": "66571",
  "region": "EU",
  "sdk_version": "v6.12.2",
  "selected_currency": "USD",
  "selected_timezone": "UTC",
  "state": "SL",
  "user_agent": "Dalvik/2.1.0 (Linux; U; Android 11; Redmi Note 8T Build/RKQ1.201004.002)",
  "wifi": "true"
} | Consider parsing for specific parameter retrieval. Important value = 'appsflyer_id" is the install indication |
| APP_ID | Application ID | com.gurushots.app | nan |
| APP_NAME | Name of the application | GuruShots - Photography | nan |
| APP_VERSION | Version of the application | 5.28.2 | nan |
| APPSFLYER_DEVICE_ID | Unique identifier for the device in AppsFlyer | nan | nan |
| ATTRIBUTION_TYPE | Type of attribution (e.g., click) | nan | nan |
| BUNDLE_ID | Bundle identifier for the application | com.gurushots.app | nan |
| DOWNLOAD_TIME | Time of app download | nan | nan |
| DOWNLOAD_TIME_SELECTED_TIMEZONE | Time of app download in selected timezone | nan | nan |
| EVENT_TIME | Time of a specific event | 2023-11-03 00:49:04.897000 | nan |
| EVENT_TIME_SELECTED_TIMEZONE | Event time in selected timezone | 2023-11-03 00:49:04.897000 | nan |
| EVENT_TYPE | Type of event (e.g., in-app-event) | in-app-event | nan |
| INSTALL_TIME | Time of app installation | 2023-11-01 04:05:07.925000 | nan |
| INSTALL_TIME_SELECTED_TIMEZONE | Installation time in selected timezone | 2023-11-01 04:05:07.925000 | nan |
| IP | IP address of the device | 95.91.223.153 | nan |
| IS_RETARGETING | Indicates whether it's a retargeting event | False | nan |
| LANGUAGE | Language setting of the device | Deutsch | nan |
| MEDIA_SOURCE | Source of media (e.g., Facebook Ads) | Facebook Ads | nan |
| OS_VERSION | Operating system version | 11 | nan |
| PLATFORM | Device platform (e.g., android) | android | nan |
| SDK_VERSION | Software development kit version | v6.12.2 | nan |
| SELECTED_CURRENCY | Currency selected for the event | USD | nan |
| WIFI | Indicates whether Wi-Fi is used | True | nan |
| CITY | City where the event occurred | Eppelborn | nan |
| COUNTRY_CODE | Country code of the device | DE | nan |
| EVENT_NAME | Name of the event | app_start | nan |
| CURRENCY | Currency used in the event | nan | nan |
| EVENT_VALUE | Additional event-related data | {} | nan |
| CUSTOMER_USER_ID | Unique identifier for the customer/user | d44e3d47a241def9881d074abaa31acb | nan |
| DEVICE_TYPE | Type of device (e.g., phone) | nan | nan |
| IDFV | Identifier for vendor (iOS) | nan | nan |
| IDFA | Identifier for advertisers (iOS) | nan | nan |
| ATTRIBUTED_TOUCH_TIME | Time of the touch event leading to attribution | 2023-11-01 03:48:33 | nan |
| ATTRIBUTED_TOUCH_TYPE | Type of touch event leading to attribution | click | nan |
| CLICK_TIME | Time of the click event | nan | nan |
| CLICK_TIME_SELECTED_TIMEZONE | Click time in selected timezone | nan | nan |
| AF_CHANNEL | Advertising channel | Facebook | nan |
| FB_ADGROUP_ID | Facebook Ad Group ID | nan | nan |
| FB_ADGROUP_NAME | Facebook Ad Group name | nan | nan |
| FB_ADSET_ID | Facebook Ad Set ID | nan | nan |
| FB_ADSET_NAME | Facebook Ad Set name | nan | nan |
| FB_CAMPAIGN_ID | Facebook Campaign ID | nan | nan |
| FB_CAMPAIGN_NAME | Facebook Campaign name | nan | nan |
| CAMPAIGN | Campaign name | AAA_Android_T2_Pur-Manual-Creatives_04.10.23 | nan |
| DEVICE_BRAND | Brand of the device | nan | nan |
| DEVICE_MODEL | Model of the device | xiaomi::Redmi Note 8T | nan |
| ADVERTISING_ID | Advertising ID of the device | d3cd52f1-0ca5-488c-85ab-7af988744f30 | nan |
| CARRIER | Carrier information | Lebara | nan |
| OPERATOR | Mobile operator information | Lebara | nan |
| CLICK_URL | URL clicked in the event | nan | nan |
| RE_TARGETING_CONVERSION_TYPE | Conversion type for retargeting events | nan | nan |
| HTTP_REFERRER | HTTP referrer information | nan | nan |
| AF_C_ID | AppsFlyer Campaign ID | 23861457577810710 | nan |
| AF_AD_TYPE | AppsFlyer Ad type | nan | nan |
| AF_SITEID | AppsFlyer Site ID | nan | nan |
| AF_ADSET | AppsFlyer Ad Set name | AAA_Android_T2_Pur-Manual-Creatives_04.10.23 | nan |
| AF_ADSET_ID | AppsFlyer Ad Set ID | 23861457577800710 | nan |
| AF_AD | AppsFlyer Ad name | uac_half&half_stripes_beach_1200x1500.jpg_105 | nan |
| AF_AD_ID | AppsFlyer Ad ID | 23861457577890710 | nan |
| AF_KEYWORDS | Keywords associated with the AppsFlyer Ad | nan | nan |
| REVENUE_IN_SELECTED_CURRENCY | Revenue generated in the selected currency | nan | nan |
| AGENCY | Agency information | nan | nan |
| ANDROID_ID | Android ID of the device | nan | nan |
| ERROR | Error information | nan | nan |
| IMEI | International Mobile Equipment Identity | nan | nan |
| AF_COST_CURRENCY | Currency for AppsFlyer cost information | nan | nan |
| AF_COST_MODEL | Model for AppsFlyer cost information | nan | nan |
| AF_COST_VALUE | Value for AppsFlyer cost information | nan | nan |

---

### SERVER EVENTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| _FILE | Name or identifier of the log file | 1678871427.426.json |  |
| _LINE | Line number in the log file | 0 |  |
| _MODIFIED | Date and time when the log entry was last modified | 2023-03-15 09:10:28.000000000 +00:00 |  |
| DATA | JSON-formatted log data containing contextual information | {
  "log_context": {
    "name": "received-view"
  },
  "log_data": {
    "recipient": {
      "battleId": 1003746,
      "imageId": "169ea3b86ae740c1812d7cd5cf764c19",
      "isBot": 1,
      "memberId": "4e69429a6ee5e72c6eeff75ba1b9852d",
      "themeId": 35,
      "themeType": "AI"
    },
    "viewer": {
      "battleId": 0,
      "imageId": "0",
      "memberId": "0",
      "themeId": 0
    }
  },
  "log_environment": "prod",
  "log_service": "gsms-battles-voting",
  "log_time": 1678871427426
} |  |
| _FIVETRAN_SYNCED | Date and time when the log entry was synced by Fivetran | 2023-03-15 09:40:00.830000000 +00:00 |  |
| _DATA | Additional or raw data associated with the log entry | nan |  |

---

### CLIENT EVENTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| MEMBER_ID | Unique identifier for a member | d3b16ec54f1d917cbcb46b7a2d41a908 | nan |
| CLIENT_IP | IP address of the client | 46.251.52.137 | nan |
| DEVICE_ID | Unique identifier for the device | 17f71728104360-064f3bdf72e15c-67247b22-20b980-17f71728105d3e | nan |
| SERVER_TIME | Server timestamp of the event | 2022-03-10 01:35:44.294000 | nan |
| PLATFORM | Platform type (e.g., web) | web | nan |
| CLIENT_TIME | Client timestamp of the event | 2022-03-10 01:35:40 | nan |
| EVENT | Type of event | web_client_events | nan |
| UTM | UTM parameters | {
  "campaign": null,
  "fbclid": null,
  "medium": null,
  "source": null,
  "url": null
} | nan |
| UI | User interface-related information | {
  "menu_selection": null,
  "onboarding_stage": null,
  "order_type": null,
  "tooltip_status": null,
  "tooltip_type": null,
  "tutorial_version": null,
  "ui_action": "click",
  "ui_category": null,
  "ui_name": null,
  "ui_type": null,
  "viewed_member_id": null
} | nan |
| RV | Revenue-related information | {
  "ad_info": null,
  "ad_unit_id": null,
  "collected_coins": null,
  "rv_status": null
} | nan |
| CHALLENGE | Challenge-related information | {
  "challenge_id": null,
  "challenge_tag": null,
  "vote_count": null
} | nan |
| RESOURCES | Resource-related information | {
  "fills_amount": null,
  "number_of_challenges_to_fill": null,
  "resource_balance": null
} | nan |
| PURCHASES | Purchase-related information | {
  "amount_collected": null,
  "current_balance": null,
  "fail_type": null,
  "offer_amount": null,
  "origin": null,
  "package_id": null,
  "package_type": null,
  "position": null,
  "price": null
} | nan |
| BATTLES | Battle-related information | {
  "batteries_available": null,
  "battle_id": null,
  "battle_joins": null,
  "cost_amount": null,
  "cost_type": null,
  "current_exposure_bonus": null,
  "current_gallery_id": null,
  "current_rank": null,
  "current_votes": null,
  "error_in_voting_session": null,
  "exposure_meter_status": null,
  "fail_in_voting_session": null,
  "free_ticket_amount": null,
  "gallery_id": null,
  "gallery_state": null,
  "mode": null,
  "number_of_images_in_batch": null,
  "number_of_images_voted_for": null,
  "participants_joined": null,
  "progress_bar_current": null,
  "progress_bar_required": null,
  "reward_coins": null,
  "reward_free_ticket": null,
  "reward_visitors_bonus": null,
  "same_theme_as_my_battle": null,
  "success_in_voting_session": null,
  "theme_id": null,
  "theme_name": null,
  "time_left": null,
  "total_participants": null,
  "total_votes": null,
  "wall_position": null
} | nan |
| UI_ACTIONS | User interface actions | {
  "anonymous_member_id": null,
  "boost_time_left": null,
  "meter_status": null
} | nan |
| AUDIENCE | Audience-related information | {
  "app_release": null,
  "app_version": null,
  "brand": null,
  "model": null,
  "os": "Linux",
  "os_version": null,
  "screen_height": 1117,
  "screen_width": 1920,
  "wifi": null
} | nan |
| UA | User Agent information | {
  "browser": {
    "family": "Chrome",
    "version": [
      93,
      0,
      4577
    ],
    "version_string": "93.0.4577"
  },
  "device": {
    "brand": null,
    "family": "Other",
    "model": null
  },
  "is_bot": false,
  "is_email_client": false,
  "is_mobile": false,
  "is_pc": true,
  "is_tablet": false,
  "is_touch_capable": false,
  "os": {
    "family": "Linux",
    "version": [],
    "version_string": ""
  }
} | nan |
| GEO | Geographical information | {
  "continent": {
    "_locales": [
      "en"
    ],
    "code": "EU",
    "name": "Europe"
  },
  "country": {
    "_locales": [
      "en"
    ],
    "confidence": null,
    "is_in_european_union": true,
    "iso_code": "LT",
    "name": "Lithuania"
  },
  "registered_country": {
    "_locales": [
      "en"
    ],
    "confidence": null,
    "is_in_european_union": true,
    "iso_code": "LT",
    "name": "Lithuania"
  },
  "represented_country": {
    "_locales": [
      "en"
    ],
    "confidence": null,
    "is_in_european_union": false,
    "iso_code": null,
    "type": null
  },
  "traits": {
    "_network": null,
    "_prefix_len": 19,
    "autonomous_system_number": null,
    "autonomous_system_organization": null,
    "connection_type": null,
    "domain": null,
    "ip_address": "46.251.52.137",
    "is_anonymous": false,
    "is_anonymous_proxy": false,
    "is_anonymous_vpn": false,
    "is_hosting_provider": false,
    "is_legitimate_proxy": false,
    "is_public_proxy": false,
    "is_residential_proxy": false,
    "is_satellite_provider": false,
    "is_tor_exit_node": false,
    "isp": null,
    "organization": null,
    "static_ip_score": null,
    "user_count": null,
    "user_type": null
  }
} | nan |
| LOG | Log-related information | {
  "log_data": null,
  "log_data_type": null,
  "log_description": null,
  "log_id": null,
  "log_level": null
} | nan |

---

### EVENTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Unique identifier for the record | d3b16ec54f1d917cbcb46b7a2d41a908 |  |
| TYPE | Type of event or achievement | CHALLENGE_LEVEL_ACHIEVEMENT |  |
| MEMBER_ID | Unique identifier for the member | 8f4b589135ac73c68c490d73f26035bb |  |
| ON_MEMBER_ID | Unique identifier for the affected member (if applicable) | d9b3873208e740c045d61c7352cca4fd |  |
| EVENT_LOCATION | Location of the event | system |  |
| EVENT_LOCATION_ID | Identifier for the event location | 47542 |  |
| ON_EVENT_ID | Identifier for the affected event (if applicable) | nan |  |
| ROOT_EVENT_ID | Identifier for the root event (if applicable) | nan |  |
| CHALLENGE_ID | Identifier for the challenge | 47542 |  |
| TEXT | Text information related to the event | nan |  |
| HTML | HTML content related to the event | nan |  |
| EMBED | Embedded content related to the event | nan |  |
| TITLE | Title of the event | nan |  |
| LINK | Hyperlink related to the event | nan |  |
| IMAGE_ID | Identifier for the associated image | 4dbb7a8963ec2101a93ffdbdbc792153 |  |
| DATE | Date and time of the event | 2021-08-04 07:16:21.000000000 +00:00 |  |
| PARAM | Numeric parameter related to the event | 0 |  |
| VALUE | Numeric value related to the event | 4 |  |
| POINTS | Points associated with the event | 0 |  |
| _FIVETRAN_DELETED | Indicates whether the record is deleted | 0 |  |
| _FIVETRAN_SYNCED | Date and time when the record was last synced by Fivetran | 2022-11-25 08:00:35.751000000 +00:00 |  |
| REMOVED | Indicates whether the record is removed (if applicable) | 0 |  |

---

### IMAGES

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Unique identifier for the image | 9fc7677ce12ac0ffff6671501c6aa89a |  |
| MEMBER_ID | Unique identifier for the member | 7be656f1b7ddbac0f1d9fb2d10747fea |  |
| FILE | File name of the image | 9fc7677ce12ac0ffff6671501c6aa89a.jpg |  |
| TITLE | Title of the image (if applicable) | nan |  |
| DESCRIPTION | Description or caption for the image | nan |  |
| POST_PROCESSING | Post-processing information for the image | nan |  |
| CATEGORY | Category or type of the image | nan |  |
| MAKE | Make or manufacturer of the camera | samsung |  |
| MODEL | Model of the camera | SM-A515F |  |
| F_NUMBER | Aperture value (f-number) | F2 |  |
| EXPOSURE_TIME | Exposure time for the image | 1/25 sec |  |
| EXPOSURE_MODE | Exposure mode used (e.g., Auto) | Auto |  |
| EXPOSURE_PROGRAM | Exposure program used (e.g., Program AE) | Program AE |  |
| METERING_MODE | Metering mode used | Center-weighted average |  |
| FOCUS_MODE | Focus mode used | nan |  |
| FLASH | Flash status (e.g., No Flash) | No Flash |  |
| LENS | Information about the lens | nan |  |
| FOCAL_LENGTH | Focal length of the lens | 4.6 mm |  |
| ISO | ISO sensitivity setting | 500 |  |
| WHITE_BALANCE | White balance setting | Auto |  |
| GPS | GPS coordinates of the image (if available) | nan |  |
| DATE_ORIGINAL | Original date and time of the image | 2020-08-30 10:17:50.000000000 +00:00 |  |
| SOFTWARE | Software used for post-processing | A515FXXU3BTF4 |  |
| WIDTH | Width of the image in pixels | 3000 |  |
| HEIGHT | Height of the image in pixels | 4000 |  |
| DIMENSIONS | Dimensions of the image (width x height) | nan |  |
| ORIENTATION | Orientation of the image (e.g., vertical) | vertical |  |
| ROTATE | Rotation angle of the image | 90 |  |
| MODEL_ICON | Icon representing the model of the camera (if applicable) | nan |  |
| FILE_SIZE | Size of the image file in bytes | 1766745 |  |
| UPLOAD_DATE | Date and time when the image was uploaded | 2020-10-18 17:04:05.000000000 +00:00 |  |
| MD5 | MD5 hash value of the image file | nan |  |
| VIEWS | Number of views for the image | 493 |  |
| IMAGE_SOURCE | Source of the image (e.g., storage) | storage |  |
| IMAGE_SOURCE_ID | Identifier for the image source | nan |  |
| LABELS | Labels or tags associated with the image | Fish,Animal,Goldfish |  |
| LABELS_SCORE | Scores associated with the image labels | a:3:{s:4:"Fish";d:0.9;s:6:"Animal";d:0.9;s:8:"Goldfish";d:0.9;} |  |
| EXPLICIT_CONTENT | Indicates whether the image contains explicit content | nan |  |
| _FIVETRAN_DELETED | Indicates whether the record is deleted | False |  |
| _FIVETRAN_SYNCED | Date and time when the record was last synced by Fivetran | 2022-11-24 18:34:52.388000000 +00:00 |  |
| ADULT | Indicates whether the image is adult content | False |  |
| IMPORT | Indicates whether the image was imported | False |  |
| DELETED_DATE | Date and time when the image was deleted (if applicable) | nan |  |
| IS_DELETED | Indicates whether the image is marked as deleted | False |  |

---

### MARKETING

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| Layer | "Layer": regs, fb spend, non-cohort, installs, revenue - Each layer refers to a different metric. | fb spend |  |
| Date | Date of the data record | 2022-08-17 00:00:00 |  |
| __dyn_day | Dynamic day field (appears to be empty) | nan |  |
| __dyn_week | Dynamic week field | 2022-08-15 00:00:00 |  |
| __dyn_month | Dynamic month field | 2022-08-01 00:00:00 |  |
| __dyn_quarter | Dynamic quarter field | 2022Q3 |  |
| __dyn_year | Dynamic year field | 2022 |  |
| Media Source | Source of media (e.g., Facebook Ads) | Facebook Ads |  |
| Conversion Platform | Conversion platform information | nan |  |
| Reg Platform (DB) | Registration platform information (Database) | nan |  |
| Conversion OS | Conversion operating system | nan |  |
| Referring Domain | Referring domain information | nan |  |
| Landing Page | Landing page information | nan |  |
| Country | Country of the data record | US |  |
| Ad ID | Ad identifier | 23851372365590710 |  |
| Ad Set ID | Ad Set identifier | 23851372365600710 |  |
| Campaign ID | Campaign identifier | 23851372365500710 |  |
| Activity Date | Date of the activity (appears to be empty) | nan |  |
| User Age | User age information | nan |  |
| USER_AGE_CURRENT | Current user age information | 468 |  |
| MEMBER_ID | Member identifier | nan |  |
| FISH_RATE | Fish rate information | nan |  |
| FISH_RATE_DAY_3 | Fish rate for day 3 | nan |  |
| FISH_RATE_DAY_7 | Fish rate for day 7 | nan |  |
| FISH_RATE_DAY_30 | Fish rate for day 30 | nan |  |
| Revenue | Revenue generated | nan |  |
| NET_Revenue | Net revenue generated | nan |  |
| Revenue (NOC) | Revenue excluding non-cohort | nan |  |
| NET_Revenue (NOC) | Net revenue excluding non-cohort | nan |  |
| FTDs | First-time deposits | nan |  |
| FTD (td 000) | FTDs for day 0 | nan |  |
| FTD (td 001) | FTDs for day 1 | nan |  |
| FTD (td 003) | FTDs for day 3 | nan |  |
| FTD (td 007) | FTDs for day 7 | nan |  |
| FTD (td 014) | FTDs for day 14 | nan |  |
| FTD (td 030) | FTDs for day 30 | nan |  |
| FTD (td 090) | FTDs for day 90 | nan |  |
| FTD (td 180) | FTDs for day 180 | nan |  |
| FTDs (NOC) | FTDs excluding non-cohort | nan |  |
| Transactions | Number of transactions | nan |  |
| Account Name | Name of the advertising account | Gurushots Ads K Logic |  |
| Account ID | Identifier for the advertising account | 1121135764590774 |  |
| Campaign Name | Name of the advertising campaign | YellowHead_Android_AEO-1D_LAL_TopCountries_16.08 |  |
| Ad Set Name | Name of the advertising set | YellowHead_Android_AEO-D1_LAL-2%Payers50+_TopCountries_16.08 |  |
| Ad Name | Name of the ad | Client_badge_nature_v2_pac_July22 |  |
| App ID | Identifier for the mobile app | com.gurushots.app |  |
| Attribution Type | Type of attribution | nan |  |
| Registrations | Number of registrations | nan |  |
| Installs | Number of app installs | nan |  |
| installs_old | Number of old installs | nan |  |
| Spend | Advertising spend | 7.94 |  |
| Impressions | Number of ad impressions | 304 |  |
| Clicks | Number of ad clicks | 2 |  |
| Revenue (td 000) | Revenue for day 0 | nan |  |
| Revenue (td 001) | Revenue for day 1 | nan |  |
| Revenue (td 003) | nan | nan |  |
| Revenue (td 007) | nan | nan |  |
| Revenue (td 014) | nan | nan |  |
| Revenue (td 030) | nan | nan |  |
| Revenue (td 090) | nan | nan |  |
| Revenue (td 180) | nan | nan |  |
| Revenue (LT) | nan | nan |  |
| NET_Revenue (td 000) | nan | nan |  |
| NET_Revenue (td 001) | nan | nan |  |
| NET_Revenue (td 003) | nan | nan |  |
| NET_Revenue (td 007) | nan | nan |  |
| NET_Revenue (td 014) | nan | nan |  |
| NET_Revenue (td 030) | nan | nan |  |
| NET_Revenue (td 090) | nan | nan |  |
| NET_Revenue (td 180) | nan | nan |  |
| NET_Revenue (LT) | nan | nan |  |
| Spend (td 000) | nan | 7.94 |  |
| Spend (td 001) | nan | 7.94 |  |
| Spend (td 003) | nan | 7.94 |  |
| Spend (td 007) | nan | 7.94 |  |
| Spend (td 014) | nan | 7.94 |  |
| Spend (td 030) | nan | 7.94 |  |
| Spend (td 090) | nan | 7.94 |  |
| Spend (td 180) | nan | 7.94 |  |
| Spend (LT) | nan | 7.94 |  |

---

### MEMBER

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Unique identifier for the user | 20583a6b8a084bae092d4961e71e771a |  |
| USER_NAME | User's username | maite.renedo |  |
| FIRST_NAME | User's first name | Misterio |  |
| LAST_NAME | User's last name | R.L |  |
| EMAIL | User's email address | ma2506ite@hotmail.com |  |
| PASSWORD | Encrypted password | $2y$10$ebOcWga.B.xG5LBARaOViOY2ko7cD9qhhSeifqoI.8zgBFyekqrjy |  |
| TOKEN | User's authentication token | d8f31091ec61768aad4f54decb1201ec2bb805a71d2e012a7e0f426fade0f60be9f009b48c63638ec50c298dbe8cf785 |  |
| PAYPAL | PayPal account information (appears to be empty) | nan |  |
| REG_DATE | Registration date and time | 2019-01-12 16:30:17.000000000 +00:00 |  |
| LAST_LOGIN | Date and time of the last login | 2023-11-08 21:07:44.000000000 +00:00 |  |
| IP_ADDRESS | User's IP address | 186.4.27.165 |  |
| ACTIVATION_CODE | Activation code for account activation | NzhhMmRkNTQ3Njg4NmZkODEyOTJjODJmMWM2MTFlYTM |  |
| TRACKING_CODE | Tracking code associated with the user | ecaffa05a30bcedac2dc0aeec780e2f7 |  |
| VIEWS | Number of views | 0 |  |
| MEMBER_STATUS | Numerical code representing the member's status | 13 |  |
| MEMBER_STATUS_NAME | Member status name (e.g., "GURU IV") | GURU IV |  |
| MEMBER_STATUS_PROGRESS | Progress percentage towards the next member status | 89.00854701 |  |
| POINTS | Total points earned by the user | 7309890 |  |
| VOTING_POWER | Voting power associated with the user | 9 |  |
| EXTERNAL_ID | External identifier | nan |  |
| EXTERNAL_SOURCE_ID | External source identifier | 0 |  |
| EXTERNAL_SOURCE_AD | External source ad information | nan |  |
| REFERRAL | Referral information, possibly a URL | https://www.facebook.com/ |  |
| _FIVETRAN_DELETED | Flag indicating if the record is deleted | 0 |  |
| _FIVETRAN_SYNCED | Date and time of Fivetran synchronization | 2023-11-29 06:40:46.429000000 +00:00 |  |
| ACTIVATED | Flag indicating if the account is activated  | True |  |
| ADMIN_MODE | Flag indicating if the user is in admin mode  | 0 |  |
| NOTIFY | Flag indicating if notifications are enabled | True |  |
| IS_PIONEER | Flag indicating if the user is a pioneer | 0 |  |
| DISABLE_FUNDS | Flag indicating if funds are disabled  | True |  |
| SCORE | User's score | nan |  |
| MODERATOR | Moderator status | 0 |  |
| MODERATOR_BADGE | Moderator badge status | 0 |  |
| ACCOUNT_DELETED | Flag indicating if the account is deleted | 0 |  |
| MEMBER_LEAGUE_ID | Member league identifier | 10 |  |

---

### PAYMENTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Unique identifier for the payment | 4891271 |  |
| TYPE | Type of transaction (e.g., WEB for web transaction) | WEB |  |
| DEVICE | Device used for the transaction (e.g., DESKTOP) | DESKTOP |  |
| OS | Operating system used for the transaction | chrome os |  |
| OS_VERSION | Version of the operating system | 14092.77.0 |  |
| METHOD | Payment method used (e.g., credit_card) | credit_card |  |
| TOKEN | Token associated with the transaction | 432005042 |  |
| MEMBER_ID | Member identifier associated with the transaction | d4d40ad74638ded92bf451a4d8f58454 |  |
| PACKAGE_ID | Identifier for the package related to the payment | 103 |  |
| PARAM | Additional parameters for the payment | nan |  |
| AMOUNT | Amount of the payment | 2.99000001 |  |
| PAYMENT_ID | Identifier for the payment | 766831496 |  |
| PAYME_SALE_CODE | Sale code associated with the payment | nan |  |
| IS_PAID | Flag indicating if the payment is paid (1 for true) | 1 |  |
| STATUS | Status of the payment (e.g., completed) | completed |  |
| STATUS_ERROR_CODE | Error code associated with the payment status | nan |  |
| STATUS_ERROR_DETAILS | Details about the error associated with the status | nan |  |
| STATUS_ADDITIONAL_INFO | Additional information related to the payment status | nan |  |
| COMMENT | Additional comments or notes about the payment | nan |  |
| DATE_PAID | Date and time when the payment was completed | 2023-11-29 06:29:56.000000000 +00:00 |  |
| DATE_REFUNDED | Date and time when the payment was refunded | nan |  |
| DATE_PINGBACK | Date and time of the pingback for the payment | nan |  |
| _FIVETRAN_DELETED | Flag indicating if the record is deleted (FALSE in example) | False |  |
| _FIVETRAN_SYNCED | Date and time of Fivetran synchronization | 2023-11-29 06:41:26.681000000 +00:00 |  |
| REFUNDED | Flag indicating if the payment was refunded (FALSE in example) | False |  |

---

### PAYMENTS (GS only)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Unique identifier for the payment | 4862654 | nan |
| TYPE | Type of transaction (e.g., WEB for web transaction) | WEB | nan |
| DEVICE | Device used for the transaction (e.g., DESKTOP) | DESKTOP | nan |
| OS | Operating system used for the transaction | windows | nan |
| OS_VERSION | Version of the operating system | 10 | nan |
| METHOD | Payment method used (e.g., paypal) | paypal | nan |
| TOKEN | Token associated with the transaction | PAYID-MVC6O3I43952803FU256802D | nan |
| MEMBER_ID | Member identifier associated with the transaction | 8ce46cdae29cf45c359d94d22179635c | nan |
| PACKAGE_ID | Identifier for the package related to the payment  | 10001 | IF ABOVE 10,000 THEN GS BATTLES |
| PARAM | Additional parameters for the payment | 0 | nan |
| AMOUNT | Amount of the payment | 9.989999771 | nan |
| PAYMENT_ID | Identifier for the payment | nan | nan |
| PAYME_SALE_CODE | Sale code associated with the payment | nan | nan |
| IS_PAID | Flag indicating if the payment is paid (0 for false) | 0 | nan |
| STATUS | Status of the payment (e.g., captured) | captured | nan |
| STATUS_ERROR_CODE | Error code associated with the payment status | nan | nan |
| STATUS_ERROR_DETAILS | Details about the error associated with the status | nan | nan |
| STATUS_ADDITIONAL_INFO | Additional information related to the payment status | nan | nan |
| COMMENT | Additional comments or notes about the payment | nan | nan |
| DATE_PAID | Date and time when the payment was captured | 2023-11-04 06:40:45.000000000 +00:00 | nan |
| DATE_REFUNDED | Date and time when the payment was refunded | nan | nan |
| DATE_PINGBACK | Date and time of the pingback for the payment | nan | nan |
| _FIVETRAN_DELETED | Flag indicating if the record is deleted (FALSE in example) | 0 | nan |
| _FIVETRAN_SYNCED | Date and time of Fivetran synchronization | 2023-11-04 12:40:30.030000000 +00:00 | nan |
| REFUNDED | Flag indicating if the payment was refunded (FALSE in example) | 0 | nan |

---

### ACHIEVMENTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Unique identifier for the record | 235632889 | nan |
| ITEM_ID | Identifier for the associated item or entity | 751dad8794defdf7295c1a061befc92b | nan |
| VALUE | Numeric value associated with the record | 100 | nan |
| PARAM | Parameter or category associated with the record | rank | nan |
| DATE | Date and time when the record was created | 2023-11-22 20:37:11 | nan |
| CHALLENGE_ID | Identifier for the associated challenge | 63431 | nan |
| TYPE | Type or category of the achievement | TOP_PHOTO_ACHIEVEMENT | nan |
| _FIVETRAN_DELETED | Flag indicating if the record is deleted (FALSE in example) | False | nan |
| _FIVETRAN_SYNCED | Date and time of Fivetran synchronization | 2023-11-23 00:39:37.788000000 +00:00 | nan |

---

### APP STARTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| END_DATE | Date when the session ended | 2023-11-29 00:00:00 | nan |
| USER_ID | Unique identifier for the user | 94b74457e491cabf1b4f1178d4ffde87 | nan |
| SESSION_ID | Unique identifier for the session | 94b74457e491cabf1b4f1178d4ffde8720231129001 | nan |
| START_TIME | Date and time when the session started | 2023-11-29 00:36:13 | nan |
| END_TIME | Date and time when the session ended | 2023-11-29 00:37:04 | nan |
| START_USER_LEVEL | User level at the start of the session | 7 | nan |
| END_USER_LEVEL | User level at the end of the session | 7 | nan |
| IS_PAYER | Indicates whether the user is a payer (TRUE in example) | True | nan |
| IS_CONVERSION_SESSION | Indicates if the session is a conversion session (FALSE in example) | False | nan |
| TOTAL_USD_GROSS | Total gross amount in USD | False | nan |
| SESSION_PAYMENTS_GROSS_USD | Gross USD payments made during the session | False | nan |
| SESSION_PAYMENTS_COUNT | Number of payments made during the session | False | nan |
| TOTAL_PAYMENTS_COUNT | Total number of payments for the user | True | nan |
| REASORCES | Placeholder field, possibly misspelled (check intended name) | nan | nan |
| SESSION_STATS | Placeholder field, possibly misspelled (check intended name) | nan | nan |
| DEVICE_DATA | JSON data containing device information | {"ip_address": "108.147.193.40", "user_agent": "GuruShotsIOS/2.16.3 (com.gurushots.app; build:28; iOS 15.6.0) Alamofire/5.8.0"} | nan |
| SESSION_DURATION | Duration of the session in seconds | 51 | nan |
| SESSION_REASON | Reason for the session ending (timeout in example) | 1.timeout | nan |
| PLATFORM | Platform on which the session occurred (IOS in example) | IOS | nan |

---

### EVENTS (same table, filter by `type` for fills/joins/swaps)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Identifier for the exposure event | 4000000000000 | nan |
| TYPE | Type of exposure event | EXPOSURE_AUTOFILL | TYPE = 'EXPOSURE_AUTOFILL' for Fills only |
| MEMBER_ID | Unique identifier for the member | ff02d5b19eb7bf3332ea9ed18f8215e4 | nan |
| ON_MEMBER_ID | Unique identifier for the member on whom the exposure occurred | ff02d5b19eb7bf3332ea9ed18f8215e4 | nan |
| EVENT_LOCATION | Location or platform where the exposure event occurred | android_app | nan |
| EVENT_LOCATION_ID | Unique identifier for the location of the exposure event | 63473 | nan |
| ON_EVENT_ID | Identifier for the related event (if applicable) | 0 | nan |
| ROOT_EVENT_ID | Identifier for the root event (if applicable) | 0 | nan |
| CHALLENGE_ID | Identifier for the challenge related to the exposure event | 63473 | nan |
| TEXT | Text information related to the exposure event (empty in example) | nan | nan |
| HTML | HTML information related to the exposure event (empty in example) | nan | nan |
| EMBED | Embedded content related to the exposure event (empty in example) | nan | nan |
| TITLE | Title of the exposure event (empty in example) | nan | nan |
| LINK | Link associated with the exposure event (empty in example) | nan | nan |
| IMAGE_ID | Identifier for the associated image (empty in example) | nan | nan |
| DATE | Date and time when the exposure event occurred | 2023-11-25 09:58:45.000000000 +00:00 | nan |
| PARAM | Additional parameters related to the exposure event (empty in example) | nan | nan |
| VALUE | Numeric value associated with the exposure event | 100 | nan |
| POINTS | Points awarded for the exposure event (empty in example) | 0 | nan |
| _FIVETRAN_DELETED | Indicates whether the record has been deleted (FALSE in example) | 0 | nan |
| _FIVETRAN_SYNCED | Date and time when the record was synced with Fivetran | 2023-11-25 12:40:07.882000000 +00:00 | nan |
| REMOVED | Indicates whether the exposure event has been removed (FALSE in example) | 0 | nan |

---

### EVENTS (same table, filter by `type` for fills/joins/swaps)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Identifier for the exposure event | 4000000000000 | nan |
| TYPE | Type of exposure event | PHOTO_SWAP | TYPE = 'PHOTO_SWAP' for Swaps only |
| MEMBER_ID | Unique identifier for the member | ff02d5b19eb7bf3332ea9ed18f8215e4 | nan |
| ON_MEMBER_ID | Unique identifier for the member on whom the exposure occurred | ff02d5b19eb7bf3332ea9ed18f8215e4 | nan |
| EVENT_LOCATION | Location or platform where the exposure event occurred | android_app | nan |
| EVENT_LOCATION_ID | Unique identifier for the location of the exposure event | 63473 | nan |
| ON_EVENT_ID | Identifier for the related event (if applicable) | 0 | nan |
| ROOT_EVENT_ID | Identifier for the root event (if applicable) | 0 | nan |
| CHALLENGE_ID | Identifier for the challenge related to the exposure event | 63473 | nan |
| TEXT | Text information related to the exposure event (empty in example) | nan | nan |
| HTML | HTML information related to the exposure event (empty in example) | nan | nan |
| EMBED | Embedded content related to the exposure event (empty in example) | nan | nan |
| TITLE | Title of the exposure event (empty in example) | nan | nan |
| LINK | Link associated with the exposure event (empty in example) | nan | nan |
| IMAGE_ID | Identifier for the associated image (empty in example) | nan | nan |
| DATE | Date and time when the exposure event occurred | 2023-11-25 09:58:45.000000000 +00:00 | nan |
| PARAM | Additional parameters related to the exposure event (empty in example) | nan | nan |
| VALUE | Numeric value associated with the exposure event | 100 | nan |
| POINTS | Points awarded for the exposure event (empty in example) | 0 | nan |
| _FIVETRAN_DELETED | Indicates whether the record has been deleted (FALSE in example) | 0 | nan |
| _FIVETRAN_SYNCED | Date and time when the record was synced with Fivetran | 2023-11-25 12:40:07.882000000 +00:00 | nan |
| REMOVED | Indicates whether the exposure event has been removed (FALSE in example) | 0 | nan |

---

### EVENTS (for keys)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Identifier for the key event | 40000000000 | nan |
| MEMBER_ID | Unique identifier for the member | b73f30c01c72058ade510ad99688f6a2 | nan |
| ON_MEMBER_ID | Unique identifier for the member on whom the key event occurred | b73f30c01c72058ade510ad99688f6a2 | nan |
| TYPE | Type of key event | KEY | nan |
| EVENT_LOCATION | Location or platform where the key event occurred | web | nan |
| EVENT_LOCATION_ID | Unique identifier for the location of the key event | 63496 | nan |
| CHALLENGE_ID | Identifier for the challenge related to the key event | 63496 | nan |
| TEXT | Text information related to the key event (empty in example) | nan | nan |
| HTML | HTML information related to the key event (empty in example) | nan | nan |
| EMBED | Embedded content related to the key event (empty in example) | nan | nan |
| TITLE | Title of the key event (empty in example) | nan | nan |
| LINK | Link associated with the key event (empty in example) | nan | nan |
| IMAGE_ID | Identifier for the associated image (empty in example) | nan | nan |
| DATE | Date and time when the key event occurred | 2023-11-29 00:39:52.000000000 +00:00 | nan |
| PARAM | Additional parameters related to the key event | EXPOSURE_BOOST | nan |
| _FIVETRAN_DELETED | Indicates whether the record has been deleted (FALSE in example) | False | nan |
| _FIVETRAN_SYNCED | Date and time when the record was synced with Fivetran | 2023-11-29 06:40:19.316000000 +00:00 | nan |
| ON_EVENT_ID | Identifier for the related event (FALSE in example) | False | nan |
| ROOT_EVENT_ID | Identifier for the root event (FALSE in example) | False | nan |
| VALUE | Boolean value associated with the key event | True | nan |
| REMOVED | Indicates whether the key event has been removed (FALSE in example) | False | nan |
| POINTS | Points awarded for the key event (FALSE in example) | False | nan |

---

### EVENTS (for Joins)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID | Identifier for the join challenge event | 4000000000000 | nan |
| MEMBER_ID | Unique identifier for the member joining the challenge | 07c2800d220419d010eb699d2a7aa786 | nan |
| ON_MEMBER_ID | Unique identifier for the member on whom the join challenge event occurred | 07c2800d220419d010eb699d2a7aa786 | nan |
| TYPE | Type of event indicating a member joining a challenge | JOIN_CHALLENGE | TYPE='JOIN_CHALLENGE' |
| EVENT_LOCATION | Location or platform where the join challenge event occurred | ios_app | nan |
| EVENT_LOCATION_ID | Unique identifier for the location of the join challenge event | 63307 | nan |
| CHALLENGE_ID | Identifier for the challenge related to the join event | 63307 | nan |
| TEXT | Text information related to the join challenge event (empty in example) | nan | nan |
| HTML | HTML information related to the join challenge event (empty in example) | nan | nan |
| EMBED | Embedded content related to the join challenge event (empty in example) | nan | nan |
| TITLE | Title of the join challenge event (empty in example) | nan | nan |
| LINK | Link associated with the join challenge event (empty in example) | nan | nan |
| IMAGE_ID | Identifier for the associated image (empty in example) | nan | nan |
| DATE | Date and time when the join challenge event occurred | 2023-11-11 01:32:44.000000000 +00:00 | nan |
| PARAM | Additional parameters related to the join challenge event (empty in example) | nan | nan |
| VALUE | Value associated with the join challenge event | 1 | nan |
| POINTS | Points awarded for the join challenge event (0 in example) | 0 | nan |
| _FIVETRAN_DELETED | Indicates whether the record has been deleted (FALSE in example) | 0 | nan |
| _FIVETRAN_SYNCED | Date and time when the record was synced with Fivetran | 2023-11-11 06:41:26.534000000 +00:00 | nan |
| REMOVED | Indicates whether the join challenge event has been removed (FALSE in example) | 0 | nan |

---

### EVENTS_VOTES_AGG

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| CHALLENGE_ID | Identifier for the associated challenge | 63500 | nan |
| ID | Unique identifier for the vote event | 1050000000000 | nan |
| MEMBER_ID | Unique identifier for the member casting the vote | 259b8c16f5727d8f0ef49c3ee6b77f0f | nan |
| ON_MEMBER_ID | Unique identifier for the member on whom the vote event occurred | 8d556640af3ec6b535ada54984ac911f | nan |
| TYPE | Type of event indicating a member's vote | VOTE | nan |
| EVENT_LOCATION | Location or platform where the vote event occurred | android_app | nan |
| EVENT_LOCATION_ID | Unique identifier for the location of the vote event | 63505 | nan |
| ON_EVENT_ID | Identifier for the event on which the vote is cast | 3456016389 | nan |
| ROOT_EVENT_ID | Identifier for the root event related to the vote | 3456016389 | nan |
| TEXT | Text information related to the vote event | default | nan |
| HTML | HTML information related to the vote event (empty in example) | nan | nan |
| EMBED | Embedded content related to the vote event (empty in example) | nan | nan |
| TITLE | Title of the vote event (empty in example) | nan | nan |
| LINK | Link associated with the vote event (empty in example) | nan | nan |
| IMAGE_ID | Identifier for the associated image | ae98eab9bf68033449f22f117788b3a7 | nan |
| DATE | Date and time when the vote event occurred | 2023-11-30 04:22:51.000000000 +00:00 | nan |
| PARAM | Additional parameters related to the vote event | 70.233.110.166 | nan |
| VALUE | Value associated with the vote event (e.g., the vote value) | 8 | nan |
| POINTS | Points awarded for the vote event (0 in example) | 0 | nan |
| _FIVETRAN_DELETED | Indicates whether the record has been deleted | 0 | nan |
| _FIVETRAN_SYNCED | Date and time when the record was synced with Fivetran | 2023-11-30 06:41:32.371000000 +00:00 | nan |
| REMOVED | Indicates whether the vote event has been removed | 0 | nan |

---

### GS Battles (for Ranking)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| _FILE | nan | 1685553491.789.json | nan |
| _LINE | nan | 0 | nan |
| _MODIFIED | nan | 2023-05-31 17:18:12.000000000 +00:00 | nan |
| DATA | nan | {
  "log_context": {
    "name": "image-hanged"
  },
  "log_data": {
    "imageId": "7c8c73695798ed2aefefbf96457ce120",
    "level": 1,
    "memberId": "f5928efb65ae9cdb6b5b33803218ed98",
    "spotId": "spot1",
    "stars": 150
  },
  "log_environment": "preprod",
  "log_service": "gsms-spaces",
  "log_time": 1685553491789
} | DATA :log_context: name::varchar = 'image-hanged' |
| _FIVETRAN_SYNCED | nan | 2023-05-31 17:41:06.351000000 +00:00 | to convert to datetime format: to_timestamp_ntz(DATA:log_time::number / 1000)::datetime |
| _DATA | nan | nan | nan |

---

### GS Battles (for SuccessRate)

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| MEMBER_ID | Identifier for the member | 960ee2b00642e993708fc921382400f4 | nan |
| CLIENT_IP | IP address of the client | 78.21.59.240 | nan |
| DEVICE_ID | Identifier for the device | 32FDD00B-AB34-40E6-A029-252C1EB5565B | nan |
| SERVER_TIME | Server time when the event occurred | 2023-11-30 07:46:26.714000 | nan |
| PLATFORM | Platform from which the event was triggered | ios | nan |
| CLIENT_TIME | Client time when the event occurred | 2023-11-30 07:45:31 | nan |
| EVENT | Type of event | voting_1v1_selected_photo | nan |
| UTM | UTM parameters associated with the event | {
  "campaign": null,
  "fbclid": null,
  "medium": null,
  "source": null,
  "url": null
} | nan |
| UI | User interface parameters | {
  "menu_selection": null,
  "onboarding_stage": null,
  "order_type": null,
  "tooltip_status": null,
  "tooltip_type": null,
  "tutorial_version": null,
  "ui_action": "vote_right",
  "ui_category": null,
  "ui_name": "1v1_voting",
  "ui_type": null,
  "viewed_member_id": null
} | nan |
| RV | RV parameters | {
  "ad_info": null,
  "ad_unit_id": null,
  "collected_coins": null,
  "rv_status": null
} | nan |
| CHALLENGE | Challenge-related parameters | {
  "challenge_id": null,
  "challenge_tag": null,
  "vote_count": null
} | nan |
| RESOURCES | Resource-related parameters | {
  "fills_amount": null,
  "number_of_challenges_to_fill": null,
  "resource_balance": null
} | nan |
| PURCHASES | Purchase-related parameters | {
  "amount_collected": null,
  "current_balance": null,
  "fail_type": null,
  "offer_amount": null,
  "origin": null,
  "package_id": null,
  "package_type": null,
  "position": null,
  "price": null
} | nan |
| BATTLES | Battles-related parameters | {
  "batteries_available": null,
  "battle_id": 1159570,
  "battle_joins": null,
  "cost_amount": null,
  "cost_type": null,
  "current_exposure_bonus": null,
  "current_gallery_id": null,
  "current_rank": null,
  "current_votes": null,
  "error_in_voting_session": null,
  "exposure_meter_status": null,
  "fail_in_voting_session": null,
  "free_ticket_amount": null,
  "gallery_id": null,
  "gallery_state": null,
  "mode": null,
  "number_of_images_in_batch": null,
  "number_of_images_voted_for": null,
  "participants_joined": null,
  "progress_bar_current": null,
  "progress_bar_required": null,
  "reward_coins": null,
  "reward_free_ticket": null,
  "reward_visitors_bonus": null,
  "same_theme_as_my_battle": null,
  "success_in_voting_session": 0,
  "theme_id": null,
  "theme_name": null,
  "time_left": null,
  "total_participants": null,
  "total_votes": null,
  "wall_position": null
} | MEMBER_ID: Already present in the main table.

BATTLES:battle_id: Extract the value from the "BATTLES" JSON object under the "battle_id" key.

Platform: Extract from the "PLATFORM" column.

BATTLES:success_in_voting_session: Extract the value from the "BATTLES" JSON object under the "success_in_voting_session" key.

UI:ui_action: Extract the value from the "UI" JSON object under the "ui_action" key.

BATTLES:total_votes: Extract the value from the "BATTLES" JSON object under the "total_votes" key. |
| UI_ACTIONS | User interface actions | {
  "anonymous_member_id": null,
  "boost_time_left": null,
  "meter_status": null
} | nan |
| AUDIENCE | Audience-related parameters | {
  "app_release": "9",
  "app_version": "2.19.0",
  "brand": "Apple",
  "model": "iPhone12,5",
  "os": "iOS",
  "os_version": "17.1.1",
  "screen_height": 896,
  "screen_width": 414,
  "wifi": true
} | nan |
| UA | User agent details | {
  "browser": {
    "family": "GuruShots",
    "version": [
      9
    ],
    "version_string": "9"
  },
  "device": {
    "brand": "Apple",
    "family": "iOS-Device",
    "model": "iOS-Device"
  },
  "is_bot": false,
  "is_email_client": false,
  "is_mobile": true,
  "is_pc": false,
  "is_tablet": false,
  "is_touch_capable": true,
  "os": {
    "family": "iOS",
    "version": [],
    "version_string": ""
  }
} | nan |
| GEO | Geographical information | {
  "continent": {
    "_locales": [
      "en"
    ],
    "code": "EU",
    "name": "Europe"
  },
  "country": {
    "_locales": [
      "en"
    ],
    "confidence": null,
    "is_in_european_union": true,
    "iso_code": "BE",
    "name": "Belgium"
  },
  "registered_country": {
    "_locales": [
      "en"
    ],
    "confidence": null,
    "is_in_european_union": true,
    "iso_code": "BE",
    "name": "Belgium"
  },
  "represented_country": {
    "_locales": [
      "en"
    ],
    "confidence": null,
    "is_in_european_union": false,
    "iso_code": null,
    "type": null
  },
  "traits": {
    "_network": null,
    "_prefix_len": 14,
    "autonomous_system_number": null,
    "autonomous_system_organization": null,
    "connection_type": null,
    "domain": null,
    "ip_address": "78.21.59.240",
    "is_anonymous": false,
    "is_anonymous_proxy": false,
    "is_anonymous_vpn": false,
    "is_hosting_provider": false,
    "is_legitimate_proxy": false,
    "is_public_proxy": false,
    "is_residential_proxy": false,
    "is_satellite_provider": false,
    "is_tor_exit_node": false,
    "isp": null,
    "organization": null,
    "static_ip_score": null,
    "user_count": null,
    "user_type": null
  }
} | nan |
| LOG | Log-related parameters | {
  "log_data": null,
  "log_data_type": null,
  "log_description": null,
  "log_id": null,
  "log_level": null
} | nan |

---

### GS  CLIENT EVENTS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| ID |  Unique identifier for the record          |  | nan |
| TYPE | Type of event          |  | PHOTO_SWAP        Swaps Used
EXPOSURE_AUTOFILL        Fills Used
EXPOSURE_BOOST        Boost Used
JOIN_CHALLENGE        User Joined a Challenge
CHALLENGE_LEVEL_UP        User level up
UPLOAD_PHOTO        User Photo Upload
CHALLENGE_TOP_PHOTO        Top Photo Achieved
CHALLENGE_TOP_PHOTOGRAPHER        Top Photogrpher Achieved
GURU_TOP_PICK        Guru Top Pick Achieved |
| MEMBER_ID | Unique identifier for the member |  | nan |
| ON_MEMBER_ID | Identifier for the member involved in the event |  | nan |
| EVENT_LOCATION | Location where the event occurred |  | nan |
| EVENT_LOCATION_ID | Identifier for the event location |  | nan |
| ON_EVENT_ID | Identifier for the related event       |  | Set to 0 if not applicable |
| ROOT_EVENT_ID | Identifier for the root event         |  | Set to 0 if not applicable |
| CHALLENGE_ID | Identifier for the challenge related to event |  | nan |
| TEXT | Text data associated with the event (if relevant) |  | nan |
| HTML | HTML data associated with the event   |  | empty column |
| EMBED | Embedded content associated with the event   |  | empty column |
| TITLE | Title of the event  |  | empty column |
| LINK | Link associated with the event    |  | empty column |
| IMAGE_ID | Identifier for the associated image  (if relevant) |  | nan |
| DATE | Date and time of the event         |  | nan |
| PARAM | Parameter associated with the event    (if relevant) |  | nan |
| POINTS | Points associated with the event    |  | nan |
| _FIVETRAN_DELETED | Indicates if the record was deleted |  | FALSE if not deleted, TRUE if deleted |
| _FIVETRAN_SYNCED | Date and time of last synchronization |  | nan |
| REMOVED | Indicates if the record was removed |  | FALSE if not deleted, TRUE if deleted |

---

### TEAMS_MEMBERS

| Column Name | Description | Example | Comments |
|-------------|-------------|---------|----------|
| MEMBER_ID | Unique identifier for the member | f65690c1adf1bcf74cee0fa4b3cb62b8 | nan |
| TEAM_ID | Identifier for the team | 295 | nan |
| TYPE | Type of member (e.g., USER, ADMIN) | USER | nan |
| STATUS | Status of the member (e.g., ACTIVE, LEFT)- if user left so last updated is when he left. if user active so he is right now in club | LEFT | nan |
| POINTS | Points associated with the member | 0 | nan |
| DATE_CREATED | Date and time when the member was created | 2023-11-30 01:20:00 | nan |
| DATE_UPDATED | Date and time when the member was updated | 2023-11-30 01:20:45 | nan |
| _FIVETRAN_DELETED | Indicates if the record was deleted | 0 | nan |
| _FIVETRAN_SYNCED | Last synchronization timestamp | 2023-11-30 06:40:03.570000000 +00:00 | nan |
| JOIN_BY | Method used for joining the team | DEFAULT | nan |

---

| _DATA | Additional or raw data associated with the log entry | nan | nan |

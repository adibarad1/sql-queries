-- ==============================================================================
-- SCRIPT NAME: appsflyer_xpend_attribution_debug
-- VERSION: v1.0
-- AUTHOR: Adi B.
-- CREATED: 2024-11-03
--
-- PURPOSE:
--   Cross-validate AppsFlyer install and purchase events against xPend cost data.
--   Used to investigate discrepancies in campaign attribution or revenue mismatch.
--
-- DESCRIPTION:
--   - Loads xPend cost data and matches it with install & purchase events from CF_APPSFLYER_PUSH
--   - Joins based on date, app_id, geo, and flexible matching of campaign structure fields
--   - Aggregates purchase revenue per member, marking first-time deposits (FTD)
--   - Final result includes combined cost, install, purchase, and payment information
--   - Filters by a specific `unique_str` identifier for debugging purposes
--
-- USAGE:
--   Useful for validating whether a given `unique_str` combination is correctly attributed
--   in AppsFlyer and cost systems. Helps identify issues with campaign, adset, or keyword mapping.
--
-- NOTES:
--   - JOINs use null-tolerant logic to allow partial match when fields are missing
--   - Aggregated by all fields due to Snowflake’s `GROUP BY` requirement on SELECTed columns
--   - Payments are enriched with platform and FTD status for cohort-level insights
--   - `unique_str` is expected to uniquely identify a campaign/ad group context
--   - To run this query for other cases, modify the `WHERE unique_str = '...'` filter
-- ==============================================================================

SELECT m.*,
       ins.inst_event_time, 
       ins.is_retargeting AS ins_is_retargeting, 
       ins.app_id AS ins_app_id, 
       --ins.language AS ins_language, 
       ins.af_adset_id AS ins_af_adset_id, 
       ins.af_ad_id AS ins_af_ad_id, 
       ins.media_source AS ins_media_source, 
       ins.platform AS ins_platform, 
       ins.country_code AS ins_country_code, 
       ins.customer_user_id AS ins_customer_user_id, 
       ins.af_channel AS ins_af_channel, 
       ins.campaign AS ins_campaign, 
       ins.device_brand AS ins_device_brand, 
       ins.re_targeting_conversion_type AS ins_re_targeting_conversion_type, 
       ins.af_ad_type AS ins_af_ad_type, 
       ins.af_siteid AS ins_af_siteid, 
       --ins.af_adset AS ins_af_adset, 
       ins.af_keywords AS ins_af_keywords, 
       ins.revenue_in_selected_currency AS ins_revenue_in_selected_currency, 
       pur.pur_event_time, 
       pur.is_retargeting AS pur_is_retargeting, 
       pur.app_id AS pur_app_id, 
       --pur.language AS pur_language, 
       pur.af_adset_id AS pur_af_adset_id, 
       pur.af_ad_id AS pur_af_ad_id, 
       pur.media_source AS pur_media_source, 
       pur.platform AS pur_platform, 
       pur.country_code AS pur_country_code, 
       pur.customer_user_id AS pur_customer_user_id, 
       pur.af_channel AS pur_af_channel, 
       pur.campaign AS pur_campaign, 
       pur.device_brand AS pur_device_brand, 
       pur.re_targeting_conversion_type AS pur_re_targeting_conversion_type, 
       pur.af_ad_type AS pur_af_ad_type, 
       pur.af_siteid AS pur_af_siteid, 
       --pur.af_adset AS pur_af_adset, 
       pur.af_keywords AS pur_af_keywords, 
       pur.revenue_in_selected_currency AS pur_revenue_in_selected_currency, 
       p.*
FROM GURUSHOTS.MARKETING3.APPSFLYER_XPEND_DATA m 
LEFT JOIN (
    SELECT 
        event_time::date AS inst_event_time, 
        is_retargeting, 
        app_id, 
        language, 
        af_adset_id, 
        af_ad_id, 
        media_source, 
        platform, 
        country_code, 
        customer_user_id, 
        af_channel, 
        campaign, 
        device_brand, 
        re_targeting_conversion_type, 
        af_ad_type, 
        af_siteid, 
        af_adset, 
        af_keywords, 
        revenue_in_selected_currency 
    FROM GURUSHOTS.SOURCE_DATA.CF_APPSFLYER_PUSH 
    WHERE event_name = 'install'
) ins 
ON m.date::date = ins.inst_event_time
AND m.app_id = ins.app_id
AND m.media_source = ins.media_source
AND m.geo = ins.country_code
AND (m.campaign = ins.campaign OR m.campaign IS NULL OR ins.campaign IS NULL)
AND (m.channel = ins.af_channel OR m.channel IS NULL OR ins.af_channel IS NULL)
AND (m.adset_id = ins.af_adset_id OR m.adset IS NULL OR ins.af_adset_id IS NULL)
AND (m.ad_id = ins.af_ad_id OR m.ad_id IS NULL OR ins.af_ad_id IS NULL)
AND (m.keywords = ins.af_keywords OR m.keywords IS NULL OR ins.af_keywords IS NULL)
AND (m.site_id = ins.af_siteid OR m.site_id IS NULL OR ins.af_siteid IS NULL)

LEFT JOIN (
    SELECT 
        event_time::date AS pur_event_time, 
        is_retargeting, 
        app_id, 
        language, 
        af_adset_id, 
        af_ad_id, 
        media_source, 
        platform, 
        country_code, 
        customer_user_id, 
        af_channel, 
        campaign, 
        device_brand, 
        re_targeting_conversion_type, 
        af_ad_type, 
        af_siteid, 
        af_adset, 
        af_keywords, 
        revenue_in_selected_currency
    FROM GURUSHOTS.SOURCE_DATA.CF_APPSFLYER_PUSH 
    WHERE event_name = 'purchase'
    -- group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18
) pur 
ON m.date::date = pur.pur_event_time
AND m.app_id = pur.app_id
AND m.media_source = pur.media_source
AND m.geo = pur.country_code
AND (m.campaign = pur.campaign OR m.campaign IS NULL OR pur.campaign IS NULL)
AND (m.channel = pur.af_channel OR m.channel IS NULL OR pur.af_channel IS NULL)
AND (m.adset_id = pur.af_adset_id OR m.adset IS NULL OR pur.af_adset_id IS NULL)
AND (m.ad_id = pur.af_ad_id OR m.ad_id IS NULL OR pur.af_ad_id IS NULL)
AND (m.keywords = pur.af_keywords OR m.keywords IS NULL OR pur.af_keywords IS NULL)
AND (m.site_id = pur.af_siteid OR m.site_id IS NULL OR pur.af_siteid IS NULL)

LEFT JOIN (
   select 
   member_id
   , platform_type
   , date_paid::date date_paid
   , case when rn=1 then TRUE else FALSE end as FTD
   , sum(amount) as amount
   from
   (SELECT 
        os AS platform_type, 
        member_id, 
        --package_id, 
        amount, 
        date_paid, row_number() over (partition by member_id order by date_paid) as rn
    FROM PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.PAYMENTS 
    WHERE is_paid = 1 AND refunded = FALSE)
    group by member_id
   , platform_type
   , date_paid::date
   , FTD
) p 
ON ins.customer_user_id = p.member_id
AND ins.inst_event_time <= p.date_paid::date
where unique_str = '40666425da07d50e2b8190213d5f7a00'
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 
         21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 
         38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 
         55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68--, 69, 70, 71, 72


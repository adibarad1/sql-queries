-- ==============================================================================
-- SCRIPT NAME: kpi_dashboard_user_engagement_monetization_daily_v1
--
-- PURPOSE:
--   Prepare the initial dataset for the KPI dashboard, tracking daily user activity,
--   engagement, and monetization across all platforms (iOS, Android, Web).
--
-- DESCRIPTION:
--   - Extracts DAU for the past 12 months
--   - Joins key behavioral signals: joins, payments (daily + lifetime), photo uploads,
--     resource usage (keys, swaps, fills), votes, and team membership
--   - Enriches with user registration metadata: platform, country, region, tier, status
--   - Calculates user-level metrics: churn_30, FTD_date, pay_lifetime, days_to_ftd, seniority
--   - Final granularity: one row per user_id per day per platform
--
-- USAGE:
--   Used as a base table for KPI dashboard aggregations, trends, and behavioral cohorting
--
-- NOTES:
--   - Covers rolling 12 months (excluding today)
--   - Some logic (e.g., churn_30, FTD detection) is indicative and might require revision
--   - Final version should include filtering and rollup depending on dashboard layer
--
-- VERSION: v1
-- STATUS: final
-- LAST UPDATED: 2025-08-11
-- SOURCES:
--   - GURUSHOTS.Analytics.AGG_USER_SESSION
--   - PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.PAYMENTS
--   - PC_FIVETRAN_DB.VOTING_APPLICATION_PRODUCTION.EVENTS_VOTES
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.EVENTS_KEYS
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER_PROFILE
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER_SETTINGS
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.TEAMS_MEMBERS
-- OUTPUT GRAIN: per user_id per day per platform
-- OWNER: Adi B. (Data)
-- TAGS: [kpi, engagement, monetization, daily, dashboard]
-- ==============================================================================


--dau
with dau as (
Select  distinct to_date(a.START_TIME) as dt_Date
    ,a.PLATFORM
    ,a.USER_ID
From GURUSHOTS."Analytics".AGG_USER_SESSION a
where date_trunc(month,a.START_TIME) between current_date-365 and current_date()-1
    )

,
--join
 joins as (
select to_Date(e.DATE) as dt_Date
        ,(case when e.EVENT_LOCATION='ios_app' then 'IOS'
               when e.EVENT_LOCATION='android_app' then 'ANDROID'
        else 'WEB' end) as Platform_join
        ,e.MEMBER_ID
        ,count(*) as num_joins
from PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS e
where e.TYPE = 'JOIN_CHALLENGE' and REMOVED=false
    and  date_trunc(month,e.DATE) between current_date-365 and current_date()-1
group by 1,2,3
    )
,
--pay
 pay as (
select to_date(p.DATE_PAID) as dt_date_pay
       ,TYPE as Platform_pay
       ,member_id as payer_id_a
       ,count(*) as num_payments
       ,sum(AMOUNT) as sum_revenue
from PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.PAYMENTS p
where IS_PAID=1 and REFUNDED=false and  date_trunc(month,p.DATE_PAID) between current_date-365 and current_date()-1
group by 1,2,3
    )
----PLATFORM_PAY:
--IOS
--ANDROID
--WEB
,

--pay_LT (join it only by member)
 pay_LT as (
select MEMBER_ID as payer_id_b
        ,1 as is_payer
        ,(case when sum(AMOUNT)>=10000 then 'pay_$10K+'
              when sum(AMOUNT)>=5000  then 'pay_$5K-$10K'
              when sum(AMOUNT)>=1000  then 'pay_$1K-$5K'
              when sum(AMOUNT)>=100  then 'pay_$100-$1k'
              when sum(AMOUNT)>=20  then 'pay_$20-$100k'
            else 'pay_below_$20' end) as pay_lifetime
        ,min(to_Date(DATE_PAID)) as FTD_date
from PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.PAYMENTS p
where IS_PAID=1 and REFUNDED=false
group by 1,2
    )
,
--swap_fill
 swap_fill as (
select
       to_date(DATE) as resource_Date_a,
       (case when EVENT_LOCATION='ios_app' then 'IOS'
             when EVENT_LOCATION='android_app' then 'ANDROID'
         else 'WEB' end) as Platform_a,
       MEMBER_ID as member_id_a,
       sum(case when TYPE='PHOTO_SWAP' then 1 else null end) as Swaps_use
       ,sum(case when TYPE='EXPOSURE_AUTOFILL' then 1 else null end) as Fills_use
from PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS
where TYPE in('PHOTO_SWAP','EXPOSURE_AUTOFILL') and date_trunc(month,DATE) between current_date-365 and current_date()-1
group by 1,2,3)
,
--key
key as (
select to_Date(DATE) as resource_Date_b
        ,(case when EVENT_LOCATION='ios_app' then 'IOS'
               when EVENT_LOCATION='android_app' then 'ANDROID'
           else 'WEB' end) as Platform_b
        ,MEMBER_ID as member_id_b
        ,count(*) as Keys_use
from PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.EVENTS_KEYS
where date_trunc(month,DATE) between current_date-365 and current_date()-1
group by 1,2,3
    )
,
--member_details (join it only by member)
member_details as (
select m.ID as member_id_details
        ,to_Date(m.REG_DATE) as reg_Date
        ,m.MEMBER_STATUS_NAME
        ,m.MEMBER_STATUS
        ,mp.COUNTRY
        ,mp.COUNTRY_CODE
        ,case when b.reg_platform='mobile_app' and b.reg_os='ANDROID' then 'android'
            when b.reg_platform='mobile_app' and b.reg_os='IOS' then 'iOS'
            else 'web' end as reg_platform
        ,(case when mp.COUNTRY_CODE in('US','CA') then 'North_America'
            when mp.COUNTRY_CODE in('PL','RO','UA','MD','GB','UK','RU','ES','FR','DE','LT','BA','EE','CH','TR','PT','CZ','GR','IT','DK','RS','MK','BE','NL','IM','MT','GE','SI','IS','AZ','IE','ME','AT','NO','LU','LI','VA','FO','SE','LV','AD','SK','GG','JE','AL','HR','HU','BG','FI','XK','AX','BY','KZ','SJ','FX','GI','YU','MC','CY','SM') then 'Europe'
            else 'ROW' end) as Region
        ,(case when mp.COUNTRY_CODE in('US','GB','UK','CA','AU') then 'Tier_1'
                when mp.COUNTRY_CODE in ('DE','ES','FR','NL','AT','BE','PR','SE','SG','IE','JP','NO','NZ','CH','DK','HK','KR') then 'Tier_2'
                else 'Tier_3' end) as Tier
from PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER m
    join PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER_PROFILE mp on(mp.MEMBER_ID=m.id)
    left join PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.member_settings b on(b.MEMBER_ID=m.id)
    )

,

--votes
votes as (
select to_Date(e.DATE) as dt_Date
        ,(case when e.EVENT_LOCATION='ios_app' then 'IOS'
               when e.EVENT_LOCATION='android_app' then 'ANDROID'
        else 'WEB' end) as Platform_join
        ,e.MEMBER_ID
        ,count(*) as num_votes
from PC_FIVETRAN_DB.VOTING_APPLICATION_PRODUCTION.EVENTS_VOTES e
where REMOVED=false
    and date_trunc(month,e.DATE) between current_date-365 and current_date()-1
group by 1,2,3
    )
,
--UPLOAD_PHOTO...
UPLOAD_PHOTO as (
select TO_DATE(date) as dt_date
        ,(case when EVENT_LOCATION='ios_app' then 'IOS'
               when EVENT_LOCATION='android_app' then 'ANDROID'
        else 'WEB' end) as Platform_upload_photo
        ,MEMBER_ID
        ,count(*) as num_upload_photo
from PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS
where TYPE='UPLOAD_PHOTO' and date_trunc(month,date) between current_date-365 and current_date()-1
group by 1,2,3    )
,
is_team_member as (
select distinct MEMBER_ID as team_member, 1 as is_team_member
from PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.TEAMS_MEMBERS
where STATUS='ACTIVE'
    )


select  dau.dt_Date,
        (case when dau.dt_Date=member_details.reg_Date then 1 else 0 end) as is_reg_date,
        dau.USER_ID,
        dau.PLATFORM,
        joins.num_joins,
        (case when pay.payer_id_a is null then 0 else 1 end) as is_deposit,
        pay.sum_revenue,
        pay.num_payments,
        (case when pay_LT.is_payer is null then 0 else 1 end) as is_ftd,
        pay_LT.FTD_date,
        pay_LT.pay_lifetime,
        swap_fill.Fills_use,
        swap_fill.Swaps_use,
        key.Keys_use,
        member_details.COUNTRY_CODE,
        member_details.COUNTRY,
        member_details.Region,
        member_details.Tier,
        member_details.MEMBER_STATUS,
        member_details.MEMBER_STATUS_NAME,
        member_details.reg_Date,
        member_details.reg_platform,
        votes.num_votes,
        UPLOAD_PHOTO.num_upload_photo,
        (case when is_team_member.is_team_member is null then 0 else 1 end) as is_team_member,
        (case when (current_date() - max(dau.dt_Date) over(partition by dau.USER_ID))>=30 and (dau.dt_Date=max(dau.dt_Date) over(partition by dau.USER_ID)) then 1
                else 0 end) as churn_30,
        max(dau.dt_Date) over(partition by dau.USER_ID) as last_active_date,
        datediff(day,to_Date(member_details.reg_Date),to_date(pay_LT.FTD_date)) as days_to_ftd,
        datediff(day,to_Date(member_details.reg_Date),to_date(dau.dt_Date)) as seniority


from dau
    left join joins on (joins.dt_Date=dau.dt_Date and joins.MEMBER_ID=dau.USER_ID and joins.Platform_join=dau.PLATFORM)
    left join pay on (pay.dt_date_pay=dau.dt_Date and pay.payer_id_a=dau.USER_ID and pay.Platform_pay=dau.PLATFORM)
    left join pay_LT on(pay_LT.payer_id_b=dau.USER_ID)
    left join swap_fill on(swap_fill.resource_Date_a=dau.dt_Date and swap_fill.member_id_a=dau.USER_ID and swap_fill.Platform_a=dau.PLATFORM)
    left join key on(key.resource_Date_b=dau.dt_Date and key.member_id_b=dau.USER_ID and key.Platform_b=dau.PLATFORM)
    left join member_details on(member_details.member_id_details=dau.USER_ID)
    left join votes on(votes.dt_Date=dau.dt_Date and votes.MEMBER_ID=dau.USER_ID and votes.Platform_join=dau.PLATFORM)
    left join UPLOAD_PHOTO on(UPLOAD_PHOTO.dt_date=dau.dt_Date and UPLOAD_PHOTO.MEMBER_ID=dau.USER_ID and UPLOAD_PHOTO.Platform_upload_photo=dau.PLATFORM)
    left join is_team_member on(is_team_member.team_member=dau.USER_ID)

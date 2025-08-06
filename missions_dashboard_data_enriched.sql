
-- ==============================================================================
-- SCRIPT NAME: missions_dashboard_data_enriched
-- VERSION: v1.0
-- AUTHOR: Adi B.
-- CREATED: 2024-10-07
--
-- PURPOSE:
--   Extract detailed member-level mission data for the Missions dashboard.
--
-- DESCRIPTION:
--   - Combines member attributes (region, registration platform, etc.)
--   - Joins mission assignments with mission configuration metadata
--   - Enriches data with prize details and segment targeting logic
--   - Provides mission state (assigned, completed, claimed, expired) and timestamps
--
-- USAGE:
--   Supports mission performance analysis, segmentation insights, and
--   member progression tracking across different mission types and prizes.
--
-- NOTES:
--   - Filters out deleted records (`_fivetran_deleted = FALSE`)
--   - Region is inferred from country code
--   - Some joins rely on JSON flattening of nested mission and prize fields
--   - Final granularity is per member per assigned mission
-- ==============================================================================

WITH members AS (
    SELECT DISTINCT
        mm.MEMBER_ID,
        m.reg_date::date AS reg_date,
        MAX(mp.country_code) AS country_code,
        MAX(
            CASE
                WHEN mp.country_code IN ('US', 'CA') THEN 'North_America'
                WHEN mp.country_code IN (
                    'PL', 'RO', 'UA', 'MD', 'GB', 'UK', 'RU', 'ES', 'FR', 'DE', 'LT', 'BA', 'EE', 'CH', 'TR', 'PT',
                    'CZ', 'GR', 'IT', 'DK', 'RS', 'MK', 'BE', 'NL', 'IM', 'MT', 'GE', 'SI', 'IS', 'AZ', 'IE', 'ME',
                    'AT', 'NO', 'LU', 'LI', 'VA', 'FO', 'SE', 'LV', 'AD', 'SK', 'GG', 'JE', 'AL', 'HR', 'HU', 'BG',
                    'FI', 'XK', 'AX', 'BY', 'KZ', 'SJ', 'FX', 'GI', 'YU', 'MC', 'CY', 'SM'
                ) THEN 'Europe'
                ELSE 'ROW'
            END
        ) AS region,
        MAX(CASE 
            WHEN me.REG_PLATFORM = 'mobile_app' THEN me.REG_OS 
            ELSE 'Web' 
        END) AS reg_platform
    FROM 
        PC_FIVETRAN_DB.GSMS_MAIN_MISSIONS.MEMBER_MISSIONS mm
    LEFT JOIN 
        EVENTS.PUBLIC.CLIENT_EVENTS_OBJECTS_PRD e ON mm.member_id = e.member_id
    LEFT JOIN 
        PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER m ON e.MEMBER_ID = m.ID
    LEFT JOIN 
        PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER_SETTINGS me ON e.MEMBER_ID = me.MEMBER_ID
    LEFT JOIN 
        PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.MEMBER_PROFILE mp ON e.MEMBER_ID = mp.MEMBER_ID
    WHERE 
        e.CLIENT_TIME::date < CURRENT_DATE 
        AND mm._fivetran_deleted = FALSE
    GROUP BY 
        mm.MEMBER_ID, 
        m.reg_date::date
),

missions_members AS (
    SELECT *, 
        (PARSE_JSON(mission_configuration):name)::string AS mission_name,
        (PARSE_JSON(mission_configuration):description)::string AS mission_description,
        prize.value:amount::integer AS prize_amount,
        prize.value:type::string AS prize_type
    FROM 
        PC_FIVETRAN_DB.GSMS_MAIN_MISSIONS.MEMBER_MISSIONS,
        LATERAL FLATTEN(input => (PARSE_JSON(mission_configuration):prizes)) AS prize
    WHERE _FIVETRAN_DELETED = FALSE
),

segments AS (
    SELECT cast(ID as int) AS segment_id,
        name AS segment_name,
        description AS segment_description,
        type AS segment_type,
        parameter AS segment_parameter,
        condition_name AS segment_condition_name,
        value AS segments_value,
        value_type AS segments_value_type
    FROM 
        PC_FIVETRAN_DB.GSMS_MAIN_MISSIONS.SEGMENTS
    WHERE 
        _fivetran_deleted = FALSE
),

missions AS (
  SELECT 
    cast(mg.id as int) as mission_id,
    cast(segment_ids.value as int) AS segment_id,
    cast(group_ids.value as int) AS mission_config_group_id,
    cast(mg.priority as int) AS mission_priority
FROM 
    PC_FIVETRAN_DB.GSMS_MAIN_MISSIONS.MISSION_GROUPS mg
    CROSS JOIN LATERAL FLATTEN(input => PARSE_JSON(mg.MISSION_CONFIG_GROUP_IDS)) AS group_ids
    CROSS JOIN LATERAL FLATTEN(input => PARSE_JSON(mg.SEGMENT_IDS)) AS segment_ids
where  _fivetran_deleted = FALSE
),

configurations AS (
    SELECT DISTINCT
        cast(c.id as int) AS mission_id, 
        c.name AS mission_name,
        c.description AS mission_description,
        c.action AS required_action,
        c.ACTION_PARAMETER_CONDITION_NAME AS required_ACTION_PARAMETER_CONDITION_NAME,
        c.action_parameter AS required_action_parameter,
        c.action_sub_parameter_condition_name,
        c.action_sub_parameter,
        c.duration_hours,
        cast(c.GROUP_ID as int) as group_id,
        p.value:type::string AS prize_type,
        p.value:amount::integer AS prize_amount
    FROM 
        PC_FIVETRAN_DB.GSMS_MAIN_MISSIONS.MISSION_CONFIGURATIONS c,
        LATERAL FLATTEN(input => PARSE_JSON(c.prizes)) AS p
    WHERE _fivetran_deleted = FALSE
)

SELECT distinct
    me.member_id,
    me.reg_date,
    me.country_code,
    me.region,
    me.reg_platform,
    mm.ASSIGNED_on::date as date,
    mm.mission_config_id,
    mm.mission_config_group_id,
    mm.MISSION_CONFIG_ORDER,
    mm.MISSION_CONFIG_ACTION,
    mm.COUNTER,
    mm.ASSIGNED_ON,
    mm.COMPLETED_ON,
    mm.LAST_UPDATE_ON,
    mm.CLAIM_STATE,
    mm.CLAIMED_ON,
    mm.LAST_CLAIM_STATE_UPDATE_ON,
    mm.EXPIRATION_DATE,
    c.PRIZE_TYPE,
    c.PRIZE_AMOUNT,
    c.MISSION_NAME,
    c.MISSION_DESCRIPTION,
    c.REQUIRED_ACTION,
    c.REQUIRED_ACTION_PARAMETER_CONDITION_NAME,
    c.REQUIRED_ACTION_PARAMETER,
    c.ACTION_SUB_PARAMETER_CONDITION_NAME,
    c.ACTION_SUB_PARAMETER,
    c.DURATION_HOURS,
    s.segment_id,
    s.segment_name,
    s.segment_description,
    s.segment_type,
    s.segment_parameter,
    s.segment_condition_name,
    s.segments_value,
    s.segments_value_type
FROM 
    members me
LEFT JOIN 
    missions_members mm ON mm.member_id = me.member_id
LEFT JOIN 
    configurations c ON c.mission_id = mm.mission_config_group_id 
LEFT JOIN 
    missions m ON m.mission_id = mm.MISSION_GROUP_ID and m.mission_config_group_id = c.mission_id
LEFT JOIN 
    segments s ON s.segment_id = m.segment_id

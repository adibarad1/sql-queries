-- =====================================================================
-- SCRIPT NAME: challenge_consumption_summary
-- PURPOSE: Aggregate resource consumption metrics for challenges.
-- DESCRIPTION:
--   - Retrieves total keys, swaps, fills, and coins consumed by members.
--   - Combines data from multiple event tables, filtered by challenge ID or timestamp.
--   - Supports both specific challenge IDs and date-range-based filtering.
-- SOURCES:
--   - PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS
--   - PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.EVENTS_KEYS
--   - PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS_COINS
-- OUTPUT GRAIN: One row per member_id
-- OWNER: Adi B. (Data)
-- TAGS: [analytics, challenges, resource_consumption]
-- LAST UPDATED: 2025-08-11
-- =====================================================================

SELECT 
    member_id,
    SUM(keys_consumed) AS keys_consumed,
    SUM(swaps_consumed) AS swaps_consumed,
    SUM(fills_consumed) AS fills_consumed,
    SUM(coins_consumed) AS coins_consumed
FROM (
    -- By challenge ID
    SELECT 
        e.member_id,
        COUNT(CASE WHEN e.type = 'KEY' THEN 1 END) AS keys_consumed,
        COUNT(CASE WHEN e.type = 'PHOTO_SWAP' THEN 1 END) AS swaps_consumed,
        COUNT(CASE WHEN e.type = 'EXPOSURE_AUTOFILL' THEN 1 END) AS fills_consumed,
        COUNT(CASE WHEN e.type = 'COINS' THEN 1 END) AS coins_consumed
    FROM PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS e
    WHERE e.challenge_id IN (103546, 103537)
      AND e.type IN ('EXPOSURE_AUTOFILL','PHOTO_SWAP','JOIN_CHALLENGE')
    GROUP BY 1

    UNION ALL

    SELECT 
        e.member_id,
        COUNT(CASE WHEN e.type = 'KEY' THEN 1 END),
        COUNT(CASE WHEN e.type = 'PHOTO_SWAP' THEN 1 END),
        COUNT(CASE WHEN e.type = 'EXPOSURE_AUTOFILL' THEN 1 END),
        COUNT(CASE WHEN e.type = 'COINS' THEN 1 END)
    FROM PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.EVENTS_KEYS e
    WHERE e.challenge_id IN (103546, 103537)
      AND e.type = 'KEY'
    GROUP BY 1

    UNION ALL

    SELECT 
        e.member_id,
        COUNT(CASE WHEN e.type = 'KEY' THEN 1 END),
        COUNT(CASE WHEN e.type = 'PHOTO_SWAP' THEN 1 END),
        COUNT(CASE WHEN e.type = 'EXPOSURE_AUTOFILL' THEN 1 END),
        SUM(CASE WHEN e.type = 'COINS' THEN value END)
    FROM PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS_COINS e
    WHERE e.challenge_id IN (103546, 103537)
      AND e.type = 'COINS'
    GROUP BY 1

    UNION ALL

    -- By timestamp
    SELECT 
        e.member_id,
        COUNT(CASE WHEN e.type = 'KEY' THEN 1 END),
        COUNT(CASE WHEN e.type = 'PHOTO_SWAP' THEN 1 END),
        COUNT(CASE WHEN e.type = 'EXPOSURE_AUTOFILL' THEN 1 END),
        COUNT(CASE WHEN e.type = 'COINS' THEN 1 END)
    FROM PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS e
    WHERE e.challenge_id NOT IN (103546, 103537)
      AND e.type IN ('EXPOSURE_AUTOFILL','PHOTO_SWAP','JOIN_CHALLENGE')
      AND e.date BETWEEN '2025-07-03 11:20:00' AND '2025-07-03 14:30:00'
    GROUP BY 1

    UNION ALL

    SELECT 
        e.member_id,
        COUNT(CASE WHEN e.type = 'KEY' THEN 1 END),
        COUNT(CASE WHEN e.type = 'PHOTO_SWAP' THEN 1 END),
        COUNT(CASE WHEN e.type = 'EXPOSURE_AUTOFILL' THEN 1 END),
        COUNT(CASE WHEN e.type = 'COINS' THEN 1 END)
    FROM PC_FIVETRAN_DB.MAIN2_APPLICATION_PRODUCTION.EVENTS_KEYS e
    WHERE e.challenge_id NOT IN (103546, 103537)
      AND e.type = 'KEY'
      AND e.date BETWEEN '2025-07-03 11:20:00' AND '2025-07-03 14:30:00'
    GROUP BY 1

    UNION ALL

    SELECT 
        e.member_id,
        COUNT(CASE WHEN e.type = 'KEY' THEN 1 END),
        COUNT(CASE WHEN e.type = 'PHOTO_SWAP' THEN 1 END),
        COUNT(CASE WHEN e.type = 'EXPOSURE_AUTOFILL' THEN 1 END),
        SUM(CASE WHEN e.type = 'COINS' THEN value END)
    FROM PC_FIVETRAN_DB.MAIN_APPLICATION_PRODUCTION.EVENTS_COINS e
    WHERE e.challenge_id NOT IN (103546, 103537)
      AND e.type = 'COINS'
      AND e.date BETWEEN '2025-07-03 11:20:00' AND '2025-07-03 14:30:00'
    GROUP BY 1
)
GROUP BY member_id
HAVING SUM(keys_consumed) + SUM(swaps_consumed) + SUM(fills_consumed) + SUM(coins_consumed) > 0;

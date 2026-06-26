{{
    config(
        materialized='view'
    )
}}
SELECT 
    STREAM_ID,
    md5(STREAM_ID) AS STREAM_SK,
    TRACK_NAME,
    PLAY_DURATION_SEC / 60 AS DURATION_MIN,
    STATUS,
    CREATED_DATE,
    CASE 
        WHEN dbt_valid_to IS NULL THEN 'Y'
        ELSE 'N'
    END AS CURRENT_RECORD_FLAG,
    {{ CONVERT_DURATION_MIN('DURATION_MIN') }}
FROM {{ ref('snap_raw_tracks') }}   

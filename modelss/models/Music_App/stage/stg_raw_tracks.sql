{{
    config(
        materialized='table'
    )
}}

select 
STREAM_ID,
TRACK_NAME,
PLAY_DURATION_SEC,
STATUS,
cast(CREATED_DATE as timestamp) as CREATED_DATE

from {{ ref('raw_tracks') }}
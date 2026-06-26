{{
    config(
        materialized='table'
    )
}}

select * from {{ ref('int_raw_tracks') }}
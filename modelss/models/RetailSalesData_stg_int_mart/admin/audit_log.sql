{{
    config(
        materialized='table'
    )
}}

select
 cast(null as varchar) as run_id,
 cast(null as varchar) as model_name,
 cast(null as timestamp) as start_time,
 cast(null as timestamp) as end_time,
 cast(null as timestamp) as last_loaded,
 cast(null as varchar) as status

 where 1=0
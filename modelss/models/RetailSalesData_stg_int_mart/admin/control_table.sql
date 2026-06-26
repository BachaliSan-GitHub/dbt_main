{{
    config(
        materialized='table'
    )
}}

select
 cast(null as varchar) as model_name,
 cast(null as timestamp) as last_sucessfull_load,
 cast(null as varchar) as status
 where 1=0
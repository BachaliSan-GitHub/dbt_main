{{
    config(
        materialized='table'
    )
}}

select

    coalesce(departmentkey, -1)                 as department_key,
    coalesce(spid, -1)                          as spid,
    coalesce(costcenterkey, -1)                  as cost_center_key,
    coalesce(divisionkey, -1)                      as division_key,
    coalesce(trim(departmentname), 'UNK')           as department_name,
    coalesce(departmenthead, -1)                     as department_head,
    coalesce(try_to_number(purchasinggroupkey), -1)   as purchasing_group_key,
    coalesce(activeflag, -1)                          as active_flag,
    coalesce(to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),to_date('1900-01-01')) as created_date

from {{ source("raw_data", "Department") }}

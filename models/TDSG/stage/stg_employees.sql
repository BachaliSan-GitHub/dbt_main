{{ config(materialized="table") }}

select

    coalesce(employeekey, -1)                   as employeekey,
    coalesce(departmentkey, -1)                 as departmentkey,
    coalesce(reportingmanagerkey, -1)            as reportingmanagerkey,
    coalesce(plantkey, 'UNK')                         as plantkey,
    coalesce(trim(employeecode), 'UNK')          as employeecode,
    coalesce(trim(employeename), 'UNK')          as employeename,
    coalesce(trim(costcenter), 'UNK')            as costcenter,
    coalesce(isadmin, -1)                        as isadmin,
    coalesce(trim(email), 'UNK')                 as email_id,
    coalesce(trim(empdesignation), 'UNK')        as empdesignation,
    coalesce(isvendorsync, -1)                  as isvendorsync,
    coalesce(trim(employeetype), 'UNK')        as employeetype,
    coalesce(roleid, -1)                       as roleid,
    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as created_date,
    coalesce(isactive, -1) as isactive

from {{ source("raw_data", "employees") }}

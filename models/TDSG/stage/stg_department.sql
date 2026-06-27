{{ config(materialized='table') }}

select 


coalesce(DepartmentKey,-1)                    as department_key,
coalesce(SPID,-1)                             as spid,
coalesce(CostCenterKey,-1)                    as cost_center_key,
coalesce(DivisionKey,-1)                      as division_key,
coalesce(trim(DepartmentName),'UNK')          as department_name,
coalesce(DepartmentHead,-1)                   as department_head,
coalesce(try_to_number(PurchasingGroupKey),-1) as purchasing_group_key,
coalesce(ActiveFlag,-1)                       as active_flag,
coalesce(to_date(try_to_timestamp(CREATEDDATE,'DD-MM-YYYY HH24:MI')),to_date('1900-01-01')) as created_date

 from {{ source('raw_data', 'Department') }}


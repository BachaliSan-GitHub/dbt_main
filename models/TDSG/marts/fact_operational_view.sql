{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='por_id'
    )
}}

select

    s.employeekey,
    s.employeename,
    s.purchasername,
    s.division,

    s.departmentkey,
    s.departmentname,

    s.por_id,
    s.por_no,
    s.status,
    s.ringi_createdby,

    s.ringi_submitted_date,
    s.po_date,

    s.pornumber,
    s.porvalue,
    s.povalueinr,

    s.tat_days,
    s.tat_bucket,

   {% if is_incremental() %}

    case
        when t.por_id is null then current_timestamp()
        else t.created_date
    end as created_date,

{% else %}

    current_timestamp() as created_date,

{% endif %}

    current_timestamp() as updated_date

from {{ ref('int_operational_view') }} s

{% if is_incremental() %}

left join {{ this }} t
    on s.por_id = t.por_id

{% endif %}


{% if is_incremental() %}

where s.po_date >(select coalesce(max(updated_date),'1900-01-01')from {{ this }})

{% endif %}
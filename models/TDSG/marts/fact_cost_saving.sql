{{ config(
    materialized='incremental',
    unique_key='por_id',
    incremental_strategy='merge',
    on_schema_change='sync_all_columns'
) }}

select
    s.por_id,
    s.por_no,
    s.po_no,
    s.ringino,
    s.departmentid,
    s.vendorcode,
    s.vendorname,
    s.por_value,
    s.total_povalue,
    s.povalueinr,
    s.cost_saving,
    s.cost_saving_pct,
    s.delivery_performance,
    s.delivery_rating,
    s.on_time_grn,
    s.pending_delivery,
    s.tat_days,
    s.tat_bucket,
    s.procurement_status,
    s.approval_status,
    s.approval_date,
    s.ringi_submitted_date,
    case
        when t.por_id is null then current_timestamp()
        else t.created_date
    end as created_date,
    case
        when t.por_id is null then null
        else current_timestamp()
    end as updated_date
from {{ ref('int_procurement_kpi') }} s
left join {{ this }} t
    on s.por_id = t.por_id

{% if is_incremental() %}
where coalesce(s.approval_date, s.ringi_submitted_date) > ( select coalesce( max(updated_date),max(created_date),'1900-01-01')from {{ this }} )
{% endif %}
{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='POR_ID'
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

    case
        {% if is_incremental() %}
            when t.por_id is null then current_timestamp()
            else t.created_date
        {% else %}
            when 1=1 then current_timestamp()
        {% endif %}
    end as created_date,

    current_timestamp() as updated_date

from {{ ref('int_procurement_kpi') }} s


{% if is_incremental() %}
left join {{ this }} t
    on s.por_id = t.por_id
{% endif %}
    
{% if is_incremental() %}
where coalesce(
        s.approval_date,
        s.ringi_submitted_date
      ) >
(
    select coalesce(max(updated_date), to_timestamp('1900-01-01'))
    from {{ this }}
)
{% endif %}
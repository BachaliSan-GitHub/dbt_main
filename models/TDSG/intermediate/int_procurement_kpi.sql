{{
    config(
        materialized='incremental',
        unique_key='por_id',
        incremental_strategy='merge',
        on_schema_change='sync_all_columns'
    )
}}

with filtered_source as (

    select *
    from {{ ref('int_procurement_kpi') }}

    -- Filter data before any new timestamp generation to avoid duplicate inserts
    {% if is_incremental() %}
    where current_timestamp() >= (
        select coalesce(
            max(updated_date),
            to_timestamp('1900-01-01 00:00:00')
        )
        from {{ this }}
    )
    {% endif %}

),

final as (

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

        s.tat_days,
        s.tat_bucket,

        s.delivery_performance,
        s.on_time_grn,
        s.pending_delivery,

        s.final_procurement_status as procurement_status,

        -- Preserves original created_date from target table if it already exists
        {% if is_incremental() %}
            coalesce(
                (select t.created_date from {{ this }} t where t.por_id = s.por_id limit 1), 
                current_timestamp()
            ) as created_date,
        {% else %}
            current_timestamp() as created_date,
        {% endif %}

        current_timestamp() as updated_date

    from filtered_source s

)

select *
from final
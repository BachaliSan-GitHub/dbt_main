{{
    config(
       materialized='incremental',
       unique_key='purchasingdocument',
       incremental_strategy='merge',
       on_schema_change='sync_all_columns'
    )
}}

with source_data as (

    select *
    from {{ ref('int_po_grn') }}

),

final as (

    select

        s.purchasingdocument,

        s.ponumber,
        s.pornumber,

        s.vendorcode,
        s.vendorname,

        s.division,

        s.currency,

        s.podate,
        s.deliverydate,

        s.grn_date,

        s.porvalue,
        s.total_povalue,
        s.povalueinr,

        s.grn_quantity,
        s.delivered_quantity,
        s.pending_quantity,

        s.total_order_quantity,

        s.delivery_performance,

        s.on_time_grn,

        s.pending_delivery,

      
        case
            {% if is_incremental() %}
                when t.purchasingdocument is null then current_timestamp()
                else t.created_date
            {% else %}
                when 1=1 then current_timestamp()
            {% endif %}
        end as created_date,

        current_timestamp() as updated_date

    from source_data s

  
    {% if is_incremental() %}
    left join {{ this }} t
        on s.purchasingdocument = t.purchasingdocument
    {% endif %}

)

select *
from final

{% if is_incremental() %}

where coalesce(s.grn_date, s.podate) > (
    select coalesce(
        max(updated_date),
        to_timestamp('1900-01-01 00:00:00')
    )
    from {{ this }}
)
{% endif %}
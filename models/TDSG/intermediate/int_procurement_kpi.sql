{{ config(
    materialized='view'
) }}

with por_ringi as (

    select *
    from {{ ref('INT_por_ringi') }}

),

po_grn as (

    select *
    from {{ ref('int_po_grn') }}

),

final as (

    select

        pr.por_id,
        pr.por_no,
        pr.po_no,

        pr.ringino,
        pr.departmentid,
        pr.purchasinggroupid,
        pr.purchasingorgid,
        pr.ringi_createdby,

        pr.created_date,
        pr.required_date,
        pr.po_date,

        pr.ringi_submitted_date,

        pr.por_value,
        pr.por_status,
        pr.ringi_status,

        pr.tat_days,
        pr.tat_bucket,

        pg.vendorcode,
        pg.vendorname,

        pg.division,

        pg.currency,

        pg.podate,
        pg.deliverydate,

        pg.porvalue,
        pg.total_povalue,
        pg.povalueinr,

        pg.grn_quantity,
        pg.delivered_quantity,
        pg.pending_quantity,

        pg.grn_date,
        pg.expected_delivery_date,

        pg.total_order_quantity,
        pg.delivery_performance,

        pg.on_time_grn,
        pg.pending_delivery

    from por_ringi pr

    left join po_grn pg
        on pr.po_no = pg.ponumber

)

select *
from final
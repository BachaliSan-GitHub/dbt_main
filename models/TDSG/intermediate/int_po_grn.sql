{{ config(
    materialized='view'
) }}

with po as (

    select

        pornumber,
        ponumber,

        vendorcode,
        vendorname,

        division,

        porvalue,
        total_povalue,
        povalueinr,

        currency,

        podate,
        deliverydate

    from {{ ref('stg_prd_po_master') }}

),

grn as (

    select

        purchasingdocument,

        porno,

        sum(grn_quantity) as grn_quantity,

        sum(totaldeliveredquantity) as delivered_quantity,

        sum(pendingtodelivered) as pending_quantity,

        max(grndate) as grn_date,

        max(deliverydate) as expected_delivery_date

    from {{ ref('stg_GRN_DETAILS') }}

    group by

        purchasingdocument,
        porno

),

final as (

    select

        po.pornumber,
        po.ponumber,

        po.vendorcode,
        po.vendorname,

        po.division,

        po.porvalue,
        po.total_povalue,
        po.povalueinr,

        po.currency,

        po.podate,
        po.deliverydate,

        g.purchasingdocument,

        g.grn_quantity,
        g.delivered_quantity,
        g.pending_quantity,

        g.grn_date,
        g.expected_delivery_date

    from po

    left join grn g

        on try_to_number(po.ponumber)=g.purchasingdocument

)

select

    *,

   

    coalesce(grn_quantity,0)+coalesce(pending_quantity,0)
    as total_order_quantity,


    case

        when coalesce(grn_quantity,0)+coalesce(pending_quantity,0)=0

        then 0

        else round(

        (grn_quantity/

        (grn_quantity+pending_quantity))*100

        ,2)

    end

    as delivery_performance,

   

    case

        when grn_date is not null

        and expected_delivery_date is not null

        and grn_date<=expected_delivery_date

        then 1

        else 0

    end

    as on_time_grn,

 

    case

        when pending_quantity>0

        then 1

        else 0

    end

    as pending_delivery

from final
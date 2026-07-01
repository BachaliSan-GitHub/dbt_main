{{ config(materialized="view") }}

with
    por_base as (

        select
            p.por_id,
            p.por_no,
            p.po_no,
            p.departmentid,
            p.ringi_createdby,
            p.status as por_status,
            p.totalamountinr as por_value,
            p.created_date,
            p.po_date
        from {{ ref("stg_STG_PORMASTER") }} as p

    ),

    ringi_map as (

        select rmp.porid, rmp.ringiid from {{ ref("stg_RINGIPORMAP") }} as rmp

    ),

    ringi_data as (

        select r.ringikey, r.ringino, r.submitteddate as ringi_submitted_date
        from {{ ref("stg_STG_RINGIMASTER") }} as r

    ),

    po_data as (

        select po.pornumber, po.ponumber, po.vendorcode, po.vendorname, po.total_povalue
        from {{ ref("stg_prd_po_master") }} as po

    ),

    grn_data as (

        select
            g.purchasingdocument,
            sum(g.grn_quantity) as grn_quantity,
            sum(g.pendingtodelivered) as pending_qty,
            max(g.grndate) as grn_date,
            max(g.deliverydate) as delivery_date
        from {{ ref("stg_GRN_DETAILS") }} as g
        group by g.purchasingdocument

    ),
    
history_data as (

    select
        ah.formid,
        ah.formtype,
        ah.actiontakendatetime,
        ah.status
    from {{ ref('stg_STG_MANAGEHISTORYMASTER') }} ah

),


    final_join as (

        select

            p.por_id,
            p.por_no,
            p.po_no,

            r.ringino,
            r.ringi_submitted_date,

            p.departmentid,
            p.ringi_createdby,

            po.vendorcode,
            po.vendorname,

            p.por_value,
            po.total_povalue,

            p.created_date,
            p.po_date,
            
            ah.formtype,
            ah.actiontakendatetime,
            ah.status,

            g.grn_quantity,
            g.pending_qty,
            g.grn_date,
            g.delivery_date,

            p.por_status
            

        from por_base as p

        left join ringi_map as rmp on p.por_id = rmp.porid

        left join ringi_data as r on rmp.ringiid = r.ringikey
        left join history_data as ah on ah.formid = r.ringikey

        left join po_data as po on p.por_no = po.pornumber

        left join grn_data as g on TRY_TO_NUMBER(po.ponumber) = g.purchasingdocument

    )

select *
from final_join

{{ config(
    materialized='view'
) }}

with

por_base as (

    select

        por_id,
        por_no,
        po_no,
        departmentid,
        preferredvendorid,
        purchasinggroupid,
        purchasingorgid,
        plantid,
        ringi_createdby,
        ringi_created_date,
        required_date,
        po_date,
        status,
        totalamount,
        totalamountinr,
        conversionrate,
        basecurrency,
        created_date

    from {{ ref('stg_STG_PORMASTER') }}

),



ringi_map as (

    select

        porid,
        ringiid

    from {{ ref('stg_RINGIPORMAP') }}

),



ringi as (

    select

        ringikey,
        ringino,
        departmentkey,
        createdby,
        amount,
        totalamount_inr,
        conversionrate,
        status as ringi_status,
        submitteddate,
        createddate

    from {{ ref('stg_STG_RINGIMASTER') }}

),



po as (

    select

        pornumber,
        ponumber,
        vendorcode,
        vendorname,
        division,
        currency,
        exchangerate,
        total_povalue,
        povalueinr,
        podate,
        deliverydate

    from {{ ref('stg_prd_po_master') }}

),



procurement as (

    select

        p.por_id,
        p.por_no,
        p.po_no,

        rm.ringiid,

        r.ringino,
        r.ringi_status,
        r.submitteddate,

        p.departmentid,
        p.preferredvendorid,
        p.purchasinggroupid,
        p.purchasingorgid,
        p.plantid,

        p.ringi_createdby,

        po.vendorcode,
        po.vendorname,

        po.division,

        p.basecurrency,
        po.currency,

        p.totalamount,
        p.totalamountinr,

        po.total_povalue,
        po.povalueinr,

        p.conversionrate,
        po.exchangerate,

        p.required_date,
        po.podate,
        po.deliverydate,

        p.status,
        p.created_date

    from por_base p

    left join ringi_map rm
        on p.por_id = rm.porid

    left join ringi r
        on rm.ringiid = r.ringikey

    left join po
        on p.por_no = po.pornumber

)
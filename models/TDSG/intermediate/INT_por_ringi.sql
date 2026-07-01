{{ config(
    materialized='view'
) }}

with por as (

    select

        por_id,
        por_no,
        po_no,

        departmentid,
        purchasinggroupid,
        purchasingorgid,

        ringi_createdby,

        totalamountinr as por_value,

        created_date,
        required_date,
        po_date,

        status as por_status

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

        submitteddate as ringi_submitted_date,

        amount,

        totalamount_inr,

        status as ringi_status

    from {{ ref('stg_STG_RINGIMASTER') }}

),

final as (

    select

        p.por_id,
        p.por_no,
        p.po_no,

        r.ringino,

        p.departmentid,
        p.purchasinggroupid,
        p.purchasingorgid,

        p.ringi_createdby,

        p.por_value,

        p.created_date,
        p.required_date,
        p.po_date,

        r.ringi_submitted_date,

        p.por_status,
        r.ringi_status,

        r.amount,
        r.totalamount_inr

    from por p

    left join ringi_map rm

        on p.por_id = rm.porid

    left join ringi r

        on rm.ringiid = r.ringikey

)

select

    *,

    datediff(
        day,
        created_date,
        ringi_submitted_date
    ) as tat_days,

    case

        when ringi_submitted_date is null
        then 'Pending'

        when datediff(day, created_date, ringi_submitted_date) <= 5
        then '0-5 Days'

        when datediff(day, created_date, ringi_submitted_date) <= 10
        then '6-10 Days'

        when datediff(day, created_date, ringi_submitted_date) <= 15
        then '11-15 Days'

        else '>15 Days'

    end as tat_bucket

from final
{{ config(
    materialized='view'
) }}

with por_master as (

    select *
    from {{ ref('stg_STG_PORMASTER') }}

),

emp_master as (

    select *
    from {{ ref('stg_employees') }}

),

po_master as (

    select *
    from {{ ref('stg_prd_po_master') }}

),

purchaser as (

    select *
    from {{ ref('stg_PURCHASERHANDLINGDIVISION_PRD') }}

),

department as (
    select * from {{ ref('stg_department') }}
),

delivery as (

    select *
    from {{ ref('stg_GRN_DETAILS') }}

),

final as (

    select

        e.employeekey,
        e.employeename,
        e.departmentkey as employee_departmentkey,

        p.purchasername,
        p.division,
        p.department,

        d.departmentkey,
        d.departmentname,


        pr.por_id,
        pr.por_no,
        pr.status,
        pr.ringi_createdby,

        pr.ringi_submitted_date,
        pr.po_date,

        po.pornumber,
        po.porvalue,
        po.povalueinr,
        po.ponumber,


        grn.purchasingdocument,
        grn.vendorcode,
        grn.orderquantity as total_order_qt,
        grn.grn_quantity,
       grn.totaldeliveredquantity  as actual_order_qty,
        grn.pendingtodelivered,
       grn.deliverydate,
        grn.grndate,
           

        

        datediff(
            day,
            pr.ringi_submitted_date,
            pr.po_date
        ) as tat_days,

        case
            when datediff(
                day,
                pr.ringi_submitted_date,
                pr.po_date
            ) < 5
                then 'Less than 5 Days'

            when datediff(
                day,
                pr.ringi_submitted_date,
                pr.po_date
            ) between 5 and 7
                then '5-7 Days'

            else 'More than 7 Days'
        end as tat_bucket
        ,

        case
            when grn.grndate <= grn.deliverydate
            then grn.grn_quantity
            else 0
        end as on_time_grn, 

        coalesce(
                grn.orderquantity - grn.totaldeliveredquantity,
                0
            ) as pending_grn,

        
        case
    when grn.orderquantity > 0
    then round(
            (grn.totaldeliveredquantity / grn.orderquantity) * 100,
            2
         )
    else 0
end as delivery_performance_pct


    from por_master pr

    left join emp_master e
        on pr.ringi_createdby = e.employeekey

    left join department d 
       on e.departmentkey= d.departmentkey

    left join po_master po
        on po.pornumber = pr.por_no
    left join delivery grn
    on grn.purchasingdocument =po.ponumber

    left join purchaser p
        on  p.department = d.departmentname
)

select *
from final
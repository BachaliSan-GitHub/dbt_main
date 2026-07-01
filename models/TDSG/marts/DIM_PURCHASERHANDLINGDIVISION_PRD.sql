{{ config(materialized='table') }}

select

    id as purchaserkey,
    purchaserid,
    purchasername,
    division,
    department,
    fromdate,
    todate,
    startdate,
    is_active,
    quarter,
    year,
    modifieddate,
    createddate,

    current_timestamp() as lastupdateddate

from {{ ref('stg_PURCHASERHANDLINGDIVISION_PRD') }}
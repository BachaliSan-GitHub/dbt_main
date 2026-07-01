{{ config(materialized='table') }}

select

    purchasinggroupkey,
    spid,
    groupcode,
    groupname,
    activeflag,
    createddate,

    current_timestamp() as lastupdateddate

from {{ ref('stg_PRD_PURCHASING_GROUP_MASTER') }}
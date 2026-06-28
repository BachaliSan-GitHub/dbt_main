{{ config(materialized="table") }}


select

    coalesce(trim(purchasingdocument), 'UNK') as purchasingdocument,
    coalesce(item, -1) as item,
    coalesce(trim(ringino), 'UNK') as ringino,
    coalesce(trim(porno), 'UNK') as porno,
    coalesce(poramount, -1) as poramount,
    coalesce(trim(companycode), 'UNK') as companycode,
    coalesce(trim(documenttype), 'UNK') as documenttype,
    coalesce(trim(vendorcode), 'UNK') as vendorcode,
    coalesce(trim(purchasingorganization), 'UNK') as purchasingorganization,
    coalesce(trim(purchasinggroup), 'UNK') as purchasinggroup,
    coalesce(trim(paymentterm), 'UNK') as paymentterm,
    coalesce(trim(currency), 'UNK') as currency,
    coalesce(conversion, -1) as conversion,
    coalesce(trim(podocument), 'UNK') as podocument,
    coalesce(trim(materialcode), 'UNK') as materialcode,
    coalesce(orderquantity, -1) as orderquantity,
    coalesce(unitprice, -1) as unitprice,
    coalesce(trim(glaccount), 'UNK') as glaccount,
    coalesce(trim(costcenter), 'UNK') as costcenter,
    coalesce(trim(materialgroup), 'UNK') as materialgroup,
    coalesce(trim(plant), 'UNK') as plant,
    coalesce(trim(tazcode), 'UNK') as tazcode,
    coalesce(trim(hsn), 'UNK') as hsn,
    coalesce(
        trim(deliverycompletionindicators), 'UNK'
    ) as delivery_completion_indicators,
    coalesce(trim(deletionindicator), 'UNK') as deletionindicator,
    coalesce(grnquantity, -1) as grn_quantity,
    coalesce(totaldeliveredquantity, -1) as totaldeliveredquantity,
    coalesce(pendingtodelivered, -1) as pendingtodelivered,
    coalesce(freightcharges, -1) as freightcharges,

    coalesce(
        to_date(try_to_timestamp(deliverydate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as deliverydate,

    coalesce(
        to_date(try_to_timestamp(grndate, 'DD-MM-YYYY HH24:MI')), to_date('1900-01-01')
    ) as grndate,

    coalesce(
        to_date(try_to_timestamp(createddate, 'DD-MM-YYYY HH24:MI')),
        to_date('1900-01-01')
    ) as createddate

from {{ source("raw_data", "GRN_DETAILS") }}

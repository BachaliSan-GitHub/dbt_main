{{ config(materialized="table") }}


select

    coalesce(try_to_number(purchasingdocument), '-1') as purchasingdocument,
    coalesce(item, -1) as item,
    coalesce(nullif(trim(ringino), ''),'UNK') as ringino,
    coalesce(nullif(trim(porno),''), 'UNK') as porno,
    coalesce(poramount, -1) as poramount,
    coalesce(nullif(trim(companycode),''), 'UNK') as companycode,
    coalesce(nullif(trim(documenttype), ''),'UNK') as documenttype,
    coalesce(nullif(trim(vendorcode),''), 'UNK') as vendorcode,
    coalesce(nullif(trim(purchasingorganization),''), 'UNK') as purchasingorganization,
    coalesce(nullif(trim(purchasinggroup), ''),'UNK') as purchasinggroup,
    coalesce(nullif(trim(paymentterm), ''),'UNK') as paymentterm,
    coalesce(nullif(trim(currency),''), 'UNK') as currency,
    coalesce(conversion, -1) as conversion,
    coalesce(nullif(trim(materialcode),''), 'UNK') as materialcode,
    coalesce(try_to_number(orderquantity), -1) as orderquantity,
    coalesce(unitprice, -1) as unitprice,
    coalesce(nullif(trim(glaccount),''), 'UNK') as glaccount,
    coalesce(nullif(trim(costcenter),''), 'UNK') as costcenter,
    coalesce(nullif(trim(materialgroup), ''),'UNK') as materialgroup,
    coalesce(nullif(trim(plant),''), 'UNK') as plant,
    coalesce(nullif(trim(tazcode), ''),'UNK') as tazcode,
    coalesce(try_to_number(hsn), '-1') as hsn,
    coalesce(nullif(trim(deliverycompletionindicators),''),'UNK') as delivery_completion_indicators,
    coalesce(nullif(trim(deletionindicator),''),'UNK') as deletionindicator,
    coalesce(grnquantity, -1) as grn_quantity,
    coalesce(totaldeliveredquantity, -1) as totaldeliveredquantity,
    coalesce(pendingtodelivered, -1) as pendingtodelivered,
    coalesce(freightcharges, -1) as freightcharges,

coalesce(to_date(podocument,'DD-MM-YYYY'),'1900-01-01' )as podocument,
   coalesce(to_date(deliverydate,'DD-MM-YYYY'),'1900-01-01') as deliverydate,

    coalesce( to_date(grndate,'DD-MM-YYYY'), '1900-01-01')as grndate



from {{ source("raw_data", "GRN_DETAILS") }}

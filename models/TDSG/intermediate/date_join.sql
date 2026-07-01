{{ config(
    materialized = 'view'
) }}

with calendar as (

    select

        dateadd(
            day,
            seq4(),
            to_date('2024-01-01')
        ) as fulldate

    from table(generator(rowcount => 1096))

),

holiday as (

    select
        holidaydate

    from {{ ref('STG_HOLIDAYCALANDER') }}

)

select

    row_number() over(order by c.fulldate)           as datekey,

    c.fulldate                                       as fulldate,

    day(c.fulldate)                                  as day,

    month(c.fulldate)                                as month,

    quarter(c.fulldate)                              as quarter,

    year(c.fulldate)                                 as year,

    dayofweekiso(c.fulldate)                         as dayofweek,

    dayname(c.fulldate)                              as dayname,

    case
        when dayofweekiso(c.fulldate) in (6,7)
        then 'Y'
        else 'N'
    end                                              as isweekend,

    case
        when h.holidaydate is not null
        then 'Y'
        else 'N'
    end                                              as isholiday,

    case
        when dayofweekiso(c.fulldate) in (6,7)
             or h.holidaydate is not null
        then 'N'
        else 'Y'
    end                       as isworkingday


from calendar c

left join holiday h
    on c.fulldate = h.holidaydate
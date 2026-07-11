with address_table as(
    select  
        address_id,
        address, 
        address2,
        district, 
        city_id,
        postal_code,
        phone
    from {{
        ref("silver_stream_pagila_address")
    }}
), city as (
    select 
        city_id,
        city,
        country_id
    from {{
        ref("silver_stream_pagila_city")
    }}
), country as (
    select 
        country_id,
        country
    from {{
        ref("silver_stream_pagila_country")
    }}
)

select 
    a.address_id,
    a.city_id,
    co.country_id,
    {{
    dbt_utils.generate_surrogate_key([
        'a.address_id',
        'a.city_id',
        'co.country_id'
    ])
  }} as address_detail_sk,
    a.address,
    a.address2,
    a.postal_code,
    a.phone,
    c.city,
    co.country
from address_table a 
left join city c on a.city_id = c.city_id
left join country co on co.country_id = c.country_id
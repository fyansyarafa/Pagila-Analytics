with store as (
  select 
    store_id,
    manager_staff_id, 
    address_id
  from {{ ref("silver_stream_pagila_store") }}
), staff as (
  select 
    staff_id,
    first_name || ' ' || last_name as staff_full_name,
    email,
    active
  from {{ ref("silver_stream_pagila_staff") }}
), address_table as (
  select 
    address_id,
    address,
    address2,
    postal_code,
    phone,
    city,
    country,
    "__audit_dbt_refresh_date"
  from {{ ref("silver_stream_pagila_address_detail") }}
)

select 
  s.store_id,
  sf.staff_id as manager_staff_id,
  s.address_id,
  {{
    dbt_utils.generate_surrogate_key([
      's.store_id',
      'sf.staff_id',
      's.address_id'
    ])
  }} as store_profile_sk,
  sf.staff_full_name manager_name,
{{ dbt_utils.star(
    from=ref("silver_stream_pagila_address_detail"),
    except=[
      "address_id",
      "city_id",
      "country_id",
      "address_detail_sk",
      "__audit_dbt_refresh_date"
    ]
) }}
,



  now() as __audit_dbt_refresh_date
from
store s 
left join staff sf on s.manager_staff_id = sf.staff_id
left join address_table ad on ad.address_id = s.address_id
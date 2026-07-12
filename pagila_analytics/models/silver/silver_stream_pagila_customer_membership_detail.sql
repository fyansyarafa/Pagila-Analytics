with customer_membership as (
  select distinct
    customer_id,
    store_id,
    address_id,
    first_name || ' ' || last_name as full_name,
    lower(email) email,
    active
  from {{
    ref("silver_stream_pagila_customer")
  }}
), address_detail as (
  select
  {{
    dbt_utils.star(
      from=ref("silver_stream_pagila_address_detail"),
      except=[
        "city_id",
        "country_id",
        "address_detail_sk",
        "__audit_dbt_refresh_date"
      ]
  ) 
  }}
  from {{
    ref("silver_stream_pagila_address_detail")
  }}

)

select
    {{
    dbt_utils.generate_surrogate_key([
        'cm.customer_id',
        'cm.store_id'
    ])
  }} as customer_membership_sk,
cm.*,
  "ad"."address",
  "ad"."address2",
  "ad"."postal_code",
  "ad"."phone",
  "ad"."city",
  "ad"."country",
now() as __audit_dbt_refresh_date
from customer_membership cm 
left join address_detail ad 
on cm.address_id = ad.address_id



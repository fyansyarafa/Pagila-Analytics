with rental as (
  select
  rental_id,
  inventory_id,
  customer_id,
  staff_id,
  rental_date,
  return_date
  from {{
    ref("silver_stream_pagila_rental")
  }}
), customer as (
  select 
  customer_id,
  full_name customer_name, email
  from 
  {{
    ref("silver_stream_pagila_customer_membership_detail")
  }}
), inventory as(
  select 
    inventory_id,
    film_title,
    store_manager_name staff_name
  from {{
    ref("silver_stream_pagila_store_inventory")
  }}
)




select 
    {{
    dbt_utils.generate_surrogate_key([
        'r.rental_id',
        'r.customer_id'
    ])
  }} as rental_detail_sk,
  r.rental_id,
  r.inventory_id,
  r.customer_id,
  r.staff_id,
  r.rental_date,
  r.return_date,
  c.customer_name, 
  c.email customer_email,
  inv.film_title,
  inv.staff_name
from rental r 
left join customer c 
on r.customer_id = c.customer_id
left join inventory inv
on inv.inventory_id = r.inventory_id
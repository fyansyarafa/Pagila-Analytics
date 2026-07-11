with store as (
  select 
    store_id,
    manager_staff_id, 
    address_id
  from {{
    ref("silver_stream_pagila_store")
  }}
), inventory as (
  select 
    inventory_id,
    film_id, 
    store_id
  from {{
    ref("silver_stream_pagila_inventory")
  }}
), staff as (
  select 
    staff_id,
    first_name || ' ' || last_name as staff_full_name,
    email,
    active
  from {{
    ref("silver_stream_pagila_staff")
  }}
), address_table as (
  select 
    address_id,
    address,
    address2,
    postal_code,
    phone,
    city,
    country
  from {{
    ref("silver_stream_pagila_address_detail")
  }}
)

select 
  s.store_id,
  sf.staff_id as manager_staff_id,
  s.address_id,
  i.inventory_id,
  i.film_id,
  sf.staff_full_name,
  sf.active staff_active,
  sf.email staff_email,
  ad.
from
store s 
left join inventory i on s.store_id = i.store_id
left join staff sf on s.manager_staff_id = sf.staff_id
left join address_table ad on ad.address_id = s.address_id











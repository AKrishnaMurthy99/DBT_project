select
     {{ dbt_utils.generate_surrogate_key(['menu_item_id']) }}
        as menu_item_key,
 menu_item_id,
 menu_item_name,
 menu_type,
 truck_brand_name,
 item_category,
 c.brand_category,
 item_subcategory,
 sale_price_usd
from {{ ref('stg_menu') }}
left join {{ ref('truck_brand_category')}} as c
using (truck_brand_name)
with
        stg_budget as (
        select product_id,
              month,
              _row,
              expected_quantity_sold,
              real_quantity_sold,
              more_product_sold,
              price_product*expected_quantity_sold as expected_sales,
              price_product*real_quantity_sold as real_sales
        from {{ ref("int_budget") }} 
        where month = 2
    )

select *
from stg_budget
with
        stg_budget as (
        select _row, 
        product_id, 
        month,
        expected_quantity_sold,
        _fivetran_synced
        from {{ ref("int_budget") }} 
    )

select *
from stg_budget


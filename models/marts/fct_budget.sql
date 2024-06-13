with
        stg_budget as (
        select * from {{ ref("int_budget") }} 
    )

select *
from stg_budget
with categories as (
    select {{dbt_utils.generate_surrogate_key(['category_name'])}} as category_id,
            category_name,
            created_at,
            _fivetran_synced
    
    from {{ source("sql_server", "categories") }}

)

select * from categories
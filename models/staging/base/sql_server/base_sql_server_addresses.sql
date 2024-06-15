with addresses as (
    select address_id,
           zipcode,
           country,
           address,
           state,
           _fivetran_deleted,
           _fivetran_synced
    
    from {{ source("sql_server", "addresses") }}

)

select * from addresses
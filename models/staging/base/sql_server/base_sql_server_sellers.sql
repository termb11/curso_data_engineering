WITH src_seller AS (
    SELECT * 
    FROM {{ source('sql_server', 'sellers') }}
    ),

renamed_casted AS (
    SELECT  seller_id,
            DNI,
            FIRST_NAME,
            LAST_NAME,
            EMAIL,
            PHONE,
            HIRING_DATE,
            SALARY AS SALARY_USD,
            _FIVETRAN_SYNCED
    from src_seller
    )

SELECT * FROM renamed_casted
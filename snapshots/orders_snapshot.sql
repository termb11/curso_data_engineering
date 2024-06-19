{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols=['order_id'],
        )
}}

select * from {{ source('sql_server', 'orders') }}

{% endsnapshot %}
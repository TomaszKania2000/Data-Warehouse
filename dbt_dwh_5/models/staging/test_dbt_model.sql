{{
    config(
        materialized='view'
    )
}}

with w_cust as (
    select *
    from {{ source('staging', 'fahrzeug') }}
)
select *
from w_cust c
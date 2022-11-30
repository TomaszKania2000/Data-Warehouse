{{
    config(
        materialized='table'
    )
}}

with D_Ort as (
    select o.ort_id,o.ort,l.land
    from {{ source('staging', 'ort') }} as o, {{ source('staging', 'land') }} as l
    where o.land_id = l.land_id
)
select ROW_NUMBER() OVER (), *
from D_Ort
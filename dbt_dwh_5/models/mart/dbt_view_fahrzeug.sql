{{
    config(
        materialized='incremental'
    )
}}

with D_Fahrzeug as (
    select *
    from
        {{ source('staging', 'kfzzuordnung') }} as k
    inner join
        {{ source('staging', 'fahrzeug') }} as f on k.fin = f.fin
    inner join
        {{ source('staging', 'hersteller') }} as h on f.hersteller_code = h.hersteller_code

    -- filter for an incremental run to get new data
    {% if is_incremental() %}

        where f.erstellt_am > (select max(f.erstellt_am) from {{ this }})

    {% endif %}
)


select ROW_NUMBER() OVER (), *
from D_Fahrzeug
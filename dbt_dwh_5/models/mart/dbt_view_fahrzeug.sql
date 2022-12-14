{{
    config(
        materialized='incremental'
    )
}}

with D_Fahrzeug as (
    select f.fin,f.baujahr,f.modell,h.hersteller,k.kfz_kennzeichen
    from
        {{ source('staging', 'kfzzuordnung') }} as k
    inner join
        {{ source('staging', 'fahrzeug') }} as f on k.fin = f.fin
    inner join
        {{ source('staging', 'hersteller') }} as h on f.hersteller_code = h.hersteller_code

    -- filter for an incremental run to get new data
    {% if is_incremental() %}

        where f.erstellt_am > (select max(erstellt_am) from {{ source('staging', 'fahrzeug') }})

    {% endif %}
)


select ROW_NUMBER() OVER () as d_fahrzeug_key, *
from D_Fahrzeug
{{
    config(
        materialized='view'
    )
}}

with D_Messung as (
    select k.d_kunde_key,o.d_ort_key,fk.d_fahrzeug_key,m.erstellt_am as eingetroffen, m.payload ->> 'zeit' as erzeugt,
    CAST(m.payload ->> 'geschwindigkeit' as DECIMAL) as geschwindigkeit
    from {{ source('staging', 'fahrzeug') }} as f, {{ ref('dbt_view_ort') }} as o,
    {{ ref('dbt_view_kunde') }} as k, {{ source('staging', 'messung') }} as m, {{ ref('dbt_view_fahrzeug') }} as fk
    where CAST(m.payload ->> 'ort'  AS DECIMAL)= o.ort_id and m.payload ->> 'fin' LIKE f.fin and f.kunde_id = k.kunde_id and f.fin LIKE fk.fin
)
select *
from D_Messung
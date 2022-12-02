{% snapshot dbt_view_kunde %}

{{
    config(
      target_schema='staging',
      unique_key='kunde_id',

      strategy='timestamp',
      updated_at='erstellt_am',
    )
}}

with D_Kunde as (
    select k.kunde_id,k.vorname,k.nachname,k.anrede,k.geschlecht,k.geburtsdatum,o.ort,l.land,k.erstellt_am
    from {{ source('staging', 'kunde') }} as k, {{ source('staging', 'ort') }} as o,
    {{ source('staging', 'land') }} as l
    where o.land_id = l.land_id and k.wohnort = o.ort_id
)
select ROW_NUMBER() OVER () as d_kunde_key,*
from D_Kunde

{% endsnapshot %}

{% snapshot promos_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['discount','status']
    )
  }}

  SELECT * 
  FROM {{ source('tutorial', 'promos') }}

{% endsnapshot %}
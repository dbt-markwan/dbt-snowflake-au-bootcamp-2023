{% snapshot snapshot_name %}
    {{
        config(
            unique_key='player_id',
            strategy='check',
            check_cols =  ['city', 'team_name', 'country_code'],
            target_schema = 'apade_snapshots',
        )
    }}

    select * from {{ref("dim_players") }}
 {% endsnapshot %}
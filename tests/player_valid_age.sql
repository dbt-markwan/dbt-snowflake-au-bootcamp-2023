{{ 
    config(
        severity = 'warn',
        error_if = '>10'
        ) 
}}

with player as (
    select * from {{ ref('stg_player') }}
)

select 
    player_id
    , player_name
    , age
from player
where age < 18 
    OR age > 36
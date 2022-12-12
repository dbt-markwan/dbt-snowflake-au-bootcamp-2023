with player as (
    select * from {{ ref('dim_players') }}
), 
events as (
    select player_id,
    {{dbt_utils.pivot(
        'event_type_name',
        ["goal","miss","card","pass"]
    )}} 
    from {{ ref('fct_events') }}
    group by player_id
)

select player.*
       , events."goal"
       , events."miss"
       , events."card"
       , events."pass"
from player
    left join events
    on player.player_id = events.player_id
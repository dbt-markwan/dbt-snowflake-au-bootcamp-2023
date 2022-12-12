with player as (
    select * from {{ ref('dim_players') }}
),
events as (
    select
        player_id
        , sum ( case when event_type_name = 'goal' then 1 else 0 end) as goal
        , sum ( case when event_type_name = 'miss' then 1 else 0 end) as miss
        , sum ( case when event_type_name = 'card' then 1 else 0 end) as card
        , sum ( case when event_type_name = 'pass' then 1 else 0 end) as pass
     from {{ ref('fct_events') }}
     group by player_id
)

select player.*
    , events.goal
    , events.miss
    , events.card
    , events.pass
from player
    left join events
    on player.player_id = events.player_id


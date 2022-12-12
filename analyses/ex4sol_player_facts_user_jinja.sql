with player as (
    select * from {{ ref('dim_players') }}
),
events as (
    select
        player_id
        {% for fact in ['goal', 'miss', 'card', 'pass'] %}
        , sum ( case when event_type_name = '{{fact}}' then 1 else 0 end) as {{fact}}
        {% endfor %}
     from {{ ref('fct_events') }}
     group by player_id
)

select player.*
    {% for fact in ['goal', 'miss', 'card', 'pass'] %}
        , events.{{fact}}
    {% endfor %}
from player
    left join events
    on player.player_id = events.player_id
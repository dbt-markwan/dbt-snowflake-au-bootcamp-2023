with player as (
    select * from {{ ref('dim_players') }}
),
{% for fact in ["goal","miss","card","pass"] %}
{{fact}} as (
    select
        player_id
        , count(event_type_name) as fact
    from {{ ref('fct_events') }}
    where event_type_name = '{{fact}}'
    group by player_id
){% if not loop.last %},{% endif %}
{% endfor %}

select player.*
    {% for fact in ["goal","miss","card","pass"] %}
        , {{fact}}.fact as {{fact}}
    {% endfor %}
from player
    {% for fact in ["goal","miss","card","pass"] %}
        left join {{fact}}
    on player.player_id = {{fact}}.player_id
    {% endfor %}

with player as (
    select * from {{ ref('dim_players') }}
)
, event as (
    select * from {{ ref('fct_events') }}
)
, final as (

    {% set event_types = ['goal','miss','card','pass'] %}

    select
        p.player_id,
        p.player_name
        , p.team_name
/*        {% for item in event_types %}
            , sum (case when event_type_name = '{{item}}' then 1 else 0 end) as {{item}}_count
        {% endfor %}
*/
        , {{ dbt_utils.pivot(
            'event_type_name', 
            dbt_utils.get_column_values(ref('fct_events') , 'event_type_name'),
            suffix='_count',
            quote_identifiers=False
        ) }}
        , 1.0*(goal_count / nullif(miss_count + goal_count,0)) as goal_percentage
    from player as p
        left join event as e on p.player_id = e.player_id
    group by
        p.player_id
        , p.player_name, p.team_name
)
select * from final

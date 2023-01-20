with dim_players as (
    select * from {{ ref('dim_players') }}
)
, fct_events as (
    select * from {{ ref('fct_events') }}
) 
,final as (

    select 
        dim_players.player_id
        , player_name
        , weight
        , height
        , city
        , birth_date
        , affiliation_id
        , team_name
        , country_code
        -- example for one event type of interest
         , {{ dbt_utils.pivot(
            'event_type_name',
            dbt_utils.get_column_values(ref('fct_events'), 'event_type_name'),
            suffix='_count',
            quote_identifiers=False
        ) }}
    
    from dim_players
    left join fct_events on dim_players.player_id = fct_events.player_id
    group by 1,2,3,4,5,6,7,8,9
)

select * from final
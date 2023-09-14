with stg_player as (
    select * from {{ ref('stg_fifa__player') }}
)

, stg_team as (
    select * from {{ ref('stg_fifa__team') }}
)

, final as (
    select
        stg_player.*
        , stg_team.team_name
        , stg_team.country_code
    from stg_player
        left join
            stg_team
            on stg_player.affiliation_id = stg_team.affiliation_id
)

select * from final

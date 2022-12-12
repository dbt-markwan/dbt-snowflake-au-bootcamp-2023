{{
    config(
        materialized='table'
    )
}}

with player as (
    select * from {{ source('fifa', 'player') }}
)

select 
    id as player_id
    , concat(player_first_name, ' ', player_last_name) as player_name
    , datediff(year, birth_date, '2018-06-14') as age
    , player_middle_name
    , birth_date
    , weight
    , height
    , city
    , national_team_affiliation_id
    , affiliation_id
 from player
{{
    config(
        severity = 'warn',
        errorif  = '>10'

    )
}}

with player as
(
    select * from {{ref("dim_players")}}
)

select player_id,
    player_name,
    age
    from player
    where age < 18 or age > 36
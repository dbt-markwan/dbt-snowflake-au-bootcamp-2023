{{
    config(
       severity = 'warn',
       error_if = '>10' 
    )
}}

with players as (
    select * from {{ ref('dim_player') }}
)

select p.player_id, p.player_name, p.age from players p where p.age<18 or p.age>36
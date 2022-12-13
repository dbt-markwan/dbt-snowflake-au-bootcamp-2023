with players as (
    select * from {{ ref('stg_player') }}
), teams as (
    select * from {{ ref('stg_team') }}
)

select 
    p.*, 
    t.team_name
from players p
inner join teams t
    on p.affiliation_id = t.affiliation_id

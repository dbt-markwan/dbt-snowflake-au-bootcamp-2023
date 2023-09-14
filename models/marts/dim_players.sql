WITH player AS (
    SELECT * FROM {{ ref('stg_fifa__player') }}
)

, team AS (
    SELECT * FROM {{ ref('stg_fifa__team') }}
)

, final AS (
    SELECT
        player.player_id
        , player.player_name
        , player.age
        , player.birth_date
        , player.weight
        , player.height
        , player.city
        , player.national_team_affiliation_id
        , player.affiliation_id
        , team.team_name
        , team.country_code
    FROM player
        LEFT JOIN team ON player.affiliation_id = team.affiliation_id
)

SELECT * FROM final

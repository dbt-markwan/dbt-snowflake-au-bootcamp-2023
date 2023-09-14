{{
    config(
        severity = 'warn',
        error_if = '>10'
        )
}}

select * from {{ref("dim_players")}}
where age not between 18 and 36
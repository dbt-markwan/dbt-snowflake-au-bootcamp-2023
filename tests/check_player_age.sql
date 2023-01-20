{{
    config(
        warn_if = '>0'
        , error_if = '>10'
    )
}}

select * from {{ ref('dim_players') }}
where age < 19 or age > 36
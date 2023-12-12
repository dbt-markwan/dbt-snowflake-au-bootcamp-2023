{{
    config(
        materialized='table'
    )
}}

with 

source as (

    select * from {{ source('fifa', 'player') }}

),

renamed as (

    select 
    id as player_id
    , affiliation_id
    , concat(player_first_name, ' ', player_last_name) as player_name
    , weight
    , height
    , city
    , birth_date
    -- obtain age at 2018 world cup start
    , datediff(year,birth_date,'2018-06-14') as age
    from source

)

select * from renamed

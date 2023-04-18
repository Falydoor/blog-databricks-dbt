{{ 
    config(
        materialized = 'view'
    ) 
}}

SELECT
    name,
    count(*) as cnt
FROM {{ ref('pizza') }}
GROUP BY name
ORDER BY cnt DESC

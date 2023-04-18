{{ 
    config(
        materialized = 'view'
    ) 
}}

SELECT
    style,
    '$' || format_number(SUM(price), 2) AS total
FROM {{ ref('pizza') }}
GROUP BY style
ORDER BY style

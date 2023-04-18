{{ 
    config(
        materialized = 'incremental'
    ) 
}}

WITH base AS (
    SELECT
        MD5(name || date_est || style) AS id,
        name,
        TO_UTC_TIMESTAMP(TO_TIMESTAMP({{ clean_timestamp('date_est') }}, "MMM d yyyy, h:mm:ss a"), 'America/New_York') AS purchased_timestamp,
        price,
        style,
        notes,
        current_timestamp() as inserted_at
    FROM {{ source('nyc_slice_dbt', 'pizza_raw') }}
)

SELECT * FROM base
{% if is_incremental() %}
    WHERE purchased_timestamp > (SELECT MAX(purchased_timestamp) FROM {{ this }})
{% endif %}

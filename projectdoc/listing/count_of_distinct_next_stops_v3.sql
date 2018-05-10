WITH relevant_stops AS (
    SELECT unnest(:relevant_stops) AS uic_ref
)
SELECT
    DISTINCT nsm1.uic_ref,
    COUNT(nsm2.stop_name) OVER (PARTITION BY nsm1.uic_ref)
    FROM
        relevant_stops
    LEFT JOIN next_station_mapping nsm1 ON relevant_stops.uic_ref = nsm1.uic_ref
    INNER JOIN next_station_mapping nsm2 ON nsm1.trip_id = nsm2.trip_id
WHERE
    nsm1.stop_sequence = (nsm2.stop_sequence - 1)
GROUP BY
    nsm1.uic_ref, nsm2.stop_name;

WITH calendar_trip_mapping AS (
    SELECT st.departure_time, s.uic_ref
    FROM stop_times st
    INNER JOIN stops s ON st.stop_id = s.stop_id
    INNER JOIN trips t ON st.trip_id = t.trip_id
    INNER JOIN calendar_dates c ON t.service_id = c.service_id
    WHERE c.date = :date
)
SELECT uic_ref, array_agg(departure_time) AS departure_times
FROM calendar_trip_mapping
GROUP BY uic_ref
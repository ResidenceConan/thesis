CREATE OR REPLACE FUNCTION get_next_stations(uic_ref INTEGER) 
	RETURNS TABLE(stop_name text) AS $$
BEGIN
RETURN QUERY
	WITH next_station_mapping AS (
		SELECT DISTINCT s.stop_name, t.trip_id, st.stop_sequence, s.uic_ref 
			FROM stops s
				INNER JOIN stop_times st ON s.stop_id = st.stop_id
				INNER JOIN trips t ON st.trip_id = t.trip_id
				INNER JOIN routes r ON t.route_id = r.route_id
			WHERE r.route_type = 2 OR r.route_type = 1
	)
	SELECT nsm2.stop_name FROM next_station_mapping nsm1
				  INNER JOIN next_station_mapping nsm2 
				      ON nsm1.trip_id = nsm2.trip_id
				  WHERE nsm1.uic_ref = rev_uic_ref AND
				      nsm1.stop_sequence = (nsm2.stop_sequence - 1)
				      GROUP BY nsm2.stop_name;
END;
$$ LANGUAGE PLPGSQL

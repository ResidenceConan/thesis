FOR nearest_vertex IN
  WITH nearest_bboxes AS (
      SELECT id, the_geom
      FROM routing_segmented_vertices_pgr v
      -- get nearest points in approximation
      ORDER BY the_geom <#> ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 4326)
      LIMIT 100
  )
  SELECT id
  FROM nearest_bboxes
  -- order by nearest points (precise)
  ORDER BY ST_Distance(
    the_geom,
    ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 4326))
LOOP
  SELECT max(agg_cost)
  INTO max_distance
  -- Get all points reachable in 200 Meters
  FROM pgr_drivingDistance(
      'SELECT id, source, target, cost FROM edge_preselection',
      nearest_vertex,
      200,
      FALSE);

  IF max_distance >= 150
  THEN
    RETURN nearest_vertex;
  END IF;
END LOOP;
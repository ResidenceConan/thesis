  FOR nearest_vertex IN
  SELECT id
  FROM routing_segmented_vertices_pgr v
  -- Order points by distance to transport stop
  ORDER BY v.the_geom <#> ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 4326)
  LIMIT 100
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
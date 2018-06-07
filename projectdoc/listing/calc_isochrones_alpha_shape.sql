RETURN QUERY
-- only select results with at least 3 points to form a polygon
WITH relevant_bounderies AS (
    SELECT boundary
    FROM unnest(boundaries) boundary, distances d
    WHERE d.distance <= boundary
    GROUP BY boundary
    HAVING count(d.distance) >= 3
)
SELECT
boundary,
polygon_geom AS polygon
FROM relevant_bounderies,
    -- create an alpha shape with a buffer
    LATERAL st_buffer(
        pgr_pointsAsPolygon(
            'SELECT id::integer, ST_X(point)::float AS x, ST_Y(point)::float AS y '
            || 'FROM distances WHERE distance <= ' || boundary || ';',
            0.00005
        ), 0.0001) AS polygon_geom
WHERE polygon_geom IS NOT NULL;
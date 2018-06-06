CREATE TEMP TABLE edge_preselection ON COMMIT DROP AS (
SELECT
    id,
    source,
    target,
    effort AS reverse_cost, 
    -- reverse directionality to simulate walking towards the public transport stop
    reverse_effort as cost
FROM routing r
-- select edges within ~1300 meters from the start vertex
WHERE ST_intersects(ST_Buffer(start_vertex_geom, 0.013), r.geom_way)
);

CREATE TEMP TABLE distances ON COMMIT DROP AS (
SELECT
    vertices.id,
    vertices.geom_vertex AS point,
    isochron.agg_cost as distance
-- get all vertices that are reachable within the max boundary
FROM pgr_drivingDistance(
            'SELECT id, source, target, cost, reverse_cost FROM edge_preselection',
            start_vertex,
            max_boundary,
            TRUE
        ) AS isochron
    INNER JOIN vertex vertices ON isochron.node = vertices.id
);

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
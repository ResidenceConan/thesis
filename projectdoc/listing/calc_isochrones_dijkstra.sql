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
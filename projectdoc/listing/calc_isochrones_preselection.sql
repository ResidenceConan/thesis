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
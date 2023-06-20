WITH RECURSIVE commit_graph AS (
  -- Initial part, select the starting point
  SELECT
    id,
    commit_message,
    parent_commit_id
  FROM
    commits
  WHERE
    id = <starting_point_id>  -- Substitute with the starting commit id

  UNION ALL

  -- Recursive part, keep selecting the parent
  SELECT
    c.id,
    c.commit_message,
    c.parent_commit_id
  FROM
    commits c
  JOIN
    commit_graph cg
    ON c.id = cg.parent_commit_id
)
SELECT
  *
FROM
  commit_graph
WHERE
  parent_commit_id IS NULL;  -- The first commit is the one without a parent

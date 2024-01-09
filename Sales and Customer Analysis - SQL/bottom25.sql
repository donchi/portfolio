WITH Top25Percent AS (
  SELECT
    your_column,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY your_column) OVER () AS top_25_value
  FROM
    your_table
)
SELECT
  your_column
FROM
  Top25Percent
WHERE
  your_column >= top_25_value;

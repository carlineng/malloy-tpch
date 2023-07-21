create or replace table not_equals_results as
with lineitem as (
  select * from '../data/lineitem.parquet'
)
select * from (
SELECT
  l1.l_orderkey as l1_orderkey
  , l1.l_suppkey as l1_suppkey
  , l2.l_orderkey as l2_orderkey
  , l2.l_suppkey as l2_suppkey
FROM lineitem l1
LEFT JOIN lineitem l2
ON l1.l_orderkey = l2.l_orderkey
AND (l1.l_suppkey != l2.l_suppkey)
);

-- This query shows lots of results:
select * from not_equals_results 
where l1_suppkey != l2_suppkey
limit 100
;

create or replace table distinct_from_results as
with lineitem as (
  select * from '../data/lineitem.parquet'
)
select * from (
SELECT
  l1.l_orderkey as l1_orderkey
  , l1.l_suppkey as l1_suppkey
  , l2.l_orderkey as l2_orderkey
  , l2.l_suppkey as l2_suppkey
FROM lineitem l1
LEFT JOIN lineitem l2
ON l1.l_orderkey = l2.l_orderkey
AND (l1.l_suppkey IS DISTINCT FROM l2.l_suppkey)
);

-- This query shows no results:
select * from distinct_from_results
where l1_suppkey IS DISTINCT FROM l2_suppkey
;

-- For my dataset, I believe these should be identical.
-- What am I missing?

create or replace table equals_results as
with lineitem as (
  select * from '../data/lineitem.parquet'
)
select * from (
SELECT
  l1.l_orderkey as l1_orderkey
  , l1.l_suppkey as l1_suppkey
  , l2.l_orderkey as l2_orderkey
  , l2.l_suppkey as l2_suppkey
FROM lineitem l1
LEFT JOIN lineitem l2
ON l1.l_orderkey = l2.l_orderkey
AND l1.l_suppkey = l2.l_suppkey
);

-- It looks like the "equals" join and the "distinct from" join produce
-- the same table! That doesn't make sense to me...
with combined as (
  select * from equals_results
  union all
  select * from distinct_from_results
), row_counts as (
  SELECT
    l1_orderkey
    , l1_suppkey
    , l2_orderkey
    , l2_suppkey
    , COUNT(*) AS nrows
  FROM combined
  GROUP BY 1,2,3,4
)
SELECT 
  nrows
  , COUNT(*) 
FROM row_counts
GROUP BY 1
;
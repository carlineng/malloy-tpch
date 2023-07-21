-- This query generates a hash join:
EXPLAIN
with lineitem as (
  select * from '../data/lineitem.parquet'
)
select count(*) from (
SELECT
  l1.l_orderkey as l1_orderkey
  , l1.l_suppkey as l1_suppkey
  , l2.l_orderkey as l2_orderkey
  , l2.l_suppkey as l2_suppkey
FROM lineitem l1
LEFT JOIN lineitem l2
ON l1.l_orderkey = l2.l_orderkey
AND l1.l_suppkey != l2.l_suppkey
);

-- This query generates a nested-loop join:
EXPLAIN
with lineitem as (
  select * from '../data/lineitem.parquet'
)
select count(*) from (
SELECT
  l1.l_orderkey as l1_orderkey
  , l1.l_suppkey as l1_suppkey
  , l2.l_orderkey as l2_orderkey
  , l2.l_suppkey as l2_suppkey
FROM lineitem l1
LEFT JOIN lineitem l2
ON l1.l_orderkey = l2.l_orderkey
AND COALESCE(l1.l_suppkey != l2.l_suppkey, false)
);

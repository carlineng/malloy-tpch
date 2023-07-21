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

select * from distinct_from_results
where l1_suppkey IS DISTINCT FROM l2_suppkey
;

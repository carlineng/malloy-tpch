CALL dbgen(sf=1)

COPY (SELECT * FROM customer) TO './data/customer.parquet';
COPY (SELECT * FROM lineitem) TO './data/lineitem.parquet';
COPY (SELECT * FROM nation) TO './data/nation.parquet';
COPY (SELECT * FROM orders) TO './data/orders.parquet';
COPY (SELECT * FROM part) TO './data/part.parquet';
COPY (SELECT * FROM partsupp) TO './data/partsupp.parquet';
COPY (SELECT * FROM region) TO './data/region.parquet';
COPY (SELECT * FROM supplier) TO './data/supplier.parquet';

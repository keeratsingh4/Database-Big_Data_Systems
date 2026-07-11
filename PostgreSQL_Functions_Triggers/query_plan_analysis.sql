-- Create index statement
CREATE INDEX ordersIdx ON ORDERS (o_custkey, o_clerk, o_orderdate);

-- Task (i): SELECT statement that must traverse the index vertically and access the ORDERS table
EXPLAIN ANALYZE
SELECT o_custkey, o_orderstatus 
FROM ORDERS 
WHERE o_custkey = 12345;

-- Task (ii): SELECT statement that must traverse the index vertically and NOT access the ORDERS table
EXPLAIN ANALYZE
SELECT o_custkey 
FROM ORDERS 
WHERE o_custkey = 12345;

-- Task (iii): SELECT statement that must traverse the index vertically, then horizontally at leaf level, and access ORDERS
EXPLAIN ANALYZE
SELECT * 
FROM ORDERS 
WHERE o_custkey BETWEEN 1000 AND 1010;

-- Task (iv): SELECT statement that must traverse the index vertically, then horizontally at leaf level, and NOT access ORDERS
EXPLAIN ANALYZE
SELECT o_custkey, o_orderdate 
FROM ORDERS 
WHERE o_custkey BETWEEN 1000 AND 1010;

-- Task (v): SELECT statement that must traverse horizontally at leaf level and access ORDERS
EXPLAIN ANALYZE
SELECT * 
FROM ORDERS 
ORDER BY o_orderdate 
LIMIT 10;

-- Task (vi): SELECT statement that must traverse horizontally at leaf level and NOT access ORDERS
EXPLAIN ANALYZE
SELECT o_orderdate 
FROM ORDERS 
ORDER BY o_orderdate 
LIMIT 10;

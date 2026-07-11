USE default;

-- 1) PART
CREATE EXTERNAL TABLE IF NOT EXISTS part (
  P_PARTKEY     INT,
  P_NAME        STRING,
  P_MFGR        STRING,
  P_BRAND       STRING,
  P_TYPE        STRING,
  P_SIZE        INT,
  P_CONTAINER   STRING,
  P_RETAILPRICE DOUBLE,
  P_COMMENT     STRING
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/bigdata/task4/part'
TBLPROPERTIES ("skip.header.line.count"="1")
;

-- 2) SUPPLIER
CREATE EXTERNAL TABLE IF NOT EXISTS supplier (
  S_SUPPKEY  INT,
  S_NAME     STRING,
  S_ADDRESS  STRING,
  S_PHONE    STRING,
  S_ACCTBAL  DOUBLE,
  S_COMMENT  STRING
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/bigdata/task4/supplier'
TBLPROPERTIES ("skip.header.line.count"="1")
;

-- 3) PARTSUPP
CREATE EXTERNAL TABLE IF NOT EXISTS partsupp (
  PS_PARTKEY     INT,
  PS_SUPPKEY     INT,
  PS_AVAILQTY    INT,
  PS_SUPPLYCOST  DOUBLE,
  PS_COMMENT     STRING
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/bigdata/task4/partsupp'
TBLPROPERTIES ("skip.header.line.count"="1")
;

-- ----------------------------------------------------------------

-- PART
SELECT 'PART: 5 sample rows' AS info, * FROM part LIMIT 5;
SELECT 'PART total rows'    AS info, COUNT(*) FROM part;

-- SUPPLIER
SELECT 'SUPPLIER: 5 sample rows' AS info, * FROM supplier LIMIT 5;
SELECT 'SUPPLIER total rows'      AS info, COUNT(*) FROM supplier;

-- PARTSUPP
SELECT 'PARTSUPP: 5 sample rows' AS info, * FROM partsupp LIMIT 5;
SELECT 'PARTSUPP total rows'      AS info, COUNT(*) FROM partsupp;

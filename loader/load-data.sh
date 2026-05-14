#!/bin/bash
set -e

export NLS_LANG=.AL32UTF8

CONNECTION="${TELCO_CONNECTION:-TELCO/Telco12345@//localhost:1521/XEPDB1}"

sqlldr userid="$CONNECTION" control=/workspace/loader/tariffs.ctl log=/tmp/tariffs.log bad=/tmp/tariffs.bad
sqlldr userid="$CONNECTION" control=/workspace/loader/customers.ctl log=/tmp/customers.log bad=/tmp/customers.bad
sqlldr userid="$CONNECTION" control=/workspace/loader/monthly_stats.ctl log=/tmp/monthly_stats.log bad=/tmp/monthly_stats.bad

sqlplus -s "$CONNECTION" <<'SQL'
SET PAGESIZE 100
SET LINESIZE 120

SELECT 'TARIFFS' AS table_name, COUNT(*) AS row_count FROM tariffs
UNION ALL
SELECT 'CUSTOMERS' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'MONTHLY_STATS' AS table_name, COUNT(*) AS row_count FROM monthly_stats;

EXIT
SQL

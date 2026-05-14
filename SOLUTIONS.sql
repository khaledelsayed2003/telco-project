/*1.1 Approach:
This query joins CUSTOMERS to TARIFFS so the filter can use the tariff name instead of hard-coding tariff_id 
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   c.signup_date,
   t.name AS tariff_name
FROM customers c
JOIN tariffs t
   ON t.tariff_id = c.tariff_id
WHERE t.name = 'Kobiye Destek'
ORDER BY c.customer_id;

/*
1.2 Approach:
This query first limits the customer set to the Kobiye Destek tariff and then compares each signup date to the latest signup date for that same tariff.
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   c.signup_date,
   t.name AS tariff_name
FROM customers c
JOIN tariffs t
   ON t.tariff_id = c.tariff_id
WHERE t.name = 'Kobiye Destek'
  AND c.signup_date = (
      SELECT MAX(c2.signup_date)
      FROM customers c2
      JOIN tariffs t2
         ON t2.tariff_id = c2.tariff_id
      WHERE t2.name = 'Kobiye Destek'
  )
ORDER BY c.customer_id;

/*
2.1 Approach:
This query groups customers by their tariff so the count for each package can be calculated.
*/
SELECT
   t.tariff_id,
   t.name AS tariff_name,
   COUNT(c.customer_id) AS customer_count,
   ROUND(COUNT(c.customer_id) * 100 / SUM(COUNT(c.customer_id)) OVER (), 2) AS customer_percentage
FROM tariffs t
LEFT JOIN customers c
   ON c.tariff_id = t.tariff_id
GROUP BY
   t.tariff_id,
   t.name
ORDER BY t.tariff_id;

/*
3.1 Approach:
This query finds the earliest signup date with MIN(signup_date) and then returns all customers who match that date.
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   c.signup_date,
   c.tariff_id
FROM customers c
WHERE c.signup_date = (
   SELECT MIN(signup_date)
   FROM customers
)
ORDER BY c.customer_id;

/*
3.2 Approach:
This query reuses the earliest-customer logic in a common table expression so the date rule is written once.
*/
WITH earliest_customers AS (
   SELECT
      customer_id,
      city
   FROM customers
   WHERE signup_date = (
      SELECT MIN(signup_date)
      FROM customers
   )
)
SELECT
   city,
   COUNT(*) AS customer_count
FROM earliest_customers
GROUP BY city
ORDER BY city;

/*
4.1 Approach:
This query uses CUSTOMERS as the complete list of expected monthly records and LEFT JOINs to MONTHLY_STATS.
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   c.signup_date,
   c.tariff_id
FROM customers c
LEFT JOIN monthly_stats ms
   ON ms.customer_id = c.customer_id
WHERE ms.customer_id IS NULL
ORDER BY c.customer_id;

/*
4.2 Approach:
This query uses the same missing-record LEFT JOIN pattern from question 4.
*/
SELECT
   c.city,
   COUNT(*) AS missing_customer_count
FROM customers c
LEFT JOIN monthly_stats ms
   ON ms.customer_id = c.customer_id
WHERE ms.customer_id IS NULL
GROUP BY c.city
ORDER BY c.city;

/*
5.1 Approach:
This query joins customers, tariffs, and monthly stats because the usage value and the package data limit live in different tables.
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   t.name AS tariff_name,
   ms.data_usage,
   t.data_limit,
   ROUND(ms.data_usage / t.data_limit * 100, 2) AS data_usage_percentage
FROM customers c
JOIN tariffs t
   ON t.tariff_id = c.tariff_id
JOIN monthly_stats ms
   ON ms.customer_id = c.customer_id
WHERE t.data_limit > 0
  AND ms.data_usage >= t.data_limit * 0.75
ORDER BY c.customer_id;

/*
5.2 Approach:
This query checks data, minute, and SMS usage against the matching limits from the customer's tariff.
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   t.name AS tariff_name,
   ms.data_usage,
   t.data_limit,
   ms.minute_usage,
   t.minute_limit,
   ms.sms_usage,
   t.sms_limit
FROM customers c
JOIN tariffs t
   ON t.tariff_id = c.tariff_id
JOIN monthly_stats ms
   ON ms.customer_id = c.customer_id
WHERE t.data_limit > 0
  AND t.minute_limit > 0
  AND t.sms_limit > 0
  AND ms.data_usage >= t.data_limit
  AND ms.minute_usage >= t.minute_limit
  AND ms.sms_usage >= t.sms_limit
ORDER BY c.customer_id;

/*
6.1 Approach:
This query joins MONTHLY_STATS to CUSTOMERS and TARIFFS so unpaid accounts can be shown with customer and tariff context.
*/
SELECT
   c.customer_id,
   c.name,
   c.city,
   t.name AS tariff_name,
   ms.payment_status
FROM customers c
JOIN tariffs t
   ON t.tariff_id = c.tariff_id
JOIN monthly_stats ms
   ON ms.customer_id = c.customer_id
WHERE ms.payment_status = 'UNPAID'
ORDER BY c.customer_id;

/*
6.2 Approach:
This query groups the monthly records by tariff and payment status to show how statuses are distributed across packages.
*/
SELECT
   t.tariff_id,
   t.name AS tariff_name,
   ms.payment_status,
   COUNT(*) AS customer_count
FROM monthly_stats ms
JOIN customers c
   ON c.customer_id = ms.customer_id
JOIN tariffs t
   ON t.tariff_id = c.tariff_id
GROUP BY
   t.tariff_id,
   t.name,
   ms.payment_status
ORDER BY
   t.tariff_id,
   ms.payment_status;

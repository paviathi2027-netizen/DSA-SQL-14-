# PostgreSQL
WITH call_records AS (SELECT 
count(case_id) FILTER(WHERE call_category ='n/a' OR call_category IS NULL ) as uncategorised_calls,
count(case_id) as total_calls
FROM callers)

SELECT 
Round(100.0 * uncategorised_calls / total_calls, 1) AS unlabeled_calls
FROM call_records;

# OR

WITH uncategorised_callers AS (
  SELECT COUNT(case_id) AS uncategorised_calls
  FROM callers
  WHERE call_category IS NULL
    OR call_category = 'n/a'
)

SELECT 
  ROUND(100.0 * uncategorised_calls 
    / (SELECT COUNT(*) FROM callers), 1) AS uncategorised_call_pct
FROM uncategorised_callers;


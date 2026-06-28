-- Problem: Finding Updated Records
-- Source: StrataScratch ID 10299
-- Difficulty: Easy
-- Date: June 2026

-- ===========================================
-- MY SOLUTION (correct but over-engineered)
-- Using ROW_NUMBER window function
-- ===========================================

WITH employee_ranked AS (
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY id 
            ORDER BY salary DESC
        ) AS row_num
    FROM ms_employee_salary
)
SELECT 
    id,
    first_name,
    last_name,
    department_id,
    salary
FROM employee_ranked
WHERE row_num = 1
ORDER BY id ASC

-- Works correctly but window function
-- is more than needed for this problem

-- ===========================================
-- SIMPLER BETTER SOLUTION
-- GROUP BY + MAX handles this directly
-- ===========================================

SELECT 
    id,
    first_name,
    last_name,
    department_id,
    MAX(salary) AS salary
FROM ms_employee_salary
GROUP BY 
    id,
    first_name,
    last_name,
    department_id
ORDER BY id ASC

-- ===========================================
-- ROW_NUMBER vs RANK vs DENSE_RANK
-- ===========================================

-- ROW_NUMBER: unique number every row
--             even if values tied
--             use when: want exactly one row

-- RANK:       same rank for ties
--             skips next rank number
--             use when: ties should share rank

-- DENSE_RANK: same rank for ties
--             no skipping rank numbers
--             use when: continuous ranking needed

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. Always check if simple GROUP BY
--    solves it before using window functions
--    Simpler = better in SQL

-- 2. Never name CTE same as source table
--    causes confusion and potential errors

-- 3. ROW_NUMBER good for deduplication
--    but MAX() more direct for "get highest"

-- 4. Always check ORDER BY requirement
--    in question before submitting

-- 5. Window function knowledge shows depth
--    but knowing WHEN NOT to use them
--    shows maturity

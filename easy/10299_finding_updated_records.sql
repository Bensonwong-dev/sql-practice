-- Problem: Finding Updated Records
-- Source: StrataScratch ID 10299
-- Difficulty: Easy
-- Date: June 2026

-- ===========================================
-- CORRECT SOLUTION
-- ROW_NUMBER window function
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

-- ===========================================
-- WHY NOT GROUP BY + MAX
-- ===========================================

-- Initial assumption was GROUP BY + MAX was simpler:
-- SELECT id, first_name, last_name, department_id, MAX(salary)
-- FROM ms_employee_salary
-- GROUP BY id, first_name, last_name, department_id

-- This is WRONG for this dataset. Grain analysis revealed:
-- id alone        → NOT unique (same employee, multiple salaries)
-- id + salary     → unique
-- id + dept_id    → NOT unique (same employee, multiple departments)
-- Grain = one row per employee per department per salary

-- Because department_id varies per employee, including it
-- in GROUP BY creates more rows instead of collapsing them.
-- GROUP BY has no safe way to pick one department_id per employee.
-- ROW_NUMBER() is the only clean solution here.

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

-- 1. Always check grain before choosing GROUP BY vs window function
--    Run COUNT(*) > 1 checks on key column combinations:
--    → id unique?            SELECT id, COUNT(*) GROUP BY id HAVING COUNT(*) > 1
--    → id + dept unique?     SELECT id, department_id, COUNT(*) ... HAVING COUNT(*) > 1
--    → id + salary unique?   SELECT id, salary, COUNT(*) ... HAVING COUNT(*) > 1

-- 2. GROUP BY + MAX only works when all selected columns
--    are functionally dependent on the GROUP BY key.
--    If any column varies per key (like dept_id here), GROUP BY breaks.

-- 3. ROW_NUMBER() partitioned by id is the safe choice
--    when grain is ambiguous or columns vary per employee.

-- 4. Never name CTE same as source table
--    causes confusion and potential errors

-- 5. Always check ORDER BY requirement
--    in question before submitting

-- 6. Window function knowledge shows depth
--    but knowing WHEN to use them shows maturity
--    — not always about avoiding them

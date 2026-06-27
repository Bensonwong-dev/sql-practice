## Problem: Highest Salary Difference Between Departments
-- Source: StrataScratch
-- Difficulty: Easy
-- Date: June 2026

-- ===========================================
-- MY FIRST ATTEMPT (wrong interpretation)
-- I thought: highest minus lowest 
-- within EACH department
-- ===========================================

SELECT 
    de.department,
    MAX(em.salary) - MIN(em.salary) 
        AS salary_difference
FROM db_employee em
JOIN db_dept de
    ON em.department_id = de.id
WHERE de.department 
    IN ('marketing','engineering')
GROUP BY de.department

-- This returns 2 rows (one per department)
-- Not what question asked
-- BUT valid query for different business question

-- ===========================================
-- CORRECT SOLUTION
-- Question asks: highest marketing salary
-- MINUS highest engineering salary
-- Output: single absolute number
-- ===========================================

SELECT ABS(
    MAX(CASE WHEN de.department = 'marketing' 
        THEN em.salary END) -
    MAX(CASE WHEN de.department = 'engineering' 
        THEN em.salary END)
) AS salary_difference
FROM db_employee em
JOIN db_dept de
    ON em.department_id = de.id
WHERE de.department 
    IN ('marketing','engineering')

-- ===========================================
-- CLEANER VERSION USING CTE
-- Easier to read and maintain
-- ===========================================

WITH dept_max AS (
    SELECT 
        de.department,
        MAX(em.salary) AS max_salary
    FROM db_employee em
    JOIN db_dept de
        ON em.department_id = de.id
    WHERE de.department 
        IN ('marketing','engineering')
    GROUP BY de.department
)
SELECT ABS(
    MAX(CASE WHEN department = 'marketing' 
        THEN max_salary END) -
    MAX(CASE WHEN department = 'engineering' 
        THEN max_salary END)
) AS salary_difference
FROM dept_max

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. Read expected output FIRST before coding
--    "just the difference" = one row only
--    "absolute difference" = wrap in ABS()

-- 2. Two completely different questions
--    look similar in wording:
--    A) Max minus min WITHIN each dept = GROUP BY
--    B) Max of dept A vs Max of dept B = CASE WHEN

-- 3. IN() cleaner than multiple OR conditions
--    WHERE dept IN ('a','b')
--    better than WHERE dept='a' OR dept='b'

-- 4. ABS() ensures always positive result
--    regardless of which dept has higher salary

-- 5. CTEs make complex logic readable
--    break problem into steps
--    easier to debug and maintain

-- 6. Misreading questions happens to everyone
--    Always ask: how many rows should output have?
--    That single question prevents most mistakes

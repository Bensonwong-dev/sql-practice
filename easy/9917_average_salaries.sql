-- Problem: Average Salaries
-- Source: StrataScratch ID 9917
-- Difficulty: Easy
-- Date: June 2026

-- ===========================================
-- MY SOLUTION (correct, CTE not required)
-- ===========================================

with average_salary as(
    select
    department,
    first_name,
    salary,
    avg(salary) over(partition by department) as avg_salary
    from employee e
)
select * from average_salary

-- ===========================================
-- SIMPLER EQUIVALENT — no CTE needed
-- ===========================================

select
    department,
    first_name,
    salary,
    avg(salary) over(partition by department) as avg_salary
from employee

-- CTE only earns its place when filtering on the
-- windowed column afterward (e.g. WHERE rnum = 1
-- pattern). Here we're just displaying avg_salary,
-- no filtering step, so the CTE is unnecessary.

-- ===========================================
-- WHAT I LEARNED
-- ===========================================

-- 1. This is the case where an "extra column" from
--    a window function is NOT overhead — it is the
--    deliverable. Problem asks for row-level detail
--    (first_name, salary) AND group-level stat
--    (avg_salary) in the same output.

-- 2. AVG() OVER(PARTITION BY department) keeps every
--    row, unlike GROUP BY which collapses rows down
--    to one per department. Window function is the
--    only tool that gives both row detail and group
--    aggregate together without a self-join.

-- 3. Confirms the rule from the previous problem:
--    filtering on a VALUE/POSITION → CTE earns its
--    column. Just DISPLAYING a group stat alongside
--    row detail → window function directly, CTE
--    optional/unnecessary.

-- Step 1: Create the table
CREATE TABLE Employee (
    Id INT,
    Month INT,
    Salary INT
);

-- Step 2: Insert the data
INSERT INTO Employee (Id, Month, Salary) VALUES
(1, 1, 20),
(2, 1, 20),
(1, 2, 30),
(2, 2, 30),
(3, 2, 40),
(1, 3, 40),
(3, 3, 60),
(1, 4, 60),
(3, 4, 70);

WITH running_total_cte as (
    SELECT 
        *
        ,SUM(Salary) OVER w as running_total
    FROM `Employee`
    WINDOW w as (PARTITION BY `Id` ORDER BY `Month` RANGE BETWEEN UNBOUNDED PRECEDING and CURRENT ROW)
),

rank_cte as(
    SELECT 
        *
        ,RANK() OVER(PARTITION BY `Id` ORDER BY running_total DESC) as rnk
    FROM running_total_cte
)
SELECT `Id`,`Month`,running_total as `Salary` FROM rank_cte
WHERE rnk !=1 and rnk<=4
ORDER BY `Id`,`Month` DESC
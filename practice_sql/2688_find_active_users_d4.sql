-- Create the table
CREATE TABLE Users (
    user_id INT,
    item VARCHAR(50),
    created_at DATE,
    amount INT
);

-- Insert data
INSERT INTO Users (user_id, item, created_at, amount) VALUES
(5, 'Smart Crock Pot', '2021-09-18', 698882),
(6, 'Smart Lock', '2021-09-14', 11487),
(6, 'Smart Thermostat', '2021-09-10', 674762),
(8, 'Smart Light Strip', '2021-09-29', 630773),
(4, 'Smart Cat Feeder', '2021-09-02', 693545),
(4, 'Smart Bed', '2021-09-13', 170249);


with cte as(
    SELECT
        *
        ,LEAD(created_at) OVER(PARTITION BY user_id ORDER BY created_at) as next_purchase_date
    FROM Users
)
SELECT DISTINCT user_id FROM cte
WHERE DATEDIFF(next_purchase_date,created_at)<=7

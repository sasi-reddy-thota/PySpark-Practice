CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    day DATETIME,
    amount INT
);

INSERT INTO Transactions (transaction_id, day, amount) VALUES
(8, '2021-04-03 15:57:28', 57),
(9, '2021-04-28 08:47:25', 21),
(1, '2021-04-29 13:28:30', 58),
(5, '2021-04-28 16:39:59', 40),
(6, '2021-04-29 23:39:28', 58);



WITH cte as(
    SELECT 
        *
        ,rank() OVER(PARTITION BY date(`day`) ORDER BY amount DESC) as rnk
    FROM Transactions
)
SELECT transaction_id from cte
WHERE rnk=1
ORDER BY transaction_id

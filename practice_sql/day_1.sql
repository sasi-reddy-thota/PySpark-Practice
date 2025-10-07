
/*

3140. Consecutive Available Seats II

Medium

---

Description

A cinema hall has a row of seats, each of which may be available or booked. You are given a table `Cinema`:

| Column  | Type    |
| ------- | ------- |
| seat_id | int     |
| free    | boolean |

 `seat_id` is an auto-increment column representing the seat number.
 `free = 1` (`True`) indicates the seat is available.
 `free = 0` (`False`) indicates the seat is booked.

Write a query (or program) to find the consecutive available seats. Return the starting seat ID, ending seat ID, and length of the consecutive sequence.

If there are multiple sequences with the same length, include all of them.

Return the result ordered by `first_seat_id` in ascending order.

---

## Example

Input Table: `Cinema`

| seat_id | free |
| ------- | ---- |
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
| 6       | 0    |
| 7       | 1    |
| 8       | 1    |

Output

| first_seat_id | last_seat_id | consecutive_seats_len |
| ------------- | ------------ | --------------------- |
| 3             | 5            | 3                     |
| 7             | 8            | 2                     |

---
*/


-- Table creation
CREATE TABLE Cinema (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    free BOOLEAN
);

INSERT INTO Cinema (free) VALUES
(1), (0), (1), (1), (1), (0), (1), (1);


-- Query starts here
with grp_cte as(
    SELECT 
        seat_id
        ,seat_id-ROW_NUMBER() over(ORDER BY seat_id) as grp
    FROM `Cinema`
    where free=1 
)
SELECT 
    min(seat_id) as first_seat_id
    ,max(seat_id) as last_seat_id
    ,count(*) as consecutive_seats_len
FROM grp_cte
GROUP BY grp
ORDER BY consecutive_seats_len DESC






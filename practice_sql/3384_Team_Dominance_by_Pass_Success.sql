-- Create Teams table
CREATE TABLE Teams (
    player_id INT,
    team_name VARCHAR(50)
);

-- Insert sample data into Teams
INSERT INTO Teams (player_id, team_name) VALUES
(1, 'Arsenal'),
(2, 'Arsenal'),
(3, 'Arsenal'),
(4, 'Chelsea'),
(5, 'Chelsea'),
(6, 'Chelsea');

-- Create Passes table
CREATE TABLE Passes (
    pass_from INT,
    time_stamp TIME,
    pass_to INT
);

-- Insert sample data into Passes
INSERT INTO Passes (pass_from, time_stamp, pass_to) VALUES
(1, '00:15:00', 2),
(2, '00:45:00', 3),
(3, '01:15:00', 1),
(4, '00:30:00', 1),
(2, '46:00:00', 3),
(3, '46:15:00', 4),
(1, '46:45:00', 2),
(5, '46:30:00', 6);

WITH CTE as(
    SELECT
        tm1.team_name AS team_pass_from
        ,tm2.team_name AS team_pass_to
        ,CASE 
            WHEN time_stamp between '00:00:00' AND '45:00:00' THEN 1
            ELSE  2
        END As half_number
        ,CASE 
            WHEN tm1.team_name=tm2.team_name THEN  1
            ELSE  -1
        END AS grace_score
    FROM `Passes` AS ps 
    JOIN `Teams` AS tm1
    ON ps.pass_from=tm1.player_id
    JOIN `Teams` AS tm2
    ON ps.pass_to=tm2.player_id
)
SELECT 
    team_pass_from as team_name
    ,half_number
    ,SUM(grace_score) as dominance
FROM cte
GROUP BY team_pass_from,half_number
ORDER BY team_name,half_number

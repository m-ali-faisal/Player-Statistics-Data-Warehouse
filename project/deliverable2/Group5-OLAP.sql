-- Total Goals by League
SELECT 
    l.league_name,
    SUM(f.goals) AS total_goals
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name
ORDER BY total_goals DESC;


--Top 5 Clubs with Highest Average Goals per Player in 2024 Season
SELECT 
    c.club_name,
    ROUND(AVG(f.goals), 2) AS avg_goals_per_player
FROM players_dw.fact2 f
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_season s ON f.season_key = s.dim_season_id
WHERE s.start_year = 2024
GROUP BY c.club_name
ORDER BY avg_goals_per_player DESC
LIMIT 5;



-- Top 10 Players by Total goals
SELECT 
    p.player_name,
    c.club_name,
    (f.goals) AS goal_contributions
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
ORDER BY goal_contributions DESC
LIMIT 10;




--Average Minutes Played per League
SELECT 
    l.league_name,
    ROUND(AVG(f.minutes_played), 2) AS avg_minutes
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name
ORDER BY avg_minutes DESC;



-- top five players with highest expected goal contributions

SELECT 
    p.player_name,
    c.club_name,
    ROUND(SUM(f.npxg_plus_xag), 2) AS total_xg_xag
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
GROUP BY p.player_name, c.club_name
ORDER BY total_xg_xag DESC
LIMIT 5;


-- defensive stats per league

SELECT 
    l.league_name,
    ROUND(SUM(f.tackles + f.interceptions + f.blocks), 0) AS total_def_actions
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name
ORDER BY total_def_actions DESC;




-- Top 10 Players with the Most Penalties Scored
SELECT 
    p.player_name,
    c.club_name,
    f.penalties
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
ORDER BY f.penalties DESC
LIMIT 10;


--Top 10 Players with the Most Dribbles
SELECT 
    p.player_name,
    c.club_name,
    f.progressive_carries
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
ORDER BY f.progressive_carries DESC
LIMIT 10;








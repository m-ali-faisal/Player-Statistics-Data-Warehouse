
-- Total Goals by League 

CREATE TABLE players_dw.molap_goals_by_league AS
SELECT 
    l.league_name,
    SUM(f.goals) AS total_goals
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name;


SELECT * FROM players_dw.molap_goals_by_league ORDER BY total_goals DESC;


-- Top 5 Clubs with Highest Average Goals


CREATE TABLE players_dw.molap_avg_goals_per_club_2024 AS
SELECT 
    c.club_name,
    ROUND(AVG(f.goals), 2) AS avg_goals_per_player
FROM players_dw.fact2 f
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_season s ON f.season_key = s.dim_season_id
WHERE s.start_year = 2024
GROUP BY c.club_name;


SELECT * 
FROM players_dw.molap_avg_goals_per_club_2024 
ORDER BY avg_goals_per_player DESC 
LIMIT 5;



-- Top 10 Players by Total Goals

CREATE TABLE players_dw.molap_top_goal_scorers AS
SELECT 
    p.player_name,
    c.club_name,
    f.goals AS total_goals
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id;


SELECT * FROM players_dw.molap_top_goal_scorers ORDER BY total_goals DESC LIMIT 10;

-- Average Minutes Played per League

CREATE TABLE players_dw.molap_avg_minutes_per_league AS
SELECT 
    l.league_name,
    ROUND(AVG(f.minutes_played), 2) AS avg_minutes
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name;

SELECT * FROM players_dw.molap_avg_minutes_per_league ORDER BY avg_minutes DESC;



--Top Players by Total expected goal contributions

CREATE TABLE players_dw.molap_top_xg_xag_players AS
SELECT 
    p.player_name,
    c.club_name,
    ROUND(SUM(f.npxg_plus_xag), 2) AS total_xg_xag
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
GROUP BY p.player_name, c.club_name;


SELECT * FROM players_dw.molap_top_xg_xag_players ORDER BY total_xg_xag DESC LIMIT 5;


-- defensive actions

CREATE TABLE players_dw.molap_defensive_stats_per_league AS
SELECT 
    l.league_name,
    ROUND(SUM(f.tackles + f.interceptions + f.blocks), 0) AS total_def_actions
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name;


SELECT * FROM players_dw.molap_defensive_stats_per_league ORDER BY total_def_actions DESC;



-- Top 10 Players with Most Penalties Scored

CREATE TABLE players_dw.molap_top_penalty_scorers AS
SELECT 
    p.player_name,
    c.club_name,
    f.penalties AS total_penalties
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id;


SELECT * FROM players_dw.molap_top_penalty_scorers ORDER BY total_penalties DESC LIMIT 15;



-- Top 10 Players with Most Dribbles 

CREATE TABLE players_dw.molap_top_dribblers AS
SELECT 
    p.player_name,
    c.club_name,
    f.progressive_carries AS total_dribbles
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id;


SELECT * FROM players_dw.molap_top_dribblers ORDER BY total_dribbles DESC LIMIT 10;


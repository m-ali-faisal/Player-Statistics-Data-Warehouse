
-- NESTED LOOP JOIN

SET enable_hashjoin = OFF;
SET enable_mergejoin = OFF;
SET enable_nestloop = ON;

EXPLAIN ANALYZE
SELECT 
    l.league_name,
    SUM(f.goals) AS total_goals
FROM players_dw.fact2 f
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name;


-- SORT-MERGE JOIN

SET enable_hashjoin = OFF;
SET enable_mergejoin = ON;
SET enable_nestloop = OFF;

EXPLAIN ANALYZE
SELECT 
    l.league_name,
    SUM(f.goals) AS total_goals
FROM players_dw.fact2 f
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name;


-- HASH JOIN

SET enable_hashjoin = ON;
SET enable_mergejoin = OFF;
SET enable_nestloop = OFF;

EXPLAIN ANALYZE
SELECT 
    l.league_name,
    SUM(f.goals) AS total_goals
FROM players_dw.fact2 f
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
GROUP BY l.league_name;


-- DSS vs OLTP 


-- DSS Query 
EXPLAIN ANALYZE
SELECT 
    l.league_name,
    s.season_year,
    SUM(f.goals + f.assists) AS total_contributions
FROM players_dw.fact2 f
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
JOIN players_dw.dim_season s ON f.season_key = s.dim_season_id
GROUP BY l.league_name, s.season_year;

-- OLTP Query 
EXPLAIN ANALYZE
SELECT * 
FROM players_dw.dim_players 
WHERE dim_player_id = 1003;




RESET enable_hashjoin;
RESET enable_mergejoin;
RESET enable_nestloop;

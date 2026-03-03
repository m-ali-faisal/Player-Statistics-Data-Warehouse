-- MATERIALIZED VIEWS

create MATERIALIZED VIEW players_dw.best_defenders as
SELECT
    f.fact2_id,
    p.player_name,
    c.club_name,
    l.league_name,
    s.start_year AS season_year,
    (f.progressive_carries + f.carries_into_final_third) AS progressive_actions,
    (f.tackles_won + f.tackles_in_def_3rd + f.interceptions + f.blocks + f.clearances + f.recoveries) AS defensive_actions,
    (f.xg_plus_xag) AS expected_attack_actions,
    (f.yellow_cards + f.red_cards + f.second_yellow + f.fouls) AS disciplinary_actions
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
JOIN players_dw.dim_season s ON f.season_key = s.dim_season_id
WHERE p.primary_position IN ('DF') OR p.secondary_position IN ('DF')



-- query with materialised view 

explain analyze
SELECT *
FROM players_dw.best_defenders
ORDER BY defensive_actions DESC
LIMIT 15;



-- query without materialised view

EXPLAIN ANALYZE
SELECT
    f.fact2_id,
    p.player_name,
    c.club_name,
    l.league_name,
    s.start_year AS season_year,
    (f.progressive_carries + f.carries_into_final_third) AS progressive_actions,
    (f.tackles_won + f.tackles_in_def_3rd + f.interceptions + f.blocks + f.clearances + f.recoveries) AS defensive_actions,
    (f.xg_plus_xag) AS expected_attack_actions,
    (f.yellow_cards + f.red_cards + f.second_yellow + f.fouls) AS disciplinary_actions
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
JOIN players_dw.dim_club c ON f.club_key = c.dim_club_id
JOIN players_dw.dim_league l ON f.league_key = l.dim_league_id
JOIN players_dw.dim_season s ON f.season_key = s.dim_season_id
WHERE p.primary_position IN ('DF') OR p.secondary_position IN ('DF')





--INDEXING TECHNIQUES


-- Btree 
CREATE INDEX idx_players_name ON players_dw.dim_players(player_name);


--query

EXPLAIN ANALYZE
SELECT p.player_name, 
       SUM(f.xg_plus_xag) AS total_expected_attack_actions
FROM players_dw.fact2 f
JOIN players_dw.dim_players p ON f.player_key = p.dim_player_id
WHERE p.primary_position = 'FW'
GROUP BY p.player_name
ORDER BY total_expected_attack_actions DESC
LIMIT 10;


-- raw tables

CREATE TABLE players_dw.raw_playing_time AS
SELECT * FROM players_staging.staging_playing_time;

CREATE TABLE players_dw.raw_shooting AS
SELECT * FROM players_staging.staging_shooting;

CREATE TABLE players_dw.raw_passing AS
SELECT * FROM players_staging.staging_passing;

CREATE TABLE players_dw.raw_possession AS
SELECT * FROM players_staging.staging_possession;

CREATE TABLE players_dw.raw_defense AS
SELECT * FROM players_staging.staging_defense;

CREATE TABLE players_dw.raw_discipline AS
SELECT * FROM players_staging.staging_discipline;


-- fact 

CREATE TABLE players_dw.fact_elt (
    fact_elt_id SERIAL PRIMARY KEY,

    player_key INTEGER REFERENCES players_dw.dim_players(dim_player_id),
    club_key INTEGER REFERENCES players_dw.dim_club(dim_club_id),
    league_key INTEGER REFERENCES players_dw.dim_league(dim_league_id),
    season_key INTEGER REFERENCES players_dw.dim_season(dim_season_id),

    matches_played NUMERIC,
    matches_started NUMERIC,
    minutes_played NUMERIC,
    goals NUMERIC,
    assists NUMERIC,
    shots NUMERIC,
    shots_on_target NUMERIC,
    shots_on_target_pct NUMERIC,
    goals_per_shot NUMERIC,
    goals_per_shot_on_target NUMERIC,
    penalties NUMERIC,
    penalty_attempts NUMERIC,
    expected_goals NUMERIC,
    non_penalty_xg NUMERIC,
    x_assists_goals NUMERIC,
    g_plus_a NUMERIC,
    g_plus_a_minus_penalties NUMERIC,
    npxg_plus_xag NUMERIC,
    xg_plus_xag NUMERIC,
    free_kicks NUMERIC,
    passes_completed NUMERIC,
    passes_attempted NUMERIC,
    pass_accuracy_pct NUMERIC,
    key_passes NUMERIC,
    progressive_passes NUMERIC,
    passes_into_final_third NUMERIC,
    passes_into_penalty_area NUMERIC,
    crosses_into_penalty_area NUMERIC,
    expected_assists NUMERIC,
    touches NUMERIC,
    carries NUMERIC,
    progressive_carries NUMERIC,
    carries_into_final_third NUMERIC,
    total_carry_distance NUMERIC,
    tackles NUMERIC,
    tackles_won NUMERIC,
    tackles_in_def_3rd NUMERIC,
    tackles_in_mid_3rd NUMERIC,
    tackles_in_att_3rd NUMERIC,
    interceptions NUMERIC,
    blocks NUMERIC,
    clearances NUMERIC,
    recoveries NUMERIC,
    own_goals NUMERIC,
    errors NUMERIC,
    yellow_cards NUMERIC,
    red_cards NUMERIC,
    second_yellow NUMERIC,
    fouls NUMERIC
);




INSERT INTO players_dw.fact_elt (
    player_key,
    club_key,
    league_key,
    season_key,
    matches_played,
    matches_started,
    minutes_played,
    goals,
    assists,
    shots,
    shots_on_target,
    shots_on_target_pct,
    goals_per_shot,
    goals_per_shot_on_target,
    penalties,
    penalty_attempts,
    expected_goals,
    non_penalty_xg,
    x_assists_goals,
    g_plus_a,
    g_plus_a_minus_penalties,
    npxg_plus_xag,
    xg_plus_xag,
    free_kicks,
    passes_completed,
    passes_attempted,
    pass_accuracy_pct,
    key_passes,
    progressive_passes,
    passes_into_final_third,
    passes_into_penalty_area,
    crosses_into_penalty_area,
    expected_assists,
    touches,
    carries,
    progressive_carries,
    carries_into_final_third,
    total_carry_distance,
    tackles,
    tackles_won,
    tackles_in_def_3rd,
    tackles_in_mid_3rd,
    tackles_in_att_3rd,
    interceptions,
    blocks,
    clearances,
    recoveries,
    own_goals,
    errors,
    yellow_cards,
    red_cards,
    second_yellow,
    fouls
)
SELECT 
    dp.dim_player_id,
    dc.dim_club_id,
    dl.dim_league_id,
    ds.dim_season_id,

    COALESCE(pt.matches_played, 0),
    COALESCE(pt.starts, 0),
    COALESCE(pt.minutes_played, 0),

    COALESCE(sh.goals, 0),
    COALESCE(ps.assists, 0),
    COALESCE(sh.shots, 0),
    COALESCE(sh.shots_on_target, 0),
    COALESCE(sh.shots_on_target_pct, 0),
    COALESCE(sh.goals_per_shot, 0),
    COALESCE(sh.goals_per_shots_on_target, 0),
    COALESCE(sh.penalties, 0),
    COALESCE(sh.penalty_attempts, 0),
    COALESCE(sh.x_goals, 0),
    COALESCE(sh.non_penalty_xg, 0),
    COALESCE(sh.x_assists_goals, 0),
    COALESCE(sh.g_plus_a, 0),
    COALESCE(sh.g_plus_a_minus_penalties, 0),
    COALESCE(sh.npxg_plus_xag, 0),
    COALESCE(sh.xg_plus_xag, 0),
    COALESCE(sh.freekicks, 0),

    COALESCE(ps.passes_completed, 0),
    COALESCE(ps.passes_attempted, 0),
    COALESCE(ps.passes_completed_pct, 0),
    COALESCE(ps.key_passes, 0),
    COALESCE(ps.progressive_passes, 0),
    COALESCE(ps.passes_into_final_third, 0),
    COALESCE(ps.passes_into_penalty_area, 0),
    COALESCE(ps.crosses_into_penalty_area, 0),
    COALESCE(ps.x_assists, 0),

    COALESCE(po.touches, 0),
    COALESCE(po.carries, 0),
    COALESCE(po.progressive_carries, 0),
    COALESCE(po.carries_into_final_third, 0),
    COALESCE(po.tot_distance, 0),

    COALESCE(d.tackles, 0),
    COALESCE(d.tackles_won, 0),
    COALESCE(d.tackles_in_def_3rd, 0),
    COALESCE(d.tackles_in_mid_3rd, 0),
    COALESCE(d.tackles_in_att_3rd, 0),
    COALESCE(d.interceptions, 0),
    COALESCE(d.blocks, 0),
    COALESCE(d.clearances, 0),
    COALESCE(d.recoveries, 0),
    COALESCE(d.own_goals, 0),
    COALESCE(d.errors, 0),

    COALESCE(dis.yellow_cards, 0),
    COALESCE(dis.red_cards, 0),
    COALESCE(dis.second_yellow, 0),
    COALESCE(dis.fouls, 0)

FROM players_dw.raw_playing_time pt
LEFT JOIN players_dw.raw_shooting sh 
    ON pt.player_name = sh.player_name AND pt.team_name = sh.team_name
LEFT JOIN players_dw.raw_passing ps 
    ON pt.player_name = ps.player_name AND pt.team_name = ps.team_name
LEFT JOIN players_dw.raw_possession po 
    ON pt.player_name = po.player_name AND pt.team_name = po.team_name
LEFT JOIN players_dw.raw_defense d 
    ON pt.player_name = d.player_name AND pt.team_name = d.team_name
LEFT JOIN players_dw.raw_discipline dis 
    ON pt.player_name = dis.player_name AND pt.team_name = dis.team_name
LEFT JOIN players_dw.dim_players dp 
    ON pt.player_name = dp.player_name
LEFT JOIN players_dw.dim_club dc 
    ON pt.team_name = dc.club_name
LEFT JOIN players_dw.dim_league dl 
    ON dc.league_id = dl.dim_league_id
LEFT JOIN players_dw.dim_season ds 
    ON pt.season = ds.season_name;



select count(*) from players_dw.fact_elt

SELECT 
    (SELECT COUNT(*) FROM players_dw.fact2) AS etl_fact_count,
    (SELECT COUNT(*) FROM players_dw.fact_elt) AS elt_fact_count;





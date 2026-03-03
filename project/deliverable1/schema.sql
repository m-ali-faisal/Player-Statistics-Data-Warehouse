--create database labproject
--create schema players_staging;
--create schema players_dw;


----------------------------	STAGING ------------------------------------------

---- big main staging table

CREATE TABLE players_staging.staging_source_table (

    SrNum NUMERIC,
    Player TEXT,
    Nation TEXT,
    Pos TEXT,
    Squad TEXT,
    Comp TEXT,
    Age NUMERIC,
    Born NUMERIC,
    MP NUMERIC,
    Starts NUMERIC,
    "Min" NUMERIC,
    "90s" NUMERIC,
    Gls NUMERIC,
    Ast NUMERIC,
    "G+A" NUMERIC,
    "G-PK" NUMERIC,
    PK NUMERIC,
    PKatt NUMERIC,
    CrdY NUMERIC,
    CrdR NUMERIC,
    xG NUMERIC,
    npxG NUMERIC,
    xAG NUMERIC,
    "npxG+xAG" NUMERIC,
    PrgC NUMERIC,
    PrgP NUMERIC,
    PrgR NUMERIC,
    "G+A-PK" NUMERIC,
    "xG+xAG" NUMERIC,
    Rk_stats_shooting NUMERIC,
    Nation_stats_shooting TEXT,
    Pos_stats_shooting TEXT,
    Comp_stats_shooting TEXT,
    Age_stats_shooting NUMERIC,
    Born_stats_shooting NUMERIC,
    "90s_stats_shooting" NUMERIC,
    Gls_stats_shooting NUMERIC,
    Sh NUMERIC,
    SoT NUMERIC,
    "SoT%" NUMERIC,
    "Sh/90" NUMERIC,
    "SoT/90" NUMERIC,
    "G/Sh" NUMERIC,
    "G/SoT" NUMERIC,
    Dist NUMERIC,
    FK NUMERIC,
    PK_stats_shooting NUMERIC,
    PKatt_stats_shooting NUMERIC,
    xG_stats_shooting NUMERIC,
    npxG_stats_shooting NUMERIC,
    "npxG/Sh" NUMERIC,
    "G-xG" NUMERIC,
    "np:G-xG" NUMERIC,
    Rk_stats_passing NUMERIC,
    Nation_stats_passing TEXT,
    Pos_stats_passing TEXT,
    Comp_stats_passing TEXT,
    Age_stats_passing NUMERIC,
    Born_stats_passing NUMERIC,
    "90s_stats_passing" NUMERIC,
    Cmp NUMERIC,
    Att NUMERIC,
    "Cmp%" NUMERIC,
    TotDist NUMERIC,
    PrgDist NUMERIC,
    Ast_stats_passing NUMERIC,
    xAG_stats_passing NUMERIC,
    xA NUMERIC,
    "A-xAG" NUMERIC,
    KP NUMERIC,
    "1/3" NUMERIC,
    PPA NUMERIC,
    CrsPA NUMERIC,
    PrgP_stats_passing NUMERIC,
    Rk_stats_passing_types NUMERIC,
    Nation_stats_passing_types TEXT,
    Pos_stats_passing_types TEXT,
    Comp_stats_passing_types TEXT,
    Age_stats_passing_types NUMERIC,
    Born_stats_passing_types NUMERIC,
    "90s_stats_passing_types" NUMERIC,
    Att_stats_passing_types NUMERIC,
    Live NUMERIC,
    Dead NUMERIC,
    FK_stats_passing_types NUMERIC,
    TB NUMERIC,
    Sw NUMERIC,
    Crs NUMERIC,
    TI NUMERIC,
    CK NUMERIC,
    "In" NUMERIC,
    "Out" NUMERIC,
    Str NUMERIC,
    Cmp_stats_passing_types NUMERIC,
    "Off" NUMERIC,
    Blocks NUMERIC,
    Rk_stats_gca NUMERIC,
    Nation_stats_gca TEXT,
    Pos_stats_gca TEXT,
    Comp_stats_gca TEXT,
    Age_stats_gca NUMERIC,
    Born_stats_gca NUMERIC,
    "90s_stats_gca" NUMERIC,
    SCA NUMERIC,
    SCA90 NUMERIC,
    PassLive NUMERIC,
    PassDead NUMERIC,
    "TO" NUMERIC,
    Sh_stats_gca NUMERIC,
    Fld NUMERIC,
    Def NUMERIC,
    GCA NUMERIC,
    GCA90 NUMERIC,
    Rk_stats_defense NUMERIC,
    Nation_stats_defense TEXT,
    Pos_stats_defense TEXT,
    Comp_stats_defense TEXT,
    Age_stats_defense NUMERIC,
    Born_stats_defense NUMERIC,
    "90s_stats_defense" NUMERIC,
    Tkl NUMERIC,
    TklW NUMERIC,
    "Def 3rd" NUMERIC,
    "Mid 3rd" NUMERIC,
    "Att 3rd" NUMERIC,
    Att_stats_defense NUMERIC,
    "Tkl%" NUMERIC,
    Lost NUMERIC,
    Blocks_stats_defense NUMERIC,
    Sh_stats_defense NUMERIC,
    Pass NUMERIC,
    Int NUMERIC,
    "Tkl+Int" NUMERIC,
    Clr NUMERIC,
    Err NUMERIC,
    Rk_stats_possession NUMERIC,
    Nation_stats_possession TEXT,
    Pos_stats_possession TEXT,
    Comp_stats_possession TEXT,
    Age_stats_possession NUMERIC,
    Born_stats_possession NUMERIC,
    "90s_stats_possession" NUMERIC,
    Touches NUMERIC,
    "Def Pen" NUMERIC,
    "Def 3rd_stats_possession" NUMERIC,
    "Mid 3rd_stats_possession" NUMERIC,
    "Att 3rd_stats_possession" NUMERIC,
    "Att Pen" NUMERIC,
    Live_stats_possession NUMERIC,
    Att_stats_possession NUMERIC,
    Succ NUMERIC,
    "Succ%" NUMERIC,
    Tkld NUMERIC,
    "Tkld%" NUMERIC,
    Carries NUMERIC,
    TotDist_stats_possession NUMERIC,
    PrgDist_stats_possession NUMERIC,
    PrgC_stats_possession NUMERIC,
    "1/3_stats_possession" NUMERIC,
    CPA NUMERIC,
    Mis NUMERIC,
    Dis NUMERIC,
    Rec NUMERIC,
    PrgR_stats_possession NUMERIC,
    Rk_stats_playing_time NUMERIC,
    Nation_stats_playing_time TEXT,
    Pos_stats_playing_time TEXT,
    Comp_stats_playing_time TEXT,
    Age_stats_playing_time NUMERIC,
    Born_stats_playing_time NUMERIC,
    MP_stats_playing_time NUMERIC,
    Min_stats_playing_time NUMERIC,
    "Mn/MP" NUMERIC,
    "Min%" NUMERIC,
    "90s_stats_playing_time" NUMERIC,
    Starts_stats_playing_time NUMERIC,
    "Mn/Start" NUMERIC,
    Compl NUMERIC,
    Subs NUMERIC,
    "Mn/Sub" NUMERIC,
    unSub NUMERIC,
    PPM NUMERIC,
    onG NUMERIC,
    onGA NUMERIC,
    "+/-" NUMERIC,
    "+/-90" NUMERIC,
    "On-Off" NUMERIC,
    onxG NUMERIC,
    onxGA NUMERIC,
    "xG+/-" NUMERIC,
    "xG+/-90" NUMERIC,
    Rk_stats_misc NUMERIC,
    Nation_stats_misc TEXT,
    Pos_stats_misc TEXT,
    Comp_stats_misc TEXT,
    Age_stats_misc NUMERIC,
    Born_stats_misc NUMERIC,
    "90s_stats_misc" NUMERIC,
    CrdY_stats_misc NUMERIC,
    CrdR_stats_misc NUMERIC,
    "2CrdY" NUMERIC,
    Fls NUMERIC,
    Fld_stats_misc NUMERIC,
    Off_stats_misc NUMERIC,
    Crs_stats_misc NUMERIC,
    Int_stats_misc NUMERIC,
    TklW_stats_misc NUMERIC,
    PKwon NUMERIC,
    PKcon NUMERIC,
    OG NUMERIC,
    Recov NUMERIC,
    Won NUMERIC,
    Lost_stats_misc NUMERIC,
    "Won%" NUMERIC,
    primary_pos TEXT,
    secondary_pos TEXT,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


select * from players_staging.staging_source_table limit 5

select count(*) from players_staging.staging_source_table


---other small staging tables ------------------------

-- staging player tbale

create table players_staging.staging_players(

	player_name text,
	player_age numeric,
	born_year numeric,
	nation text,
	club text,
	primary_position text,
	secondary_position text,
	season TEXT DEFAULT '2024-25'

);

create table players_staging.staging_teams(

	team_name text,
	league_name text,
	nation text,
	season TEXT DEFAULT '2024-25'
);


create table players_staging.staging_playing_time(

	player_name TEXT,
    team_name TEXT,
    matches_played numeric,
    starts numeric,
    minutes_played numeric,
    subbed numeric,
	minutes_as_sub numeric,
	unsubbed numeric,
	season TEXT DEFAULT '2024-25'
	
);


create table players_staging.staging_shooting(

	player_name TEXT,
    team_name TEXT,
    goals NUMERIC,
    g_plus_a NUMERIC,
    goals_minus_penalties NUMERIC,
    penalties NUMERIC,
    penalty_attempts NUMERIC,
    x_goals NUMERIC,
    non_penalty_xg NUMERIC,
    x_assists_goals NUMERIC,
    npxg_plus_xag NUMERIC,
    g_plus_a_minus_penalties NUMERIC,
    xg_plus_xag NUMERIC,
    shots NUMERIC,
    shots_on_target NUMERIC,
	shots_on_target_pct numeric,
    shots_per_90 NUMERIC,
    shots_on_target_per_90 NUMERIC,
    goals_per_shot NUMERIC,
    goals_per_shots_on_target NUMERIC,
    freekicks NUMERIC,
	season TEXT DEFAULT '2024-25'

);


CREATE TABLE players_staging.staging_passing(
    player_name TEXT,
    team_name TEXT,
    passes_completed NUMERIC,
    passes_attempted NUMERIC,
    passes_completed_pct NUMERIC,
    assists NUMERIC,
    x_assists NUMERIC,
    a_minus_xag NUMERIC,
    key_passes NUMERIC,
    passes_into_final_third NUMERIC,
    passes_into_penalty_area NUMERIC,
    crosses_into_penalty_area NUMERIC,
    progressive_passes NUMERIC,
	season TEXT DEFAULT '2024-25'
);


create table players_staging.staging_possession(

	player_name TEXT,
    team_name TEXT,
    touches NUMERIC,
    carries NUMERIC,
    tot_distance NUMERIC,
    progressive_carries NUMERIC,
    carries_into_final_third NUMERIC,
	season TEXT DEFAULT '2024-25'
   
);



create table players_staging.staging_defense(

	player_name TEXT,
    team_name TEXT,
    tackles NUMERIC,
    tackles_won NUMERIC,
    tackles_in_def_3rd NUMERIC,
    tackles_in_mid_3rd NUMERIC,
    tackles_in_att_3rd NUMERIC,
    tackles_attempted NUMERIC,
    tackles_pct NUMERIC,
    tackles_lost NUMERIC,
    blocks NUMERIC,
    interceptions NUMERIC,
    tackles_plus_interceptions NUMERIC,
    clearances NUMERIC,
    errors NUMERIC,
	recoveries numeric,
	own_goals numeric,
	season TEXT DEFAULT '2024-25'
);


create table players_staging.staging_discipline(

	player_name TEXT,
    team_name TEXT,
    yellow_cards NUMERIC,
    red_cards NUMERIC,
    second_yellow NUMERIC,
	fouls numeric,
	season TEXT DEFAULT '2024-25'
  
);

--drop table players_staging.staging_defense;
--drop table players_staging.staging_discipline;
--drop table players_staging.staging_possession;
--drop table players_staging.staging_passing;
-- drop table players_staging.staging_players;
-- drop table players_staging.staging_teams;
-- drop table players_staging.staging_shooting;
--drop table players_staging.staging_playing_time;



--------------------------- DIMENSIONS ---------------------------



create table players_dw.dim_players(

	dim_player_id serial primary key,
	player_name text,
	player_age numeric,
	born_year numeric,
	nation text,
	club text,
	primary_position text,
	secondary_position text,
	season TEXT DEFAULT '2024-25'
);


CREATE TABLE players_dw.dim_club (
    dim_club_id SERIAL PRIMARY KEY,
    club_name TEXT NOT NULL,
    league_id INT,
    nation TEXT
);


CREATE TABLE players_dw.dim_league (
    dim_league_id SERIAL PRIMARY KEY,
    league_name TEXT NOT NULL,
    country TEXT
); 


CREATE TABLE players_dw.dim_season (
    dim_season_id SERIAL PRIMARY KEY,
    season_name TEXT UNIQUE NOT NULL, 
    start_year INT,
    end_year INT
);


-------------------- fact tables ---------------------

CREATE TABLE players_dw.fact2 (
    fact2_id SERIAL PRIMARY KEY,

    player_key INTEGER REFERENCES players_dw.dim_players(dim_player_id),
    club_key INTEGER REFERENCES players_dw.dim_club(dim_club_id),
    league_key INTEGER REFERENCES players_dw.dim_league(dim_league_id),
    season_key INTEGER REFERENCES players_dw.dim_season(dim_season_id),

    -- Basic performance
    matches_played NUMERIC,
    matches_started NUMERIC,
    minutes_played NUMERIC,

    -- Shooting stats
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

    -- Passing stats
    passes_completed NUMERIC,
    passes_attempted NUMERIC,
    pass_accuracy_pct NUMERIC,
    key_passes NUMERIC,
    progressive_passes NUMERIC,
    passes_into_final_third NUMERIC,
    passes_into_penalty_area NUMERIC,
    crosses_into_penalty_area NUMERIC,
    expected_assists NUMERIC,

    -- Possession stats
    touches NUMERIC,
    carries NUMERIC,
    progressive_carries NUMERIC,
    carries_into_final_third NUMERIC,
    total_carry_distance NUMERIC,

    -- Defensive stats
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

    -- Discipline
    yellow_cards NUMERIC,
    red_cards NUMERIC,
    second_yellow NUMERIC,
    fouls NUMERIC
);






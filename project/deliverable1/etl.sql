


------------------------ Staging Inserts ---------------------------------


-- truncate table players_staging.staging_players;
-- truncate table players_staging.staging_teams;
-- truncate table players_staging.staging_shooting;
-- truncate table players_staging.staging_playing_time;
-- truncate table players_staging.staging_defense;
-- truncate table players_staging.staging_passing;
-- truncate table players_staging.staging_possession;


-- players
insert into players_staging.staging_players
select Player as  player_name,
	Age as player_age,
	Born as born_year,
	Nation as nation,
	Squad as club,
	primary_pos as primary_position,
	case when secondary_pos is null then NULL else secondary_pos::text end as secondary_position
from players_staging.staging_source_table; 

select * from players_staging.staging_players;
select count(*) from  players_staging.staging_players;


-- teams

insert into players_staging.staging_teams
select Squad as team_name,
	Comp as league_name,
	Nation as nation
from players_staging.staging_source_table;

select * from players_staging.staging_teams;
select count(*) from  players_staging.staging_teams;

-- playing time

insert into players_staging.staging_playing_time
select Player as player_name,
	Squad as team_name,
	MP as matches_played,
	Starts as starts,
	"Min" as minutes_played,
	Subs as subbed,
	"Mn/Sub" as minutes_as_sub,
	unSub as unsubbed_matches
from players_staging.staging_source_table

select * from players_staging.staging_playing_time;
select count(*) from players_staging.staging_playing_time;

-- shooting

insert into players_staging.staging_shooting
select Player as player_name,
	Squad as team_name,
	Gls as goals,
	"G+A" as g_plus_a,
	"G-PK" as goals_minus_penalties,
	PK as penalties,
	PKatt as penalty_attemps,
	xG as x_goals,
	npXG as non_penalty_xg,
	xAG as x_assists_goals,
	"npxG+xAG" as  npxg_plus_xag,
	"G+A-PK" as g_plus_a_minus_penalties,
	"xG+xAG" as xg_plus_xag,
	Sh as shots,
	SoT as shots_on_target,
	"SoT%" as shots_on_target_pct,
	"Sh/90" as shots_per_90,
	"SoT/90" as  shots_on_target_per_90,
	"G/Sh" as goals_per_shot,
	"G/SoT"	as goals_per_shots_on_target,
	FK as freekicks
from players_staging.staging_source_table
	


select * from players_staging.staging_shooting;

select count(*) from players_staging.staging_shooting;


-- discipline

insert into players_staging.staging_discipline
select Player as player_name,
	Squad as team_name,
	CrdY_stats_misc as yellow_cards,
	CrdR_stats_misc as red_card,
	"2CrdY" as second_yellow,
	Fls as fouls
from players_staging.staging_source_table;

select count(*) from players_staging.staging_discipline;
select * from players_staging.staging_discipline;

-- defense

insert into players_staging.staging_defense
select Player as player_name,
	Squad as team_name,
	Tkl as tackles,
	TklW as tackles_won,
	"Def 3rd" as tackles_in_def_3rd,
	"Mid 3rd" as tackles_in_mid_3rd,
	"Att 3rd" as tackles_in_att_3rd,
	Att_stats_defense as tackles_attempted,
	"Tkl%" as tackles_pct,
	Lost as tackles_lost,
	Blocks_stats_defense as blocks,
	Int as interceptions,
	"Tkl+Int" as tackles_plus_interceptions,
	Clr as clearences,
	Err as errors,
	Recov as recoveries,
	OG as own_goals
from players_staging.staging_source_table


select * from players_staging.staging_defense;
select count(*) from players_staging.staging_defense;


-- possession

insert into players_staging.staging_possession
select Player as player_name,
	Squad as team_name,
	Touches as touches,
	Carries as carries,
	TotDist_stats_possession as tot_distance,
	PrgC_stats_possession as progressive_carries,
	"1/3_stats_possession" as carries_into_final_third
from players_staging.staging_source_table	



select * from players_staging.staging_possession;
select count(*) from players_staging.staging_possession;

--


-- passing

insert into players_staging.staging_passing
select
    Player as player_name,
    Squad as team_name,
    Cmp as passes_completed,
    Att as passes_attempted,
    "Cmp%" as passes_completed_pct,
    Ast as assists,
    xA as x_assists,
    "A-xAG" as a_minus_xag,
    KP as key_passes,
    "1/3" as passes_into_final_third,
    PPA as passes_into_penalty_area,
    CrsPA as crosses_into_penalty_area,
    PrgP as progressive_passes
from players_staging.staging_source_table;


select * from players_staging.staging_passing;
select count(*) from players_staging.staging_passing;




-------------------------- dimension inserts --------------------------------


-- league

INSERT INTO players_dw.dim_league (league_name, country)
SELECT DISTINCT on (league_name)
	league_name,
    left(league_name,3) as nation
FROM players_staging.staging_teams
WHERE league_name IS NOT NULL;


select * from players_dw.dim_league;


-- clubs

INSERT INTO players_dw.dim_club (club_name, league_id, nation)
SELECT DISTINCT on (t.team_name)
    t.team_name AS club_name,
    l.dim_league_id AS league_id,
    left(t.league_name,3) as nation
FROM players_staging.staging_teams t
LEFT JOIN players_dw.dim_league l
    ON t.league_name = l.league_name
WHERE t.team_name IS NOT NULL;

select * from players_dw.dim_club

select count(*) from players_dw.dim_club



-- players


INSERT INTO players_dw.dim_players (
    player_name,
    player_age,
    born_year,
    nation,
    club,
    primary_position,
    secondary_position,
    season
)
SELECT
    initcap(player_name),
    player_age::int,
    born_year::int,
    upper(nation),
    club,
    upper(primary_position),
    upper(secondary_position),
    season
FROM players_staging.staging_players
WHERE player_name IS NOT NULL;

select * from players_dw.dim_players




-- season

INSERT INTO players_dw.dim_season (season_name, start_year, end_year)
SELECT DISTINCT
    season,
    SPLIT_PART(season, '-', 1)::INT AS start_year,
    SPLIT_PART(season, '-', 2)::INT + 2000 AS end_year 
FROM players_staging.staging_players
WHERE season IS NOT NULL;


select * from players_dw.dim_season

--



---------- insert to fact table ------------------------


TRUNCATE players_dw.fact2

INSERT INTO players_dw.fact2 (
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

    pt.matches_played,
    pt.starts AS matches_started,
    pt.minutes_played,

    sh.goals,
    ps.assists,
    sh.shots,
    sh.shots_on_target,
	COALESCE(sh.shots_on_target_pct, 0),
	COALESCE(sh.goals_per_shot, 0),
	COALESCE(sh.goals_per_shots_on_target, 0),
    sh.penalties,
    sh.penalty_attempts,
    sh.x_goals,
    sh.non_penalty_xg,
    sh.x_assists_goals,
    sh.g_plus_a,
    sh.g_plus_a_minus_penalties,
    sh.npxg_plus_xag,
    sh.xg_plus_xag,
    sh.freekicks,

    ps.passes_completed,
    ps.passes_attempted,
    ps.passes_completed_pct,
    ps.key_passes,
    ps.progressive_passes,
    ps.passes_into_final_third,
    ps.passes_into_penalty_area,
    ps.crosses_into_penalty_area,
    ps.x_assists,

    po.touches,
    po.carries,
    po.progressive_carries,
    po.carries_into_final_third,
    po.tot_distance,

    d.tackles,
    d.tackles_won,
    d.tackles_in_def_3rd,
    d.tackles_in_mid_3rd,
    d.tackles_in_att_3rd,
    d.interceptions,
    d.blocks,
    d.clearances,
    d.recoveries,
    d.own_goals,
    d.errors,

    dis.yellow_cards,
    dis.red_cards,
    dis.second_yellow,
    dis.fouls

FROM players_staging.staging_playing_time pt
LEFT JOIN players_staging.staging_shooting sh 
    ON pt.player_name = sh.player_name AND pt.team_name = sh.team_name
LEFT JOIN players_staging.staging_passing ps 
    ON pt.player_name = ps.player_name AND pt.team_name = ps.team_name
LEFT JOIN players_staging.staging_possession po 
    ON pt.player_name = po.player_name AND pt.team_name = po.team_name
LEFT JOIN players_staging.staging_defense d 
    ON pt.player_name = d.player_name AND pt.team_name = d.team_name
LEFT JOIN players_staging.staging_discipline dis 
    ON pt.player_name = dis.player_name AND pt.team_name = dis.team_name
LEFT JOIN players_dw.dim_players dp 
    ON pt.player_name = dp.player_name
LEFT JOIN players_dw.dim_club dc 
    ON pt.team_name = dc.club_name
LEFT JOIN players_dw.dim_league dl 
    ON dc.league_id = dl.dim_league_id
LEFT JOIN players_dw.dim_season ds 
    ON pt.season = ds.season_name;


select count(*) from players_dw.fact2;

select * from players_dw.fact2;




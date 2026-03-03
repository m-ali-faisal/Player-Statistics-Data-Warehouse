

-- Primary Keys

-- Each dimension table uses a serial primary key .
-- This ensures every record is uniquely identifiable and avoids duplication 


--   dim_players(dim_player_id)
--   dim_club(dim_club_id)
--   dim_league(dim_league_id)
--   dim_season(dim_season_id)
--   fact(fact_id)



-- Foreign Keys

-- to maintain valid dimensional relationships and enforece referential integrity and to build a
-- valid star schema


-- Foreign Keys
--   fact.player_key  
--   fact.club_key    
--   fact.league_key  
--   fact.season_key  




-- Columns that can benfit from indexing


-- fact.player_key       -> since join with player dim is used a lot for player based analsis
-- fact.club_key         -> good for club-based summaries
-- fact.league_key        -> good for league-level summaries
-- fact.season_key        -> good for season based summaries
--  dim_club.club_name     -> improves filtering on club name





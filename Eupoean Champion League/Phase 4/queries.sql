SELECT Country.name AS country, 
SUM(Champions_league_team.win)::float / SUM(Champions_league_team.matches_played) AS win_rate
FROM Champions_league_team, Team, Country
WHERE Champions_league_team.team = Team.tID AND Country.cID = Team.cID
GROUP BY Country.name
ORDER BY win_rate;

SELECT Country.name AS country, 
SUM(Europa_league_team.win)::float / SUM(Europa_league_team.matches_played) AS win_rate
FROM Europa_league_team, Team, Country
WHERE Europa_league_team.team = Team.tID AND Country.cID = Team.cID
GROUP BY Country.name
ORDER BY win_rate;

# teamID participate in Champions Leagues at least five times
DROP VIEW IF EXISTS champions_team CASCADE;
CREATE VIEW champions_team AS
SELECT team AS team, AVG(Team.cID)::INTEGER AS country, 
SUM(Champions_league_team.win)::float / SUM(Champions_league_team.matches_played) AS win_rate
FROM Champions_league_team, Team
WHERE Champions_league_team.team = Team.tID
GROUP BY team
HAVING COUNT(season_year) > 6;

DROP VIEW IF EXISTS five_leagues CASCADE;
CREATE VIEW five_leagues AS
SELECT * FROM La_liga 
UNION 
SELECT * FROM Ligue_1 
UNION 
SELECT * FROM Premier_league 
UNION 
SELECT * FROM Bundesliga 
UNION 
SELECT * FROM Serie_a; 

DROP VIEW IF EXISTS champions_team_information CASCADE;
CREATE VIEW champions_team_information AS
SELECT AVG(champions_team.country)::INTEGER AS country, team.name, 
AVG(champions_team.win_rate) AS champions_league_win_rate, AVG(rank) AS average_league_rank 
FROM champions_team, five_leagues, team
WHERE champions_team.team = five_leagues.team AND champions_team.team = team.tID
GROUP BY team.name;

DROP VIEW IF EXISTS matches CASCADE;
CREATE VIEW matches AS
SELECT home, away, home_goals, away_goals, home.cID AS home_country, away.cID AS away_country,
(CASE
    WHEN home_goals = away_goals THEN 'draw'
    WHEN home_goals > away_goals THEN 'home'
    ELSE 'away'
END) AS win 
FROM Champions_league_match, Team As home, Team AS away
WHERE Champions_league_match.home = home.tID AND Champions_league_match.away = away.tID;

DROP VIEW IF EXISTS grouped_matches CASCADE;
CREATE VIEW grouped_matches AS
SELECT home.name AS home_nation, away.name AS away_nation, COUNT(*) AS number_of_matches,
SUM(CASE 
        WHEN matches.win = 'home' THEN 1
        ELSE 0
        END) AS home_win_count,
SUM(CASE 
        WHEN matches.win = 'away' THEN 1
        ELSE 0
        END) AS away_win_count,
SUM(CASE 
        WHEN matches.win = 'draw' THEN 1
        ELSE 0
        END) AS draw_count   
FROM matches, country home, country away
WHERE matches.home_country = home.cID AND matches.away_country = away.cID
GROUP BY home.name, away.name;

DROP VIEW IF EXISTS grouped_matches_rate CASCADE;
CREATE VIEW grouped_matches_rate AS
SELECT home_nation, away_nation, 
home_win_count::FLOAT / number_of_matches AS home_win_rate,  
away_win_count::FLOAT / number_of_matches AS away_win_rate, 
draw_count::FLOAT / number_of_matches AS draw_rate
FROM grouped_matches;

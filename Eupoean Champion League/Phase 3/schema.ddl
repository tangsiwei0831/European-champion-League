drop schema if exists soccer cascade; -- You can choose a different schema name.
create schema soccer;
set search_path to soccer;

-- A European country that has some number of professional soccer clubs.
-- cID is the unique ID of that country.
-- number_of_teams records number of professional soccer teams of that country (recorded in the database).

CREATE TABLE Country(
    cID integer PRIMARY KEY,
    name varchar(25) NOT NULL,
    number_of_teams integer NOT NULL
);

-- A professional soccer club in Europe.
-- tID is the unique ID of that soccer club.
-- cID is the country ID of that soccer club in.
-- name is the actual name of this soccer club.

CREATE TABLE Team(
    tID integer PRIMARY KEY,
    cID integer NOT NULL REFERENCES Country,
    name varchar(100) NOT NULL
);

-- The domain for this is past ten years from 2010 to 2019.
CREATE DOMAIN season as integer
    DEFAULT NULL
    CHECK (VALUE >= 2010 AND VALUE <= 2019);

-- The domain for stage in European level competition
CREATE DOMAIN stage as integer
    DEFAULT NULL
    CHECK (VALUE  = 48 OR VALUE  = 32 OR VALUE  = 16 OR VALUE  = 8 OR VALUE  = 4 OR VALUE  = 2 OR VALUE  = 1);

-- Performance of a soccer club at European Champion League in one year
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- rank is the rank of this t eam in this competition.

-- If have time, put constraints on matches_played, greater than 0
-- Put rank to be 32, 16, 8, 4, 2, 1
CREATE TABLE Champions_league_team(
    team integer NOT NULL REFERENCES Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    rank stage NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Performance of a soccer club at Europa League in one year
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- rank is the rank of this team in this competition.

-- If have time, put constraints on matches_played, greater than 0
-- Put rank to be 48, 32, 16, 8, 4, 2, 1
CREATE TABLE Europa_league_team(
    team integer NOT NULL REFERENCES Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    rank stage NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Matches of a European Champion League in one year
-- home records the home team of the match
-- away records the away team of the match
-- season_year records the season of the match
-- level records the stage of this match
-- home_goals records goals scored by the team at home
-- away_goals records goals scored by the team away

CREATE TABLE Champion_league_match(
    home integer NOT NULL References Team,
    away integer NOT NULL References Team,
    season_year season NOT NULL,
    level stage NOT NULL,
    home_goals integer NOT NULL,
    away_goals integer NOT NULL,
    PRIMARY KEY (home, away, season_year, level)
);

-- Matches of a Europa League in one year
-- home records the home team of the match
-- away records the away team of the match
-- season_year records the season of the match
-- stage records the stage of this match
-- home_goals records goals scored by the team at home
-- away_goals records goals scored by the team away

CREATE TABLE Europa_league_match(
    home integer NOT NULL References Team,
    away integer NOT NULL References Team,
    season_year season NOT NULL,
    level stage NOT NULL,
    home_goals integer NOT NULL,
    away_goals integer NOT NULL,
    PRIMARY KEY (home, away, season_year, level)
);

-- Rank Table of the Premier League (in England) in each season
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- points is the points earned by the team on that season.
-- rank is the rank of this team in this competition.

CREATE TABLE Premier_league(
    team integer NOT NULL References Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    points integer NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Rank Table of the Laliga (in Spain) in each season
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- points is the points earned by the team on that season.
-- rank is the rank of this team in this competition.

CREATE TABLE La_liga(
    team integer NOT NULL References Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    points integer NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Rank Table of the Serie A (in Italy) in each season
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- points is the points earned by the team on that season.
-- rank is the rank of this team in this competition.

CREATE TABLE Serie_a(
    team integer NOT NULL References Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    points integer NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Rank Table of the Bundesliga (in Germany) in each season
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- points is the points earned by the team on that season.
-- rank is the rank of this team in this competition.

CREATE TABLE Bundesliga(
    team integer NOT NULL References Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    points integer NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Rank Table of the Ligue1 (in France) in each season
-- team is the unique ID of that team.
-- season_year is the year of this competition. (For example, if it is 2017 ~ 2018 season, we record it as 2017)
-- matches_played is the number of matches played by this team.
-- win is the number of winning matches played by this team.
-- draw is the number of drawing matches played by this team.
-- lose is the number of losing matches played by this team.
-- goals_for is the number of goals scored by this team.
-- goals_against is the number of goals against to this team
-- goals_difference is the goal difference of a team, (that is, goals_for - goals_against).
-- points is the points earned by the team on that season.
-- rank is the rank of this team in this competition.

CREATE TABLE Ligue_1(
    team integer NOT NULL References Team,
    season_year season NOT NULL,
    matches_played integer NOT NULL,
    win integer NOT NULL,
    draw integer NOT NULL,
    lose integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goals_difference integer NOT NULL,
    points integer NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
);

-- Rank table for national team coefficient
-- team is the ID of a country, corresponds to a national team
-- rank is the rank of that country in that year

CREATE TABLE National_team_coefficient(
    team integer NOT NULL REFERENCES Country, 
    season_year season NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
); 

-- Rank table for a country's coefficient for its clubs' performance on European level competition.
-- team is the ID of a country, corresponds to a national team
-- rank is the rank of that country in that year

CREATE TABLE Country_coefficient(
    team integer NOT NULL REFERENCES Country, 
    season_year season NOT NULL,
    rank integer NOT NULL,
    PRIMARY KEY (team, season_year)
);

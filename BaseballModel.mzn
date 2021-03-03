% parameters


% teams are a numeric representation for each of the 30 teams and one for a non-existant end stadium
set of range_of_teams: TEAMS = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
set of int: range_of_teams = 1..31;

% game identifier given to each game
set of 1..3000: GAMES;
int: num_of_games = length(GAMES);
set of int: range_of_games = 1..num_of_games;

% this is the graph for each game, the weight to the next possible game at each stadium
array[range_of_games,range_of_teams] of int: weights;
% this is the graph for each game, the edge to the next possible game at each stadium
array[range_of_games,range_of_teams] of int: next_games;
% this defines the home team for each game
array[range_of_games] of range_of_teams: home_teams;

set of range_of_teams: teams_to_attend;
set of range_of_teams: start_teams;
set of range_of_teams: end_teams;

% this is a variable of length teams where each is a game. This defines all the games to go to.
array[range_of_path] of var GAMES: path;
int: length_of_path = length(teams_to_attend);
set of int: range_of_path = 1..length_of_path;

% this stores the home team for each game in the path
array[range_of_path] of var TEAMS: path_teams;

% this sums the weights of the previous game to the current home team.
var int:cost = sum(i,j in range_of_path where j = i+1)(
  weights[
    path[i], 
    home_teams[path[j]]]);

include "alldifferent.mzn";

% all games are different
constraint alldifferent(path);
% the last game is always the fake team for the end node
constraint path_teams[length_of_path]=31;
constraint path[length_of_path]=num_of_games;
% the first game must start at a team in the start_teams list
constraint path_teams[1] in start_teams;
% the last game must be a team in the end_teams list
constraint path_teams[length_of_path-1] in end_teams;
% the home team of all games are different
constraint alldifferent(path_teams);
% the path must use the available edges
constraint forall(i,j in range_of_path where j = i+1) (next_games[path[i],home_teams[path[j]]]==path[j]);
% the home team for each game in the path
constraint forall(i in range_of_path where i < length_of_path) (path_teams[i]=home_teams[path[i]]);
% the team must exist in the teams_to_attend
constraint forall(team in path_teams) (team in teams_to_attend);

solve minimize cost;
%solve satisfy;

output ["cost:\(cost), # of path:\(path), path_teams:\(path_teams)"];
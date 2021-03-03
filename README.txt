I want to efficiently go to a baseball game at every MLB stadium. The introduction of a multi-option schedule changes the problem from a plain traveling salesman problem to a kind of traveling salesman with time windows problem. Time is an important factor in this problem because the most efficient solution by distance may end up taking weeks due to the need to wait for a game to be played at a particular stadium.  Distance is also important because the most efficient in time might have you traveling back and forth across the country several times. This notebook sets up a number of parameters such as the start and end date of the tour, the teams to start or end with, assumptions about how many miles you are willing to travel each day, and how to weigh the total time vs distance traveled. 

The approach is to read in all the games matching the input parameters. A matrix is created that maps each game to the next reachable game at every other stadium. A minizinc model is then executed to find the optinmal path of games that each have a different team with minimal cost w.r.t. the configured distance and time coefficient. 

References:

The distance matrix was downloaded from https://bitbucket.org/trhdata/mlb-stadiums.git

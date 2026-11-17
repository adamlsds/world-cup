#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#for teams

 cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
if [[ $YEAR != year ]]
then
echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS
#if WINNER in teams
WIN_EXISTS=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
if [[ -z $WIN_EXISTS ]]
then
$PSQL "INSERT INTO teams(name) VALUES('$WINNER')" 

fi
# if opp in teams
OPP_EXISTS=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
if [[ -z $OPP_EXISTS ]]
then
$PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')" 
fi

fi
done 

#for games

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
if [[ $YEAR != year ]]
then
echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS
# for WINNER_id n opponent_id
WINNER_ID=$($PSQL "SELECT team_id from teams WHERE name='$WINNER'")
OPPONENT_ID=$($PSQL "SELECT team_id from teams WHERE name='$OPPONENT'")
$PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"

fi
done 

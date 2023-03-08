#!/bin/bash

main_choices="rock paper scissors"

function validate() {
  local input=$1
  for choice in $main_choices
  do
    if [[ "$input" = "$choice" ]]; then
      echo 0
      return
    fi
  done
  echo 1
}

function checkAnswers() {
  if [[ "$1" = "rock"  && "$2" = "scissors" ]]; then
    echo 0
  elif [[ "$1" = "paper"  && "$2" = "rock" ]]; then
    echo 0
  elif [[ "$1" = "scissors"  && "$2" = "paper" ]]; then
    echo 0
  elif [[ "$1" = "$2" ]]; then
    echo 1
  else
    echo 2
  fi
}


# MAIN TITLE AND FIRST INPUT
echo "          .:rock paper scissors:."
echo -n "type your choice: "
read input

# calling the function to validate the input
answer=`validate $input`

#if we get an answer that is not rock paper or scissors,
#then prevent the user from going further into the game
if [[ $answer -eq 1 ]]; then
  validation=1
  while [[ $validation -eq 1 ]]; do
    echo -n "wrong input... please enter: rock paper or scissors "
    read input
    loopAnswer=`validate $input`
    if [[ $loopAnswer -eq 0 ]]; then
      validation=0
    fi
  done
fi

# computer choice
pcChoices=(rock paper scissors)
echo -n "the computer will choose now"

for (( i = 0; i < 3; i++ )); do
  sleep 0.5
  echo -n "."
done
sleep 0.5
echo

# creating a random index to get a random choice from the array of answers
randomIndex=$(( $RANDOM % ${#pcChoices[@]} ))
pcInput=${pcChoices[$randomIndex]}

echo "computer chose: [$pcInput] your choice was: [$input]"
# check answers will return a number, depending if we win loose or draw
result=`checkAnswers $input $pcInput`

# working the results
case $result in
  0)
    echo "you win!";;
  1)
    echo "I'S A DRAW!";;
  2)
    echo "you loose";;
esac

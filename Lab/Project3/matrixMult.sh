#!/bin/bash -

# for loop i was gonna do in c
START=0
END=9
echo "Countdown"
e=0

for (( c=$START; c<'9'; ))
do
  # on every iteration add one and calculate sum
  for (( d=$START; d<'3';d++)); do
    #printf "\nC[$e]=A[$c]B[$d]+A[$(($c+1))]B[$(($d+3))]+A[$(($c+2))]B[$(($d+6))]"
    printf "\nA[\e[38;5;26m$c\e[0m]B[\e[38;5;26m$d\e[0m] + A[\e[38;5;26m$(($c+1))\e[0m]B[\e[38;5;26m$(($d+3))\e[0m] +  A[\e[38;5;26m$(($c+2))\e[0m]B[\e[38;5;26m$(($d+6))\e[0m]"

    e="$((e+1))"
  done
  c="$((c+3))"
done



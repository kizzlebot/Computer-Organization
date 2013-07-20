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
    printf "\nC[$e]=A[$c]B[$d]+A[$(($c+1))]B[$(($d+3))]+A[$(($c+2))]B[$(($d+6))]"
    e="$((e+1))"
  done
  c="$((c+3))"
done



#!/bin/sh

while ! mpc -h 127.0.0.1
  do sleep 1
done

mpc -h 127.0.0.1 load plent
mpc -h 127.0.0.1 random on
mpc -h 127.0.0.1 repeat on
mpc -h 127.0.0.1 play

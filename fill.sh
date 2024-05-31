#!/bin/zsh

printf "\x1b[38;5;240m"

for i in {1..$(tput cols)}
do
    printf "$1"
done
printf '\x1b[0m'

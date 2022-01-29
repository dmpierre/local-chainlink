#!/bin/sh
PROJECT_ID=${1}
UNLOCKED_ACCOUNT=${2}
FORK=${3} # whether or not to fork an infura endpoint

if [[ ${FORK} == 1 ]]
then
    ganache-cli --host 0.0.0.0 -m "coffee three shed immense senior hold dune inspire deliver illness ski canvas" -g 20000000 --fork ${PROJECT_ID} --unlock ${UNLOCKED_ACCOUNT}
else
    ganache-cli --host 0.0.0.0 -m "coffee three shed immense senior hold dune inspire deliver illness ski canvas" --chain.networkId 1337  --chain.chainId 42 -g 20000000 --unlock ${UNLOCKED_ACCOUNT}
fi
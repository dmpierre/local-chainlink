#!/bin/sh
PROJECT_ID=${1}
UNLOCKED_ACCOUNT=${2}
ganache-cli --host 0.0.0.0 -m "coffee three shed immense senior hold dune inspire deliver illness ski canvas" -g 20000000 --fork ${PROJECT_ID} --unlock ${UNLOCKED_ACCOUNT}
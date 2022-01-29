#!/bin/sh
# host name is ganache on containers network
DEFAULT_IP_GANACHE=ganache # will use containerized ganache, otherwise give host.docker.internal
IP_GANACHE=${1:-${DEFAULT_IP_GANACHE}}

DEFAULT_ETH_NETWORK=kovan
ETH_NETWORK=${2:-${DEFAULT_ETH_NETWORK}}

DEFAULT_IP_CONTAINER_POSTGRES=postgresql
IP_CONTAINER_POSTGRES=${3:-${DEFAULT_IP_CONTAINER_POSTGRES}}

CURRENT_WORKDIR=$(pwd)

export ETH_URL=ws://${IP_GANACHE}:8545
export ETH_HTTP_URL=http://${IP_GANACHE}:8545

# chainlinknode user is configured in Dockerfile of postgresql container
# if you want to change this in the postgresql, change it both here and in the Dockerfile
export DATABASE_URL=postgresql://chainlinknode:chainlinknode@${IP_CONTAINER_POSTGRES}:5432/chainlinknode?sslmode=disable

docker run --rm --network local_chainlink_default --name chainlinknode \
            -p 6688:6688 -v ${CURRENT_WORKDIR}/.chainlink-${ETH_NETWORK}:/chainlink -it \
            --env ETH_URL=${ETH_URL} --env DATABASE_URL=${DATABASE_URL} \
            --env-file=${CURRENT_WORKDIR}/.chainlink-${ETH_NETWORK}/.env smartcontract/chainlink:0.10.15 \
            local n -p /chainlink/.password -a /chainlink/.api
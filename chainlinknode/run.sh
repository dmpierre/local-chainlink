#!/bin/sh
# Get ganache and postgres containers IPs on containers network
DEFAULT_ETH_NETWORK=kovan
DEFAULT_IP_CONTAINER_GANACHE=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ganache)
DEFAULT_IP_CONTAINER_POSTGRES=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgresql)
CURRENT_WORKDIR=$(pwd)

ETH_NETWORK=${1:-${DEFAULT_ETH_NETWORK}}
# Instead of IP, could directly use container names as hostnames (ganache and postgres)
IP_CONTAINER_GANACHE=${2:-${DEFAULT_IP_CONTAINER_GANACHE}}
IP_CONTAINER_POSTGRES=${3:-${DEFAULT_IP_CONTAINER_POSTGRES}}

export ETH_URL=ws://${IP_CONTAINER_GANACHE}:8545
export ETH_HTTP_URL=http://${IP_CONTAINER_GANACHE}:8545

# chainlinknode user is configured in Dockerfile of postgresql container
# if you want to change this in the postgresql, change it both here and in the Dockerfile
export DATABASE_URL=postgresql://chainlinknode:chainlinknode@${IP_CONTAINER_POSTGRES}:5432/chainlinknode?sslmode=disable

docker run --rm --network local_chainlink_default --name chainlinknode \
            -p 6688:6688 -v ${CURRENT_WORKDIR}/.chainlink-${ETH_NETWORK}:/chainlink -it \
            --env ETH_URL=${ETH_URL} --env DATABASE_URL=${DATABASE_URL} \
            --env-file=${CURRENT_WORKDIR}/.chainlink-${ETH_NETWORK}/.env smartcontract/chainlink:0.10.15 \
            local n -p /chainlink/.password -a /chainlink/.api
#!/bin/bash

docker swarm leave --force

export EXTERNAL_IP=$(hostname -i)

echo 
echo "docker swarm init"

docker swarm init \
    --advertise-addr $(hostname -i) \
    --default-addr-pool 10.200.0.0/22

docker swarm join-token manager



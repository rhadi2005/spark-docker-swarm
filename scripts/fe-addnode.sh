#!/bin/bash

export WORKER_IP="${1}"
export MANAGER_IP="$(hostname -i):2377"

echo "Adding the node ${WORKER_IP} to the Swarm manager ${MANAGER_IP} ..."

#TOKEN=`docker-machine ssh node-1 docker swarm join-token worker | grep token | awk '{ print $5 }'`
TOKEN=`docker swarm join-token worker | grep token | awk '{ print $5 }'`
echo "TOKEN={$TOKEN}"

#kill all containers
ssh -o "StrictHostKeyChecking no" -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} "docker kill $(docker ps -aq)"

#remotely add worker to docker swarm stack
ssh -o "StrictHostKeyChecking no" -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} "docker swarm join --token ${TOKEN} ${MANAGER_IP}"

#list docker swarm stack
docker node ls

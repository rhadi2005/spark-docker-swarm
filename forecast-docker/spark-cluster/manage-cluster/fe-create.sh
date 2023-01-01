#!/bin/bash


echo "Initializing Swarm mode..."

docker swarm init \
    --advertise-addr $(hostname -i) \
    --default-addr-pool 10.200.0.0/22


echo "Token to add nodes to the Swarm..."

#TOKEN=`docker-machine ssh node-1 docker swarm join-token worker | grep token | awk '{ print $5 }'`
TOKEN=`docker swarm join-token worker | grep token | awk '{ print $5 }'`
echo "TOKEN={$TOKEN}"


echo "Deploying Spark..."

#eval $(docker-machine env node-1)
#export EXTERNAL_IP=$(docker-machine ip node-2)

export EXTERNAL_IP=$(hostname -i)

docker stack deploy --compose-file=../docker-swarm.yml spark
#docker service scale spark_worker=2


echo "Get address..."

export NODE=$(docker service ps --format "{{.Node}}" spark_master)

#docker-machine ip $NODE
nslookup $NODE

echo
docker node ls
docker stack services spark

#!/bin/bash


echo "Spinning up three droplets..."

# for i in 1 2 3; do
#   docker-machine create \
#     --driver digitalocean \
#     --digitalocean-access-token $DIGITAL_OCEAN_ACCESS_TOKEN \
#     --engine-install-url "https://releases.rancher.com/install-docker/19.03.9.sh" \
#     node-$i;
# done


echo "Initializing Swarm mode..."

# docker-machine ssh node-1 -- docker swarm init --advertise-addr $(docker-machine ip node-1)

# docker-machine ssh node-1 -- docker node update --availability drain node-1

docker swarm init --advertise-addr $(hostname -i)


echo "Token to add nodes to the Swarm..."

#TOKEN=`docker-machine ssh node-1 docker swarm join-token worker | grep token | awk '{ print $5 }'`
TOKEN=`docker swarm join-token worker | grep token | awk '{ print $5 }'`
echo "TOKEN={$TOKEN}"

# docker-machine ssh node-2 "docker swarm join --token ${TOKEN} $(docker-machine ip node-1):2377"
# docker-machine ssh node-3 "docker swarm join --token ${TOKEN} $(docker-machine ip node-1):2377"


echo "Deploying Spark..."

#eval $(docker-machine env node-1)
#export EXTERNAL_IP=$(docker-machine ip node-2)

export EXTERNAL_IP=$(hostname -i)

docker stack deploy --compose-file=docker-swarm.yml rf-bench
docker service scale rf-bench_worker=2


echo "Get address..."

export NODE=$(docker service ps --format "{{.Node}}" rf-bench_master)

#docker-machine ip $NODE
nslookup $NODE

echo
docker node ls
docker stack services rf-bench

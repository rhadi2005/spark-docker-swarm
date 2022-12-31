#!/bin/bash

#docker swarm leave --force
#docker network rm cluster-net

echo 
echo "docker swarm init"

docker swarm init \
    --advertise-addr $(hostname -i) \
    --default-addr-pool 10.200.0.0/24

docker swarm join-token manager


# docker network create \
# 	--driver overlay \
# 	--attachable \
# 	--subnet=10.200.0.0/26 \
# 	--gateway=10.200.0.1 \
# 	cluster-net


echo
echo "docker stack deploy -c docker-swarm.yml spark"
docker stack deploy -c docker-swarm.yml spark

echo
echo "docker stack services spark"
docker stack services spark

# docker login -u rhadi2005
# docker login

# docker network ls
# docker network inspect cluster-net

echo
echo "docker node ls"
docker node ls

echo
echo "docker network ls"
docker network ls

echo
echo "docker ps"
docker ps

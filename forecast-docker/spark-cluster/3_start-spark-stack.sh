#!/bin/bash

#docker network rm overlay-net

export EXTERNAL_IP=$(hostname -i)


# docker network create \
# 	--driver overlay \
# 	--attachable \
# 	--subnet=10.200.0.0/26 \
# 	--gateway=10.200.0.1 \
# 	overlay-net

echo
echo "docker pull rhadi2005/forecast:latest + debug"
docker pull rhadi2005/forecast:latest
docker pull rhadi2005/forecast:debug

echo
echo "docker stack deploy -c docker-swarm.yml spark"
docker stack deploy -c docker-swarm.yml spark

echo
echo "docker stack services spark"
docker stack services spark

# docker login -u rhadi2005
# docker login

# docker network ls
# docker network inspect overlay-net

echo
echo "docker node ls"
docker node ls

echo
echo "docker network ls"
docker network ls

echo
echo "docker ps"
docker ps

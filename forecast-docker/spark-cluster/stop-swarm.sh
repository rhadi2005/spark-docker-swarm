#!/bin/bash

docker service rm spark_master
docker stack rm spark

#docker network rm spark-net

docker swarm leave --force 

docker network ls

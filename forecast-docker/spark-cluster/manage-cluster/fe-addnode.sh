#!/bin/bash

export WORKER_IP="${1}"
export MANAGER_IP="$(hostname -i):2377"

echo "Adding the node ${WORKER_IP} to the Swarm manager ${MANAGER_IP} ..."

#TOKEN=`docker-machine ssh node-1 docker swarm join-token worker | grep token | awk '{ print $5 }'`
TOKEN=`docker swarm join-token worker | grep token | awk '{ print $5 }'`
echo "TOKEN={$TOKEN}"

#kill all containers
#ssh -o "StrictHostKeyChecking no" -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} "docker kill $(docker ps -aq)"

#remotely add worker to docker swarm stack
ssh -o "StrictHostKeyChecking no" \
    -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} \
    "docker swarm leave --force"

ssh -o "StrictHostKeyChecking no" \
    -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} \
    "sudo sshfs -o allow_other,IdentityFile=/home/cloud/.ssh/key-vmfe.pem cloud@10.50.0.194:/home/cloud/dataset /home/cloud/dataset"

ssh -o "StrictHostKeyChecking no" \
    -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} \
    "docker swarm join --token ${TOKEN} ${MANAGER_IP} && \
     dataset/workspace/docker/spark-docker-swarm/forecast-docker/spark-cluster/5_start-spark-worker.sh"

#list docker swarm stack
docker node ls

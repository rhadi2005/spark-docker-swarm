#!/bin/bash

export WORKER_IP="${1}"

echo "docker ps on ${WORKER_IP} ..."

#remotely list running containers
ssh -o "StrictHostKeyChecking no" -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} "docker ps ${2}"


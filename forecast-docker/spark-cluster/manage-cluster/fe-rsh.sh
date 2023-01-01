#!/bin/bash

export WORKER_IP="${1}"
export COMMAND="${2}"

echo "remote shell on ${WORKER_IP} ..."

#remotely list running containers
ssh -o "StrictHostKeyChecking no" -i ~/.ssh/key-vmfe.pem cloud@${WORKER_IP} ${COMMAND}


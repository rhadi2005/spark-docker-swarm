#https://docs.docker.com/engine/swarm/services/

export EXTERNAL_IP=$(hostname -i)

echo
echo "docker pull rhadi2005/forecast:latest + debug"
docker pull rhadi2005/forecast:latest
docker pull rhadi2005/forecast:debug

echo "docker stack services spark"
docker stack services spark

echo
echo "docker service ls"
docker service ls

echo
echo "docker service logs spark_master"
docker service logs spark_master

#echo
#echo "docker service inspect spark_master network"
#docker service inspect spark_master --format='{{json .Endpoint.VirtualIPs}}' | jq .
#docker service inspect spark_master --format='{{json .Endpoint.VirtualIPs}}' | jq .[0]

echo
echo "docker network ls"
docker network ls

# echo
# echo "docker node ls"
# docker node ls

# echo
# echo "docker ps"
# docker ps


echo 
echo "nvidia-docker run spark_worker"

# nvidia-docker run -it --rm \
#   --network spark_overlay-net \
#   --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
#   --user root \
#   rhadi2005/forecast:latest \
#   'bash scripts/start-worker.sh ecs-python2:7077'

#nvidia-docker run -it --rm \
nvidia-docker run -it --rm \
  --name spark_worker${1} \
  --hostname spark_worker${1} \
  --network spark_overlay-net \
  --env SPARK_WORKER_CORES=2 \
  --env SPARK_WORKER_MEMORY=16G \
  --env SPARK_WORKER_INSTANCES=4 \
  --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
  --user root \
  rhadi2005/forecast:debug \
  'bash scripts/start-worker.sh 10.50.0.164:7077 && bash'

#  --publish 8082:8081/tcp \


# docker service update \
#   --network-add overlay-net \
#   spark_master

#   --network-rm overlay-net \
#   --network overlay-net \
#   --ip 10.200.0.2 \



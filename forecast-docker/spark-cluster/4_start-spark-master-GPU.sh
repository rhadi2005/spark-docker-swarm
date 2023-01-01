#https://docs.docker.com/engine/swarm/services/

export EXTERNAL_IP=$(hostname -i)

echo "docker stack services spark"
docker stack services spark

echo
echo "docker service ls"
docker service ls

echo
echo "docker service logs spark_master"
docker service logs spark-master

echo
echo "docker service inspect spark_master network"
docker service inspect spark_master --format='{{json .Endpoint.VirtualIPs}}' | jq .
#docker service inspect spark_master --format='{{json .Endpoint.VirtualIPs}}' | jq .[0]

echo
echo "docker network ls"
docker network ls

echo
echo "docker node ls"
docker node ls

# echo
# echo "docker ps"
# docker ps


echo 
echo "nvidia-docker run spark_master"

# nvidia-docker run -it --rm \
#   --network spark_overlay-net \
#   --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
#   --user root \
#   rhadi2005/forecast:latest \
#   'bash scripts/start-worker.sh ecs-python2:7077'

#nvidia-docker run -it --rm \
nvidia-docker run -it --rm \
  --name spark_master \
  --hostname spark_master \
  --network spark_overlay-net \
  --publish 8088:8088/tcp \
  --publish 7077:7077/tcp \
  --env SPARK_MASTER_HOST=0.0.0.0 \
  --env SPARK_MASTER_PORT=7077 \
  --env SPARK_MASTER_WEBUI_PORT=8088 \
  --env SPARK_PUBLIC_DNS=${EXTERNAL_IP} \
  --env SPARK_DRIVER_CORES=2 \
  --env SPARK_DRIVER_MEMORY=16G \
  --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
  --user root \
  rhadi2005/forecast:latest \
  'bash scripts/start-spark.sh'

#  --publish 8082:8081/tcp \


# docker service update \
#   --network-add overlay-net \
#   spark_master

#   --network-rm overlay-net \
#   --network overlay-net \
#   --ip 10.200.0.2 \



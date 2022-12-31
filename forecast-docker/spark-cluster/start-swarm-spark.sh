#https://docs.docker.com/engine/swarm/services/

echo "docker stack services spark"
docker stack services spark

echo
echo "docker service ls"
docker service ls
#docker service logs --follow spark-master

echo 
echo "docker service rm & create spark"

docker service rm spark

docker service create \
  --name spark_master \
  --hostname spark_master \
  --network spark_overlay-net \
  --publish 8088:8080/tcp \
  --publish 7077:7077/tcp \
  --host ecs-python2:10.50.0.194 \
  --host ecs-python:10.50.0.8 \
  --limit-memory=4GB \
  --env SPARK_NO_DAEMONIZE=true \
  --env SPARK_MASTER_HOST=0.0.0.0 \
  --env SPARK_MASTER_PORT=7077 \
  --env SPARK_MASTER_WEBUI_PORT=8080 \
  --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
  --user root \
  rhadi2005/forecast:latest \
  'bash $SPARK_HOME/sbin/start-master.sh'

#bash $SPARK_HOME/sbin/start-master.sh

  # 'bash dataset/fallback.sh'
  # --entrypoint 'bash dataset/workspace/docker/spark-docker-swarm/forecast-docker/build/entrypoint.sh' \


  # --entrypoint 'bash dataset/workspace/docker/spark-docker-swarm/forecast-docker/build/entrypoint.sh' \
  # --entrypoint 'bash dataset/falllback.sh' \


#docker service inspect spark-master

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

echo
echo "docker ps"
docker ps

# docker service update \
#   --network-add cluster-net \
#   spark-master

#   --network-rm nginx-net \
#   --network cluster-net \
#   --ip 10.200.0.2 \


# docker service create \
#     --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
#     --name forecast \
#     --hostname forecast \
#     --network spark_overlay-net \
#     --publish 8895:8888/tcp \
#     --user root \
#     rhadi2005/forecast \
#     'bash dataset/fallback.sh'

#     bash

# docker run -it --rm \
#     --mount type=bind,source="$(pwd)/../..",target=/home/forecast/mnt \
#     --name forecast \
#     --hostname forecast \
#     --network spark_overlay-net \
#     --user root \
#     rhadi2005/forecast \
#     bash


cd ${SPARK_HOME} && bin/spark-class org.apache.spark.deploy.master.Master -h 0.0.0.0
cd ${SPARK_HOME} && bin/spark-class org.apache.spark.deploy.worker.Worker spark://master:7077

SPARK_WORKER_INSTANCES


docker swarm init --advertise-addr $(hostname -i) --default-addr-pool 10.200.0.0/24
docker swarm leave --force

docker swarm join-token manager

docker swarm join --token <manager-token>
docker swarm join --token <worker-token>

docker node ls

docker network create \
	--driver overlay \
	--attachable \
	--subnet=10.200.0.0/24 \
	--gateway=10.200.0.254 \
	cluster-net

docker network ls
docker network inspect cluster-net
docker network rm cluster-net

docker login registry.example.com

docker service rm

docker service rm rover-cluster

docker service create \
  --name rover-cluster \
  --hostname rover01 \
  --network cluster-net \
  --publish 8088:80/tcp \
  --limit-memory=4GB \
  --env MYVAR=foo \
  --mount type=bind,source="$(pwd)",target=/tf/caf \
  rhadi2005/rover-new:latest \
  bash

docker service  create \
  --name my_service \
  --hostname myredis \
  --network my-network \
  --publish 8080:80/tcp \
  --publish published=8080,target=80,mode=host|ingress(default) \
  --add-host remotehostname:10.200.0.3 \
  --mode global | replicated \
  --replicas=5 \
  --replicas-max-per-node 10 \
  --env MYVAR=foo \
  --env MYVAR2=bar \
  --label com.example.foo="bar" \
  --constraint node.platform.os==linux \
  --constraint node.labels.type==queue \  
  --constraint node.role=manager|worker \
  --constraint node.hostname!=ecs-xxx \
  --reserve-memory=4GB \
  --limit-memory=4GB \
  --mount type=volume,source=my-volume,destination=/path/in/container,volume-label="color=red",volume-label="shape=round" \
  --with-registry-auth \
  registry.example.com/acme/my_image:latest


You can narrow the kind of nodes your task can land on through the using the --generic-resource flag (if the nodes advertise these resources):
docker service create \
    --name cuda \
    --generic-resource "NVIDIA-GPU=2" \
    --generic-resource "SSD=1" \
    nvidia/cuda

Running as a job

Jobs are a special kind of service designed to run an operation to completion and then stop, 
as opposed to running long-running daemons.
docker service create \
   --name myjob \
   --mode replicated-job | global-job \
   bash "true"

Set service mode (--mode)
The service mode determines whether this is a replicated service or a global service. 
A replicated service runs as many tasks as specified, 
while a global service runs on each active node in the swarm.


docker service ls

docker service scale service1=50 service2=3

docker 


https://docs.docker.com/config/containers/container-networking/

When the container starts, it can only be connected to a single network, using --network. However, you can connect a running container to multiple networks using docker network connect. When you start a container using the --network flag, you can specify the IP address assigned to the container on that network using the --ip or --ip6 flags.

When you connect an existing container to a different network using docker network connect, you can use the --ip or --ip6 flags on that command to specify the container’s IP address on the additional network.

In the same way, a container’s hostname defaults to be the container’s ID in Docker. You can override the hostname using --hostname. When connecting to an existing network using docker network connect, you can use the --alias flag to specify an additional network alias for the container on that network.



To create an overlay network which can be used by swarm services or standalone containers to communicate with other standalone containers running on other Docker daemons, add the --attachable flag:

docker network create -d overlay --attachable my-attachable-overlay

You can name your ingress network something other than ingress, but you can only have one. An attempt to create a second one fails.

docker network create \
  --driver overlay \
  --ingress \
  --subnet=10.11.0.0/16 \
  --gateway=10.11.0.2 \
  --opt com.docker.network.driver.mtu=1200 \
  my-ingress


Swarm mode CLI commands

Explore swarm mode CLI commands

    swarm init
    swarm join
    service create
    service inspect
    service ls
    service rm
    service scale
    service ps
    service update


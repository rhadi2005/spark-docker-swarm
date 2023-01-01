

10.50.0.247
10.50.0.144
10.50.0.117

./fe-addnode.sh 10.50.0.247
./fe-addnode.sh 10.50.0.144
./fe-addnode.sh 10.50.0.117

./fe-ps.sh 10.50.0.247
./fe-ps.sh 10.50.0.144
./fe-ps.sh 10.50.0.117

./fe-rsh.sh 10.50.0.247 'dataset/workspace/docker/spark-docker-swarm/forecast-docker/spark-cluster/5_start-spark-worker.sh'
./fe-rsh.sh 10.50.0.144 'dataset/workspace/docker/spark-docker-swarm/forecast-docker/spark-cluster/5_start-spark-worker.sh'
./fe-rsh.sh 10.50.0.117 df

./fe-rsh.sh 10.50.0.247 'ls -l dataset'
./fe-rsh.sh 10.50.0.144 'ls -l dataset'
./fe-rsh.sh 10.50.0.117 'ls -l dataset'

./fe-rsh.sh 10.50.0.247 'docker kill '
./fe-rsh.sh 10.50.0.144 'docker kill 986820a902d9'
./fe-rsh.sh 10.50.0.117 'ls -l dataset'

ssh -i ~/.ssh/key-vmfe.pem cloud@10.50.0.247
ssh -i ~/.ssh/key-vmfe.pem cloud@10.50.0.144
ssh -i ~/.ssh/key-vmfe.pem cloud@10.50.0.117

docker ps
dataset/workspace/docker/spark-docker-swarm/forecast-docker/spark-cluster/5_start-spark-worker.sh

#!/bin/bash
#
# 

export SPARK_WORKER_OPTS="-Dspark.worker.resource.gpu.amount=1 " 
export SPARK_WORKER_OPTS="${SPARK_WORKER_OPTS} -Dspark.worker.resource.gpu.discoveryScript=${SPARK_HOME}/examples/src/main/scripts/getGpusResources.sh"

echo
echo "Spark configuration"
echo "==================="
echo
echo "SPARK_HOME=${SPARK_HOME}"
echo "SPARK_CONF_DIR=${SPARK_CONF_DIR}"
echo "SPARK_NO_DAEMONIZE=${SPARK_NO_DAEMONIZE}"
echo "SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS}"
echo 
echo "SPARK_MASTER_HOST=${SPARK_MASTER_HOST}"
echo "SPARK_MASTER_PORT=${SPARK_MASTER_PORT}"
echo "SPARK_MASTER_WEBUI_PORT=${SPARK_MASTER_WEBUI_PORT}"
echo "SPARK_DRIVER_MEMORY=${SPARK_DRIVER_MEMORY}"
echo "SPARK_DRIVER_MAXRESULTSIZE=${SPARK_DRIVER_MAXRESULTSIZE}"
echo
echo "SPARK_WORKER_CORES=${SPARK_WORKER_CORES}"
echo "SPARK_WORKER_MEMORY=${SPARK_WORKER_MEMORY}"
echo "SPARK_WORKER_PORT=${SPARK_WORKER_PORT}"
echo "SPARK_WORKER_WEBUI_PORT=${SPARK_WORKER_WEBUI_PORT}"
echo "SPARK_WORKER_INSTANCES=${SPARK_WORKER_INSTANCES}"
echo "SPARK_WORKER_OPTS=${SPARK_WORKER_OPTS}"
echo
echo "Spark application configuration, this should be set by the application"
echo "======================================================================"
echo "SPARK_EXECUTOR_MEMORY=${SPARK_EXECUTOR_MEMORY}"
echo "SPARK_EXECUTOR_RESOURCE_GPU_AMOUNT=${SPARK_EXECUTOR_RESOURCE_GPU_AMOUNT}"
echo
echo "============================================================================================="

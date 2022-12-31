#!/bin/bash
#
#

ML_JAR=/root/.m2/repository/rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar
PLUGIN_JAR=/root/.m2/repository/rapids-4-spark_2.12-22.08.0-SNAPSHOT.jar

ML_JAR=/tmp/lib/cudf-22.06.0-cuda11.jar
rapids-4-spark_2.12-22.06.0.jar

$SPARK_HOME/bin/spark-submit \
--master spark://127.0.0.1:7077  \
--conf spark.executor.cores=12         \
--conf spark.executor.instances=2      \
--driver-memory 30G          \
--executor-memory 30G          \
--conf spark.driver.maxResultSize=8G          \
--conf spark.rapids.sql.enabled=true \
--conf spark.plugins=com.nvidia.spark.SQLPlugin \
--conf spark.rapids.memory.gpu.allocFraction=0.35 \
--conf spark.rapids.memory.gpu.maxAllocFraction=0.6 \
--conf spark.task.resource.gpu.amount=0.08 \
--conf spark.executor.extraClassPath=$ML_JAR:$PLUGIN_JAR \
--conf spark.driver.extraClassPath=$ML_JAR:$PLUGIN_JAR \
--conf spark.executor.resource.gpu.amount=1  \
--conf spark.rpc.message.maxSize=2046 \
--conf spark.executor.heartbeatInterval=500s \
--conf spark.network.timeout=1000s \
--jars $ML_JAR,$PLUGIN_JAR 

#--class com.nvidia.spark.examples.pca.Main \
#/workspace/target/PCAExample-22.08.0-SNAPSHOT.jar


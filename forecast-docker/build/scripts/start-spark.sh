#!/bin/bash
#
#

export SPARK_NO_DAEMONIZE=true
$SPARK_HOME/spark-env.sh

$SPARK_HOME/sbin/start-master.sh


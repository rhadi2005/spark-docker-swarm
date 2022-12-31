#!/bin/bash
#
#

$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-slave.sh spark://127.0.0.1:7077

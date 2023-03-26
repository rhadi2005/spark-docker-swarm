#FROM debian:jessie
FROM debian:bullseye

# command to build the container image & upload to docker hub
#docker build -t rhadi2005/spark-swarm:3.1.2 .
#docker login -u rhadi2005
#docker push rhadi2005/spark-swarm:3.1.2


RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y \
        net-tools \
        iputils-ping \
        dnsutils \
        apt-utils \
        vim \
        curl \
        wget \
        git \
        unzip \
        zip

RUN apt-get install -y python3 r-base pip && \
    ln -s /usr/bin/python3 /usr/bin/python

# RUN apt-get install -y python3 python3-setuptools \
#   && ln -s /usr/bin/python3 /usr/bin/python \
#   && easy_install3 pip py4j \

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

WORKDIR /tmp

# JAVA
ARG JAVA_MAJOR_VERSION=8
#ARG JAVA_UPDATE_VERSION=131
ARG JAVA_UPDATE_VERSION=351
ARG JAVA_BUILD_NUMBER=11
#ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV JAVA_HOME /usr/jre1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
# RUN curl -sL --retry 3 --insecure \
#   --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
#   "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \

#hardcode url to download JRE Version 8 Update 351, 18 octobre 2022 
RUN echo "JAVA_HOME=${JAVA_HOME}" && \
    wget --no-verbose -O jre-8u351-linux-x64.tar.gz "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247127_10e8cce67c7843478f41411b7003171c" && \
    gunzip jre-8u351-linux-x64.tar.gz && \
    tar xf jre-8u351-linux-x64.tar && \ 
    mv jre1.8.0_351 /usr/ && \
    ln -s $JAVA_HOME /usr/java && \
    rm -rf $JAVA_HOME/man


# #install spark-3.1.2-bin-hadoop3.2

# # HADOOP
ENV HADOOP_VERSION 3.2.2
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
 && rm -rf $HADOOP_HOME/share/doc \
 && chown -R root:root $HADOOP_HOME

# SPARK
#ENV SPARK_VERSION 3.0.2
ENV SPARK_VERSION 3.1.2

ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME

WORKDIR $SPARK_HOME

#!/bin/bash
#
# Copyright (c) 2021-2022, NVIDIA CORPORATION. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#container name : nvspark/pca:0.1
#build : docker build -f Dockerfile -t nvspark/pca:0.1 .
#run : nvidia-docker run -it nvspark/pca:0.1 bash

#ARG CUDA_VER=11.5.1
#FROM nvidia/cuda:${CUDA_VER}-devel-ubuntu20.04
ARG BRANCH_VER=22.06

ARG CUDA_VERSION=11.5
ARG LINUX_VERSION=ubuntu20.04
ARG PYTHON_VERSION=3.8
#ARG CUDA_VERSION=10.2
#ARG LINUX_VERSION=ubuntu16.04
FROM rapidsai/rapidsai:22.06-cuda${CUDA_VERSION}-runtime-${LINUX_VERSION}-py${PYTHON_VERSION}


RUN apt-get update
#RUN apt-get install -y wget ninja-build git

#ENV PATH="/root/miniconda3/bin:${PATH}"
#ARG PATH="/root/miniconda3/bin:${PATH}"

#anaconda alrady installed on our VM 
#RUN wget --quiet \
#    https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh \
#    && mkdir /root/.conda \
#    && bash Miniconda3-py38_4.10.3-Linux-x86_64.sh -b \
#    && rm -f Miniconda3-py38_4.10.3-Linux-x86_64.sh \
#    && conda init

SHELL ["conda", "run", "--no-capture-output", "-n", "base", "/bin/bash", "-c"]
RUN echo $PATH
RUN echo $CONDA_PREFIX
RUN conda --version

#RUN conda install -c conda-forge openjdk=8 maven -y

# install cuDF dependency.
# not needed, we are using the default version in RAPIDS container
#RUN conda install -c rapidsai-nightly -c nvidia -c conda-forge cudf=${BRANCH_VER} python=3.8 -y
RUN conda install -y -c rapidsai -c nvidia -c conda-forge -c plotly cudf pyspark findspark dash plotly

# install CUDA Toolkit(>=11.0)
#conda install -y -c rapidsai -c nvidia -c conda-forge cudatoolkit

# copy rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar to container /root/.m2/repository

RUN cd /root \
    && mkdir .m2 \
    && mkdir repository
    
ADD rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar /root/.m2/repository

ADD notebooks/Spark_PCA_End_to_End.ipynb /workspace/
ADD notebooks/Spark_PCA_End_to_End.ipynb /rapids/notebooks/pca/

# install spark-3.1.2-bin-hadoop3.2
RUN cd /tmp \
    && wget --quiet \
    https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz \
    && tar -xzf spark-3.1.2-bin-hadoop3.2.tgz -C /opt/ \
    && rm spark-3.1.2-bin-hadoop3.2.tgz

ENV SPARK_HOME=/opt/spark-3.1.2-bin-hadoop3.2

# add spark env to conf
ADD spark-env.sh /opt/spark-3.1.2-bin-hadoop3.2/conf/
ADD start-spark.sh /workspace/
ADD spark-submit.sh /workspace/

#WORKDIR /workspace
WORKDIR /rapids/notebooks/host


#container name : rhadi2005/forecast
#build : docker build -f Dockerfile -t rhadi2005/forecast .
#run : nvidia-docker run -it --rm --hostname master rhadi2005/forecast bash

#to push to docker hub registry
#docker login => circlebi or rhadi2005
#docker tag local-image:tagname new-repo:tagname
#docker push new-repo:tagname

#USER = root

#FROM must be the 1st of dockerfile command line
#use FROM scratch if there is no container image base
#FROM scratch 

#https://hub.docker.com/r/rapidsai/rapidsai/
#https://kb.brightcomputing.com/knowledge-base/how-do-i-create-docker-images-to-use-nvidia-gpus-with-spark-and-xgboost-via-rapids/

#NVIDIA RAPIDS AI container as base image
FROM rapidsai/rapidsai:22.06-cuda11.5-runtime-ubuntu20.04-py3.8

#TODO : assign current user uid & gid
#RUN export USER_UID=$(id -u) \
#    && export USER_GID=$(id -g)

ARG USERNAME=forecast
ARG GRPNAME=forecast
ARG USER_UID=1002 
ARG USER_GID=1003

RUN echo "USERNAME=${USERNAME}" \
    && echo "GRPNAME=${GRPNAME}" \ 
    && echo "USER_UID=${USER_UID}" \
    && echo "USER_GID=${USER_GID}" \ 
    && echo "UID=${UID}"  


RUN echo "Building rhadi2005/forecast container image" \
    && pwd \
    && apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y \
        apt-utils \
        net-tools \
        lsb-core \
        iputils-ping \
        dnsutils \
        vim \
        curl \
        wget \
        git \
        unzip \
        zip \
        sudo

RUN echo "Creating user: ${USERNAME} ..." && \
    groupadd docker && \ 
    groupadd -g ${USER_GID} ${GRPNAME} && \  
    useradd -m -g ${GRPNAME} -G docker,sudo -u ${USER_UID} ${USERNAME}
 
RUN echo "${USERNAME}:Flexible123" | chpasswd \
    && echo 'll && id && echo' >> /home/${USERNAME}/.bashrc \
    && echo 'lsb_release -d && echo' >> /home/${USERNAME}/.bashrc \
    && echo 'source activate rapids' >> /home/${USERNAME}/.bashrc \
    && echo 'conda env list' >> /home/${USERNAME}/.bashrc 
    
RUN usermod -aG sudo ${USERNAME} \
    && echo '%sudo   ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

# TODO : install JRE => already installed in rapidsai base image ?
#RUN conda install -c conda-forge openjdk=8 maven -y

RUN source activate rapids \
    && conda update -n base conda \
    && conda install -y -c rapidsai -c nvidia cudf \
    && conda install -y -c conda-forge dask pyspark findspark dash pmdarima \
    && conda install -y -c plotly plotly \
    && conda install -y -c anaconda xlrd

WORKDIR /tmp

# install spark-3.1.2-bin-hadoop3.2
RUN wget --quiet \
    https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz \
    && tar -xzf spark-3.1.2-bin-hadoop3.2.tgz -C /opt/ \
    && rm spark-3.1.2-bin-hadoop3.2.tgz \
    && ln -s /opt/spark-3.1.2-bin-hadoop3.2 /opt/spark-3.1.2

ENV JAVA_HOME=/opt/conda/envs/rapids
ENV SPARK_HOME=/opt/spark-3.1.2

# copy nvidia-rapids-spark & cudf jar to container /root/.m2/repository
ADD lib/spark/rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar /root/.m2/repository/
#ADD /home/cloud/dataset/lib/spark/cudf-22.06.0.jar /root/.m2/repository
ADD lib/spark/cudf-22.06.0-cuda11.jar /root/.m2/repository

# add spark env to conf
# /opt/spark-3.1.2-bin-hadoop3.2/sbin
ADD scripts/spark-env.sh /opt/spark-3.1.2/

ADD scripts/start-spark.sh /home/${USERNAME}/scripts/
ADD scripts/spark-submit.sh /home/${USERNAME}/scripts/
ADD scripts/nvidia-gpu-driver-check.sh /home/${USERNAME}/scripts/

# add docker container files
ADD environment-for-docker.yml /home/${USERNAME}/
ADD entrypoint.sh /home/${USERNAME}/

RUN chown ${USERNAME}:${GRPNAME} -R /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

#RUN conda update -n base conda \
#    && conda init bash 

ENTRYPOINT ["bash","./entrypoint.sh"]




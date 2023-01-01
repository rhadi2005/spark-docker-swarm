#!/bin/bash

nvidia-docker run -it --rm  \
    --name forecast \
    --hostname forecast \
    --mount type=bind,source=/home/cloud/dataset,target=/home/forecast/dataset \
    rhadi2005/forecast \
    bash


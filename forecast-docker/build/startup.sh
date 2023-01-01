#!/bin/bash

#nvidia-
docker run -it --rm \
    --mount type=bind,source="$(pwd)/../..",target=/home/forecast/mnt \
    --hostname forecast \
    rhadi2005/forecast \
    ls

#    bash

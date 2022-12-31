#!/bin/bash

nvidia-
docker run -it --rm \
    --mount type=bind,source="$(pwd)/../..",target=/rapids/notebooks/host \
    --hostname forecast \
    rhadi2005/forecast \
    ls

    bash

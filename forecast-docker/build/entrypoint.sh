#!/bin/bash

scripts/nvidia-gpu-driver-check.sh

#activating the conda environment
# source activate rapids
# conda env list

#conda install -y -c conda-forge -c anaconda --file environment-for-docker.yml 
#pip install dash-dangerously-set-inner-html

#cd /rapids/census_demo/plotly_demo
pwd

#stop jupyter-lab started by the rapids container & start a new one to use the current conda environment
# ex pyspark, dash, ...
ps -C jupyter-lab | awk '$4=="jupyter-lab" {print "kill "$1}' | bash

echo
echo "jupyter-lab --allow-root --ip=0.0.0.0 --no-browser --NotebookApp.token= --NotebookApp.allow_origin=*"

# This script can either be a wrapper around arbitrary command lines,
# or it will simply exec bash if no arguments were given
if [[ $# -eq 0 ]]; then
  exec "/bin/bash"
else
  export CUSTOM_COMMAND="$@"
  echo "running '${CUSTOM_COMMAND}'"
  echo "${CUSTOM_COMMAND}"
  eval "${CUSTOM_COMMAND}"
fi


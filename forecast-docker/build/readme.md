
https://github.com/NVIDIA/nvidia-docker/issues/1268


nvidia-docker run -it rapidsai/rapidsai:22.06-cuda11.5-runtime-ubuntu20.04-py3.8 bash
=>
A JupyterLab server has been started!
To access it, visit http://localhost:8888 on your host machine.
Ensure the following arguments were added to "docker run" to expose the JupyterLab server to your host machine:
      -p 8888:8888 -p 8787:8787 -p 8786:8786
Make local folders visible by bind mounting to /rapids/notebooks/host


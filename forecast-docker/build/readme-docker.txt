Setting up a Docker Swarm with GPUs

https://docs.docker.com/compose/gpu-support/

https://developer.nvidia.com/blog/nvidia-docker-gpu-server-application-deployment-made-easy/

https://gist.github.com/tomlankhorst/33da3c4b9edbde5c83fc1244f010815c


https://www.google.fr/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjOlL6kiaD8AhWxVaQEHehkDh4QFnoECBwQAQ&url=https%3A%2F%2Fobject-storage-ca-ymq-1.vexxhost.net%2Fswift%2Fv1%2F6e4619c416ff4bd19e1c087f27a43eea%2Fwww-assets-prod%2Fpresentation-media%2FOpenStack-Boston-Summit-Presentation.pdf&usg=AOvVaw2aTax3xH4itKSMHYjMZ-nC


https://forums.docker.com/t/using-nvidia-gpu-with-docker-swarm-started-by-docker-compose-file/106688
docker compose: 
i can deploy it to the stack but it cannot find any nodes to run the images

version: '3.7'
services:
  test:
    image: nvidia/cuda:10.2-base
    command: nvidia-smi
    deploy:
      resources:
        reservations:
          devices:
          - driver: nvidia
            count: 1
            capabilities: [gpu, utility]

version: '3.7'
services:
  test:
    image: nvidia/cuda:10.2-base
    command: nvidia-smi -l
    deploy:
      resources:
        limits:
          cpus: '0.1'
          memory: 500M
        reservations:
          cpus: '0.001'
          memory: 200M
          generic_resources:
            - discrete_resource_spec:
                kind: 'gpu'
                value: 1
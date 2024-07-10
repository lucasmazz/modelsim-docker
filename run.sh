#!/bin/bash

# Check if program and project path are provided
if [ -z "$1" ]; then
  echo "Usage: ./run.sh <project_path>"
  exit 1
fi

# Set project path
PROJECT_PATH=$1

# Run the Docker container
docker run -it --net=host --ipc=host \
           -e DISPLAY=$DISPLAY \
           -e XAUTHORITY=/tmp/.XAuthority \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v $XAUTHORITY:/tmp/.XAuthority \
           -v ${PROJECT_PATH}:/home/docker/project \
           -u $(id -u):$(id -g) \
           modelsim:20.1
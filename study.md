# *This file contains relevant study topics to the project*

# 1 Docker
    Docker is an open platform used to develop, ship and run apps. Docker allows you to separate apps from infrastructure, so you can deliver softwares faster. Using docker allows you to manage infra the same way you manage the app code, and by that, you can significantly reduce the delay between writing code and deploying in prod.

## 1.1 Docker Objects:
### 1.1.1 Docker Images
    An image is an read-only template with instructions for creating a Docker container. You might create your own images or use those created by others and published. To build an image, you must create a Dockerfile with a simple syntax for definig the steps needed to create the image and run it. Each instruction in a Dockerfile creates a layer in the image. When you change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt (this avoid heavy and slow builds).

### 1.1.2 Docker Containers
    A container is a runnable instance of an image (the executable in another words). You can create, start, stop, move, or delete a container using the Docker API or CLI. You can connect a container to on or more networks, attach storage to it (Data Bases), or even create a new image based on its current state.

    By default, a container is relatively well isolated from other containers and its host machine. You can control how isolated a container's network, storage, or other underlying subsystems are grom other containers or from the host machine.

    A container is defined by its image as well as any configuration options you provide to it when you create or start it. When a container is removed, any changes to its state that aren't stored in persistent storage disappear.

Example *storage run* comand

    The following command runs an *ubuntu* container, attaches interactively to your local command-line session, and runs (bold)/bin/bash(bold)

    (green)$(green) docker run -i -t ubuntu /bin/bash

    This will:
        - if you don't have the ubuntu image locally, Docker pulls it from your configured registry;
        - create a new container;
        - Docker allocates a read-write filesystem to the container, as its final layer;
        - Docker creates a network interface to connect the container to the default network, since you didn't specify any networking options (assign an IP address to the container);
        - Docker starts the container and executes /bin/bash;
        - When you run exit to terminate the /bin/bash command, the container stops but isn't removed.

### 1.1.3 Docker Volumes
    Volumes are persistent data stores for containers, created and managed by Docker. You can create a volume explicitly user (bold)docker volume create(bold) command, or Docker can create a volume during container or service creation.

    When you create a volume, it's stored within a directory on the Docker host. When you mount the volume into a container, this directory is what's mounted into the container. This is similar to the way that bind mounts work, except that volumes are managed by Docker and are isolated from the core functionality of the host machine.

### 1.1.4 Docker Compose
    Docker Compose is a tool for defining and running multi-container apps. It is the key to unlocking a streamlined and efficient development and deployment experience.

    Compose simplifies the control of your entire app stack, making it easy to manage services, networks, and volumes in a single YAMLK configuration file. Then, with a single command, you create and start all the services from your configuration file.

    Compose works in all environments - prod, staging, development, testing, as well as CI workflows. It also has commands for managing the whole lifecycle of your app:
        - Start, stop, and rebuild services;
        - View the status of running services;
        - Stream the log output of running services;
        - Run a one-off command on a service;

### 1.1.5 Docker Network

## 1.2 Docker vs Virtual Machines

## 1.3 Docker Architectures


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

### 1.1.5 Docker Networking
    At its core, Docker networking is the system that allows Docker containers to communicate with each other, with the Docker host, and even with the outside world.
    When you create a container, Docker gives it its own isolated network environment. This means each container has its own IP address and network interfaces. By default, containers running on the same host can communicate between them without needing to expose ports to the host machine.

    - each container gets its own network namespace, complete with its own network interfaces, IP addresses and routing tables, and this is why a container can't see the network traffic of another container or the host.
    - to connect a container's isolated namespace to the host's network, Docker uses a veth pair (Virtual Ethernet Devices).
    - Docker uses the host's iptables rules (a firewall utility) to manage port mapping and network address translation (NAT). When you expose a port, iptables rules are created to forward traffic from one port to another inside the container.

    -Drivers:
        * bridge (Default): creates a private, internal network on the host.
        * host: this driver removes network isolation entirely.
        * none: this driver gives the container a network stack but attaches it to no network. Completely isolated and cannot communicate with any other container.
        *overlay: This driver is used for multi-host networking. It creates a distributed network that spans multiple Docker hosts, allowing containers on different hosts to communicate directly and securely.

    -Command:
        * docker network: is the main command that would allow you to create, manage and configure a Docker Network.
            - connect: connect a container to a network;
            - create: creates a network;
            - disconnect: disconnect a container from a network;
            - inspect: display detailed info on one or more networks;
            - ls: list networks;
            - prune: remove all unused networks;
            - rm: remove one or more networks;

## 1.2 Docker vs Virtual Machines
- VM:
    - Virtualizes hardware
    - Each VM runs its own full OS (Linux/Windows) and kernel
    - Managed by a hypervisor (VMware, VirtualBox, Hyper-V)
    - Boots like a real computer
    - Startup time: 30 seconds to several minutes
    - Each VM needs dedicated RAM and disk for a full OS
    - Strong isolation (hardware-level)
    - If one VM is compromised, others are usually safe
    - Can run any OS (on any host OS)
    - VM images are large (GBs)
    - Moving them is slow and heavy

- Docker container:
    - Virtualizes the operating system
    - Containers, share the host OS kernel and only include the app + dependencies
    - Starts a process, not an OS
    - Startup time: milliseconds to a few seconds
    - Containers share, host OS and libraries where possible
    - Much lower memory and disk usage
    - Process-level isolation
    - Containers share the kernel
    - Must use the host OS kernel, linux containers need Linux host
    - Images are smaller (MBs–hundreds of MBs)
    
## 1.3 Docker Architectures


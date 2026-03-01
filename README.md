# *This project has been created as part of the 42 curriculum by ncampbel*

# Inception
## 1- Description 

### Project Overwiew

Inception is a system administration project focused on building a small, secure infrastructure using Docker and Docker Compose.

The goal of the project is to containerize a WordPress website using:
- NGINX (as reverse proxy with TLS)
- WordPress (PHP-FPM)
- MariaDB (database)

The infrastructure is composed of:

- 3 Docker containers
    - NGINX
    - WordPress
    - MariaDB

- 2 Docker volumes
    - WordPress files
    - MariaDB database data

Each service runs inside its own container and communicates through a dedicated Docker network. The entire stack is orchestrated using docker-compose.yml.

The project enforces:

- No use of ready-made images (except base images like Alpine or Debian)
- Secure configuration (TLS, SSL, Secrets for credentials)
- Persistent storage
- Proper service isolation

### Use of Docker

Docker is used to:
- Isolate services
- Ensure reproducibility
- Simplify deployment
- Avoid dependency conflicts
- Provide portability across environments

Each service has:
- Its own Dockerfile
- Minimal base image (Debian bookworm)
- Custom configuration
- The containers are built from scratch (no preconfigured WordPress images).

### Sources Included in the Project

The infrastructure includes:

- NGINX
    - Configured with SSL (TLS)
    - Acts as reverse proxy
    - Only entry point exposed to host

- WordPress (PHP-FPM)
    - Installed manually
    - Configured to connect to MariaDB
    - Uses wp-config.php with environment variables

- MariaDB
    - Database server
    - Stores WordPress data
    - Secured with custom user and password

### 1.1- Virtual Machine vs Docker

Virtual Machines emulate hardware and include a full operating system, which makes them heavier, slower to start, and more resource-intensive. 
Docker, on the other hand, shares the host kernel and isolates applications at the process level, making containers lightweight, faster, and more efficient in terms of memory and storage.

### 1.2- Secrets vs Environment Variables
- Environment Variables:
    - Stored in docker-compose.yml or .env file
    - Visible in container environment
    - Easier to manage

- Docker Secrets:
    - More secure
    - Stored separately from container config
    - Not exposed as environment variables

#### Design Choice:
- For this project, environment variables are used (as required by subject), but in production environments Docker Secrets should be preferred for sensitive data like database passwords.
### 1.3- Docker Network vs Host Network
- Docker Network (Bridge)
    - Containers communicate via internal network
    - Isolated from host
    - More secure
    - Controlled exposure

- Host Network
    - Container shares host network stack
    - Less isolation
    - More security risks

 #### Design Choice:
- A custom Docker bridge network is used to:
    - Isolate services
    - Allow secure internal communication
    - Expose only NGINX to host

### 1.4- Docker Volumes vs Bind Mounts
- Docker Volumes
    - Managed by Docker
    - Stored in /var/lib/docker/volumes
    - Portable and safer
    - Recommended for production
- Bind Mounts
    - Linked directly to host filesystem
    - Useful for development
    - Less portable
#### Design Choice
- Docker volumes are used for:
    - WordPress files
    - MariaDB data
- This ensures:
    - Data persistence
    - Clean separation from host filesystem
    - Easier migration

## 2- Instructions

### 2.1 Installation

- Clone repository:
```bash
git clone https://github.com/nyykooo/Inception
cd inception
```
- Configure environment variables in .env file.

### 2.2 Build and Run

- Build:

```bash
make
```

- Run:

```bash
make up
```

- Stop Containers:

```bash
make down
```

### 2.3 Access WordPress

- Open browser:

``` https://ncampbel.42.fr ```

## 3- Resources

### Official Documentation:

- Ubuntu WordPress Tutorial
    - https://ubuntu.com/tutorials/install-and-configure-wordpress#1-overview
    - https://www.youtube.com/watch?v=0fjCW34EhfQ

- WP-CLI
    - https://wp-cli.org/
    - https://ubuntu.com/tutorials/install-and-configure-wordpress#1-overview
    - https://www.youtube.com/watch?v=0fjCW34EhfQ
    - https://wp-cli.org/

- Docker Documentation
    - https://docs.docker.com/

- NGINX Documentation
    - https://nginx.org/en/docs/

- MariaDB Documentation
    - https://mariadb.org/documentation/

### AI Usage:

- AI (ChatGPT) was used for:
    - Structuring the README
    - Explaining conceptual comparisons (VM vs Docker, Secrets vs Env Variables, etc.)
    - Clarifying networking and volume concepts
    - Reviewing documentation structure to comply with 42 requirements
- All configuration, debugging, and implementation were done manually.
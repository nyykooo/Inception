# USER DOCUMENTATION

## 1. Services Provided by the Stack

This infrastructure provides a complete WordPress website running with:

- **NGINX**  
  Acts as a secure reverse proxy (HTTPS only, port 443 exposed).

- **WordPress (PHP-FPM)**  
  The web application used to create and manage website content.

# Chapter VII — User Documentation

## Overview
- **Services provided:** The stack runs three main services:
  - `mariadb` — MySQL-compatible database for WordPress data.
  - `wordpress` — PHP application providing the website frontend and admin panel.
  - `nginx` — web server / reverse proxy (TLS) that exposes the site on port 443.

## Start and stop the project
Use the project's `Makefile` (recommended) or `docker-compose` directly.

- Start (build data dirs and images, then start services):

```
make build
make up
```

- Stop and remove containers, networks and volumes:

```
make down
```

- Quick alternatives with Docker Compose:

```
docker-compose -f ./docker-compose.yml up -d --build
docker-compose -f ./docker-compose.yml down -v --remove-orphans
```

## Access the website and administration panel
- By default the site is exposed via `nginx` on TCP port `443` (HTTPS). From the host machine open:

- Website: https://<host>
- WordPress admin: https://<host>/wp-admin

Replace `<host>` with the server IP or hostname (for local testing use `localhost` or the machine's IP). If TLS certificates are not configured you may need to accept a browser warning.

## Locate and manage credentials
- All runtime secrets are stored as files in the repository `secrets/` directory:
  - `secrets/db_root_password.txt`
  - `secrets/db_user_password.txt`
  - `secrets/wp_admin_password.txt`
  - `secrets/wp_user_password.txt`
  - `secrets/wp_admin_email.txt`
  - `secrets/wp_user_email.txt`
  - `secrets/credentials.txt` (additional info)

- These files are mounted into containers as Docker secrets (see `docker-compose.yml`). To change a credential, edit the corresponding file and then restart the service that uses it (for example, `make restart` or `docker-compose restart wordpress`).

- Security recommendations:
  - Keep the `secrets/` directory readable only by trusted users: `chmod 600 secrets/*`.
  - Never commit production credentials to public repositories.

## Check that services are running correctly
- Check container status and health checks:

```
docker-compose -f ./docker-compose.yml ps
```

- Follow logs for a specific service:

```
docker-compose -f ./docker-compose.yml logs -f nginx
docker-compose -f ./docker-compose.yml logs -f wordpress
docker-compose -f ./docker-compose.yml logs -f mariadb
```

- Inspect health for the database (MariaDB has a healthcheck configured):

```
docker inspect --format='{{json .State.Health}}' mariadb
```

- Quick functional checks:
  - Open the site in a browser and verify the homepage loads.
  - Log into `wp-admin` with the admin email/password from `secrets/` to confirm WordPress is operating.
  - If the site fails to load, check container logs and ensure volume paths and secrets exist (see `DEV_DOC.md`).

For more developer-facing checks and data locations, see the developer documentation in `DEV_DOC.md`.


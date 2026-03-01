# DEV DOCUMENTATION

## Prerequisites
- Installed on the developer machine:
  - Docker (Engine)
  - Docker Compose
  - Make
  - Git
  - Bash/shell

Install on Debian/Ubuntu (example):

```bash
sudo apt update
sudo apt install -y git make docker.io docker-compose
sudo usermod -aG docker $USER   # then re-login
```

## Project layout and important files
- `docker-compose.yml` — service definitions, secrets, volumes and network.
- `Makefile` — convenience targets to build, start, stop and prune the stack.
- `secrets/` — plaintext files used as Docker secrets (see below).
- `src/` — build contexts for `mariadb`, `nginx`, and `wordpress` images.

## Setting up the environment from scratch
1. Clone the repository:

```bash
git clone https://github.com/nyykooo/Inception ;
cd Inception
```

2. Ensure `secrets/` contains the required secret files (the repository includes example files):

- `secrets/db_root_password.txt`
- `secrets/db_user_password.txt`
- `secrets/wp_admin_password.txt`
- `secrets/wp_user_password.txt`
- `secrets/wp_admin_email.txt`
- `secrets/wp_user_email.txt`

If you need different credentials for your environment, edit these files. Keep them private and use `chmod 600 secrets/*`.

3. (Optional) Create or update an `.env` file for environment variables referenced by `docker-compose.yml`.

## Build and launch the project
Recommended (use the `Makefile` targets):

```bash
make build   # creates data directories and builds images
make up      # runs docker-compose up -d
```

Direct Docker Compose alternative:

```bash
docker-compose -f ./docker-compose.yml up -d --build
```

Important `Makefile` targets available:
- `make build` — creates required host directories and builds images.
- `make up` — starts containers in detached mode.
- `make start` / `make stop` — start or stop already-created containers.
- `make down` — stops and removes containers, networks and volumes (`down -v --remove-orphans`).
- `make restart` — restarts services.
- `make prune` / `make prune_net` — aggressive cleanup (use with caution).

## Manage containers, logs and volumes
- Show containers and status:

```bash
docker-compose -f ./docker-compose.yml ps
```

- Follow combined logs:

```bash
docker-compose -f ./docker-compose.yml logs -f
```

- Follow logs for one service:

```bash
docker-compose -f ./docker-compose.yml logs -f wordpress
```

- Stop and remove everything including volumes:

```bash
docker-compose -f ./docker-compose.yml down -v --remove-orphans
```

- Remove named volumes and host bind data (the Makefile has `prune` target):

```bash
make prune
```

## Where project data is stored and persistence
- The project uses named volumes that are configured as host bind mounts in `docker-compose.yml`:
  - `db_data` -> host path: `/home/ncampbel/Data/db_data` (MariaDB data files)
  - `wp_data` -> host path: `/home/ncampbel/Data/wp_data` (WordPress files)

These bind mounts are configured in `docker-compose.yml` with `driver_opts` and allow persistent storage across container rebuilds. Back up these directories to preserve site content and database.

## Secrets and configuration
- Secrets are defined in `docker-compose.yml` and mapped to files in the `secrets/` directory. Docker will inject them into containers at `/run/secrets/<name>`.

- Do not store production secrets in the repository; for production consider an external secret manager or ensuring repository access is restricted.

## Healthchecks and service ordering
- `mariadb` has a healthcheck configured: WordPress `depends_on` will wait for a healthy DB before starting.

## Troubleshooting
- If WordPress cannot connect to the database, check:
  - `docker-compose -f ./docker-compose.yml logs -f mariadb`
  - The contents of `secrets/db_user_password.txt` and `secrets/db_root_password.txt`.
  - That the bind mount host directories exist and are writable (the Makefile's `build` target creates them).

- If `nginx` fails to bind port 443, ensure no other service (like a host webserver) is using the port.

## Quick verification steps after deploy
1. `docker-compose -f ./docker-compose.yml ps` — all services should be `Up` and `mariadb` should report `healthy`.
2. Browse to `https://<host>` and `https://<host>/wp-admin`.
3. Check content directories `/home/ncampbel/Data/wp_data` and DB files in `/home/ncampbel/Data/db_data`.

---

If you want, I can also add example `.env` values and a short script to rotate or regenerate secrets.

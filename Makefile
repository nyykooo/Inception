#.PHONY forces the command listed to be executed avoinding even if there is a file with the same name
.PHONY: all build up start down stop restart 

# $(c) allows the command to receive an specific container as argument
all: build
build:
	docker compose -p inception -f docker-compose.yml build $(c)
up:
	docker compose -f docker-compose.yml up -d $(c)
start:
	docker compose -f docker-compose.yml start $(c)
down:
	docker compose -f docker-compose.yml down $(c)
stop:
	docker compose -f docker-compose.yml stop $(c)
restart:
	docker compose -f docker-compose.yml restart
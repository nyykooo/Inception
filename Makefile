#.PHONY forces the command listed to be executed avoinding even if there is a file with the same name
.PHONY: all build up start down stop restart 

all: build
build:
	@mkdir -p /home/ncampbel/Data/db_data /home/ncampbel/Data/wp_data
	docker-compose -p inception -f ./docker-compose.yml build
up:
	docker-compose -f ./docker-compose.yml up -d
start:
	docker-compose -f ./docker-compose.yml start
down:
	docker-compose -f ./docker-compose.yml down -v --remove-orphans
stop:
	docker-compose -f ./docker-compose.yml stop
restart:
	docker-compose -f ./docker-compose.yml restart
prune:
	docker system prune --all --volumes --force \
	&& docker volume ls -q | xargs -r docker volume rm \
	&& rm -rfdR /home/ncampbel/Data
prune_net:
	docker network prune --force

fclean: down prune prune_net

re: fclean build

logs:
	cd srcs && docker-compose logs
UID=$(shell id -u)
GID=$(shell id -g)
DOCKER_PHP_SERVICE=php

start: erase cache-folders build composer-install sh

erase:
		docker-compose down -v

build:
		docker-compose build && \
		docker-compose pull

cache-folders:
		mkdir -p ~/.composer && chown ${UID}:${GID} ~/.composer

composer-install:
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} composer install

sh:
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh

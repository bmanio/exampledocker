VERSION ?= latest

NAME = exampledocker
INSTANCE = default
SERVICES = exampledocker

.PHONY: build push shell run start stop clean clean-images release

build:
	@docker-compose -p ${NAME} build 
push:
	@docker-compose -p ${NAME} push
shell:
	@docker-compose -p ${NAME} exec exampledocker bash
start:  run
run:
	@docker-compose -p ${NAME} up -d ${SERVICES}
restart:
	@docker-compose -p ${NAME} restart -t 30 ${SERVICES}
stop:
	@docker-compose -p ${NAME} stop
clean:	stop
	@docker-compose -p ${NAME} rm ${SERVICES}
clean-data: clean
	@docker-compose -p ${NAME} rm -v json
clean-images:
	@docker rmi `docker images -q -f "dangling=true"`
release: build
	make push -e VERSION=$(VERSION)
default: build

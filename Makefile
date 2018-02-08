PWD := $(shell pwd)

.PHONY: init
init: ssh-keys install-prerequisites | $(PWD)/pgdata

.PHONY: install-prerequisites
install-prerequisites:
	pipenv install

.PHONY: ssh-keys
ssh-keys: | $(PWD)/keys/web/tsa_host_key $(PWD)/keys/web/session_signing_key $(PWD)/keys/worker/worker_key $(PWD)/keys/web/authorized_worker_keys $(PWD)/keys/worker/tsa_host_key.pub

$(PWD)/keys/web:
	mkdir -p keys/web keys/worker

$(PWD)/keys/worker:
	mkdir -p keys/worker

$(PWD)/keys/web/tsa_host_key: | $(PWD)/keys/web
	ssh-keygen -t rsa -f $(PWD)/keys/web/tsa_host_key -N ''

$(PWD)/keys/web/session_signing_key: | $(PWD)/keys/web
	ssh-keygen -t rsa -f $(PWD)/keys/web/session_signing_key -N ''

$(PWD)/keys/worker/worker_key: | $(PWD)/keys/worker
	ssh-keygen -t rsa -f $(PWD)/keys/worker/worker_key -N ''

$(PWD)/keys/web/authorized_worker_keys: | $(PWD)/keys/worker/worker_key
	cp $(PWD)/keys/worker/worker_key.pub $(PWD)/keys/web/authorized_worker_keys

$(PWD)/keys/worker/tsa_host_key.pub: | $(PWD)/keys/web/tsa_host_key
	cp $(PWD)/keys/web/tsa_host_key.pub $(PWD)/keys/worker

$(PWD)/pgdata:
	mkdir -p $(PWD)/pgdata

.PHONY: up
up:
	. ./.envrc && pipenv run docker-compose up -d

.PHONY: down
down:
	. ./.envrc && pipenv run docker-compose down

.PHONY: ps
ps:
	. ./.envrc && pipenv run docker-compose ps

.PHONY: exec
exec:
	. ./.envrc && pipenv run docker-compose exec fly /bin/bash

.PHONY: build
build:
	. ./.envrc && pipenv run docker-compose build fly

.PHONY: clean
clean: down

.PHONY: destroy
destroy: clean
	rm -rf keys
	rm -rf pgdata

# https://stackoverflow.com/a/26339924
# @$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
.PHONY: list
list:
	grep '\.PHONY' ./Makefile | awk '{print $$2}'

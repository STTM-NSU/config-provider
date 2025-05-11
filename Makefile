ifneq (,$(wildcard ./.env))
	include .env
	export
endif

.PHONY: up
up:
	DOCKER_BUILDKIT=1 docker compose up --build -d

.PHONY: down
down:
	DOCKER_BUILDKIT=1 docker compose down -t 30

.PHONY: downv
downv:
	DOCKER_BUILDKIT=1 docker compose down -v -t 30

,PHONY: install-tools
install-tools:
	go install github.com/rubenv/sql-migrate/...@latest

.PHONY: migrate-up
migrate-up:
	sql-migrate up -config=dbconfig.yml -env=postgres

.PHONY: migrate-down
migrate-down:
	sql-migrate down -config=dbconfig.yml -env=postgres

.PHONY: local-migrate-status
local-migrate:
	 set -a; . ./.env; set +a; sql-migrate status -config=dbconfig.yml -env=postgres
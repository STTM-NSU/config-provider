.PHONY: up
up:
	DOCKER_BUILDKIT=1 docker compose up --build -d

.PHONY: down
down:
	DOCKER_BUILDKIT=1 docker compose down -t 30

.PHONY: downv
downv:
	DOCKER_BUILDKIT=1 docker compose down -v -t 30

.PHONY: migrate-up
migrate-up:
	
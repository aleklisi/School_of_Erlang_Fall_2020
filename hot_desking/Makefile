setup_pgsql:
	docker run \
	-d \
	-p 5432:5432 \
	--name postgresql \
	-e POSTGRESQL_USERNAME=postgres \
	-e POSTGRESQL_DATABASE=hot_desking \
	-e POSTGRESQL_PASSWORD=postgres \
	bitnami/postgresql:latest

run_with_export_vars:
	export POSTGRESQL_URL=localhost && \
	export POSTGRESQL_PORT=5432 && \
	export POSTGRESQL_USERNAME=postgres && \
	export POSTGRESQL_DATABASE=hot_desking && \
	export POSTGRESQL_PASSWORD=postgres && \
	rebar3 shell

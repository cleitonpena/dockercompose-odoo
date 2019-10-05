run:
	@ docker stack deploy -c docker-stack.yml odoo

show:
	@ docker stack services odoo

stop:
	@ docker stack rm odoo

logs:
	@ docker service logs -f odoo_odoo

run-db:
	@ docker volume create odoo_postgres_dev_data
	@ docker network create --attachable odoo_postgres_dev_network
	@ docker run -d --rm \
		-e TZ=America/Guayaquil \
		-e POSTGRES_DB=postgres \
		-e POSTGRES_PASSWORD=odoo \
		-e POSTGRES_USER=odoo \
		-p 5432:5432 \
		--network odoo_postgres_dev_network \
		-v odoo_postgres_dev_data:/var/lib/postgresql/data \
		--name odoo_postgres_dev \
		postgres:10

stop-db:
	@ docker rm -f odoo_postgres_dev

clean-db:
	@ docker rm -f odoo_postgres_dev || true
	@ docker volume rm odoo_postgres_dev_data || true
	@ docker network rm odoo_postgres_dev_network || true

run:
	@ docker stack deploy -c docker-stack.yml odoo

show:
	@ docker stack services odoo

stop:
	@ docker stack rm odoo

logs:
	@ docker service logs -f odoo_odoo

postfix=

run-db:
	@ docker volume create odoo_postgres_dev_data$(postfix) | true
	@ docker network create --attachable odoo_postgres_dev_network$(postfix) | true
	@ docker run -d --rm \
		-e TZ=America/Guayaquil \
		-e POSTGRES_DB=postgres \
		-e POSTGRES_PASSWORD=odoo \
		-e POSTGRES_USER=odoo \
		-p 5432:5432 \
		--network odoo_postgres_dev_network$(postfix) \
		-v odoo_postgres_dev_data$(postfix):/var/lib/postgresql/data \
		--name odoo_postgres_dev$(postfix) \
		postgres:10

stop-db:
	@ docker rm -f odoo_postgres_dev$(postfix)

clean-db:
	@ docker rm -f odoo_postgres_dev$(postfix) || true
	@ docker volume rm odoo_postgres_dev_data$(postfix) || true
	@ docker network rm odoo_postgres_dev_network$(postfix) || true

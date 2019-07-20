run:
	@ docker stack deploy -c docker-stack.yml odoo

show:
	@ docker stack services odoo

stop:
	@ docker stack rm odoo

logs:
	@ docker service logs -f odoo_odoo

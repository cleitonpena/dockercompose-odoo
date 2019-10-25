# Dockerizing Odoo

Docker swarm odoo deploy.

## Links

- https://hub.docker.com/_/odoo

## Docker Version

- `docker-compose.yml`: 3.7
- `docker`: 19.+

## Getting Started

```
make
```

Path: [http://127.0.0.1:8069](http://127.0.0.1:8069).

## Commands

`make run` runs the application

`make stop` stops the application

`make show` shows the current services

`make logs` shows logs

`make run-db` creates an odoo database for a developer env

`make stop-dp` stops the database

`make clean-db` removes all docker elements for the developer database

## Using odoo with data persistent

```
version: '3.7'

services:
  postgres:
    image: postgres:10
    environment:
      - TZ=America/Guayaquil
      - POSTGRES_DB=postgres
      - POSTGRES_USER=odoo
      - POSTGRES_PASSWORD=odoo
    volumes:
      - odoo_data:/var/lib/postgresql/data
    ports:
      - 5432:5432

  odoo:
    image: odoo:13
    environment:
      - TZ=America/Guayaquil
      - HOST=postgres
    volumes:
      - odoo_filestore:/var/lib/odoo
      - ./config:/etc/odoo
      - ./addons:/mnt/extra-addons
    ports:
      - 8069:8069

volumes:
  odoo_data:
  odoo_filestore:
```

See the [config/odoo.conf](config/odoo.conf).

The following users and passwords are part of the initial seed database:

|User|Password|
|-|-|
|admin|admin|
|demo|demo|

## Using odoo without data persistent

```
version: '3.7'

services:
  postgres:
    image: postgres:10
    environment:
      - TZ=America/Guayaquil
      - POSTGRES_DB=postgres
      - POSTGRES_USER=odoo
      - POSTGRES_PASSWORD=odoo
    ports:
      - 5432:5432

  odoo:
    image: odoo:13
    environment:
      - TZ=America/Guayaquil
      - HOST=postgres
    ports:
      - 8069:8069
```

## Others Env Variables

- `TZ`: Timezone.
- `ODOO_RC`: To change the config path.
- `HOST`: The address of the postgres server. If you used a postgres container, set to the name of the container. Defaults to db.
- `PORT`: The port the postgres server is listening to. Defaults to 5432.
- `USER`: The postgres role with which Odoo will connect. If you used a postgres container, set to the same value as POSTGRES_USER. Defaults to odoo.
- `PASSWORD`: The password of the postgres role with which Odoo will connect. If you used a postgres container, set to the same value as POSTGRES_PASSWORD. Defaults to odoo.

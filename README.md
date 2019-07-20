# Dockerizing Odoo

Docker swarm odoo deploy.

## Links

- https://hub.docker.com/_/odoo

## Docker Version

- `docker-compose.yml`: 3.7
- `docker`: 18.+

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

## Using a conf file

```
version: '3.7'

services:
  postgres:
    image: postgres:10
    volumes:
      - odoo_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=postgres
      - POSTGRES_USER=odoo
      - POSTGRES_PASSWORD=odoo
    ports:
      - 5432:5432

  odoo:
    image: odoo:12
    volumes:
      - ./odoo.conf:/etc/odoo/odoo.conf
    ports:
      - 8069:8069
    environment:
      - HOST=postgres

volumes:
  odoo_data:

```

The following users and passwords are part of the initial seed database:

|User|Password|
|-|-|
|admin|admin|
|demo|demo|

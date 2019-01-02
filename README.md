# Dockerize Rails

Rails with docker stack, examples with nginx webserver, sidekiq worker, webpacker.

Build diferent image for development and production image with optimizations.

## Stack

|                              | Name  | Versión
|---|---|---|
| Lang                         | Ruby  | 2.5.1 |
| Framework                    | Rails | 5.2.1 |
| Database                     | Postgres | 9.5.9 |
| Cache service                | Redis    |  *   |
| background processing        | sidekiq    |  5.2.3   |


## Development mode

In development mode don't use nginx webserver, compile assets with webpack dev server, and use persisted volume for live reload code.

### Rails dockerfile example
[Dockerfile](https://github.com/MiguelSavignano/dockerize-rails/tree/master/docker/development/Dockerfile)

### Start server and all services

```
docker-compose up
```

[See more](https://github.com/MiguelSavignano/dockerize-rails/tree/master/docs/docker-development.md)


## Production mode

In production mode use nginx webserver, compile assets, no live reload code.
Configure for works in production and optimized docker image size.

Enviroment variables
```
RAILS_ENV=production
RAILS_LOG_TO_STDOUT="true"
NODE_ENV=production
REDIS_PROVIDER=REDISGREEN_URL

REDISGREEN_URL
RAILS_MASTER_KEY
DATABASE_HOST
DATABASE_USERNAME
DATABASE_PASSWORD
```
## Docker image
[Dockerfile](https://github.com/MiguelSavignano/dockerize-rails/tree/master/docker/production/rails/Dockerfile)

## Example using docker-compose

### Start server and all services

```
docker-compose -f docker-compose.production.yml up
```

## Example using Kubernetes (minikube)

[See more](https://github.com/MiguelSavignano/dockerize-rails/tree/master/docs/minikube.md)

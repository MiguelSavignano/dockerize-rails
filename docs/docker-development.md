# Dockerize Rails for development

Simple rails app dockerize with [dockerize-stack](https://github.com/MiguelSavignano/dockerize-stack)

[Dockerfile](docker/development)
[docker-compose.yml](docker-compose.yml)

## Installation

```
docker-compose up
```

## Debugger
- Set breackpoint
```
binding.pry
```
- Attach container
```
docker attach web
```

## Rails console

```
docker-compose run --rm web rails console
```

## Enter in the web container

```
docker-compose run web bash
```

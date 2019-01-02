# Dockerize Rails for development

[Dockerfile](https://github.com/MiguelSavignano/dockerize-rails/tree/master/docker/development/Dockerfile)
[docker-compose.yml](https://github.com/MiguelSavignano/dockerize-rails/tree/master/docker-compose.yml)

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
Warning exit with (Ctrl+p + Ctrl+q)

## Rails console

```
docker-compose run --rm web rails console
```

## Enter in the web container

```
docker-compose run web bash
```

## Run generators

After run a generator you don't have permission to edit the files, because the files was generated with sudo user in the container.

change all file permissions
```
sudo chown -R $USER:$USER .
```

## Install new gems or npm

In development gems and npm have a persisted volume, install new gems or npm in the same rails image using
```
docker-compose run --rm web bundle install
```
```
docker-compose run --rm web npm install
```

Or build a new development image with the new gems or npm (the new image download all gems again)
```
docker-compose build
```

## Server start
If the rails container don't stop correctly the file tmp/pids/server.pid save the last pid for this you can't start a new rails server.
in development before start delete the pid file
```
rm -f tmp/pids/server.pid
```

## Webpack dev server

In develpment you can start the webpack-dev-server in background on the same rails container with

```
rm -rf public/packs/* || true && bin/webpack-dev-server &
```

## Server bind host

```
bundle exec rails server -p 3000 -b 0.0.0.0
```

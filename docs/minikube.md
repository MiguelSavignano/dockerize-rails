# Minikube

```
minikube start
```

## build local images in minikube

https://github.com/kubernetes/minikube/blob/master/docs/reusing_the_docker_daemon.md

```
eval $(minikube docker-env)
```

all docker commands sync in minikube
```
./docker/production/dockerbuild.sh
```

kubectl expose deployment rails-nginx --type=NodePort


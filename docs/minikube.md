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


## Create stack on minikube

```
./docker/kubernetes/scripts/set-config-map.sh
./docker/kubernetes/scripts/set-secrets.sh.sh
./docker/kubernetes/scripts/set-workloads.sh
./docker/kubernetes/scripts/set-services.sh
```

## Open rails server in browser

```
minikube service rails-nginx
```

## Ingress http

```
minikube addons enable ingress
```

```
kubectl apply -f docker/kubernetes/ingress/ingress-http.yaml
```

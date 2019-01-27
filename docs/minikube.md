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

- Or use dockerhub repositories

## Create stack on minikube

```
./docker/kubernetes/scripts/set-config-map.sh
./docker/kubernetes/scripts/set-secrets.sh.sh
./docker/kubernetes/scripts/setup.sh
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
echo "$(minikube ip) myminikube.info" | sudo tee -a /etc/hosts
```

```
kubectl apply -f docker/kubernetes/ingress/ingress-http.yaml
```

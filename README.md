# README

Docker image: devmasx/rails-sqlite

## Create cluster

```
PROJECT_ID=docker-rails-258302

gcloud beta container --project $PROJECT_ID clusters create "docker-rails-cluster" --zone "us-central1-a" --no-enable-basic-auth --cluster-version "1.13.11-gke.14" --machine-type "n1-standard-1" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "2" --enable-cloud-logging --enable-cloud-monitoring --enable-ip-alias --network "projects/docker-rails-258302/global/networks/default" --subnetwork "projects/docker-rails-258302/regions/us-central1/subnetworks/default" --default-max-pods-per-node "110" --addons HorizontalPodAutoscaling,HttpLoadBalancing,Istio --istio-config auth=MTLS_PERMISSIVE --enable-autoupgrade --enable-autorepair
```

## Create Workload and Services

```
kubectl apply -f kubernetes/rails-nginx.yaml
```

## Deploy

```
kubectl set image deployment/rails-nginx rails=devmasx/devmasx/rails-sqlite:latest
```

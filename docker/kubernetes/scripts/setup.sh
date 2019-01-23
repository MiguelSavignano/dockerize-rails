# ./docker/kubernetes/scripts/set-config-map.sh
# ./docker/kubernetes/scripts/set-secrets.sh
kubectl apply \
  -f docker/kubernetes/services/postgres.yaml \
  -f docker/kubernetes/services/redis.yaml \
  -f docker/kubernetes/services/rails-nginx.yaml \
  -f docker/kubernetes/workloads/postgres.yaml \
  -f docker/kubernetes/workloads/redis.yaml \
  -f docker/kubernetes/workloads/rails-nginx.yaml \
  -f docker/kubernetes/workloads/rails-worker.yaml \
  -f docker/kubernetes/ingress/ingress-http.yaml

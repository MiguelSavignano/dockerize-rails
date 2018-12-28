kubectl create configmap rails-config \
  --from-literal=NODE_ENV=production \
  --from-literal=RAILS_ENV=production \
  --from-literal=DATABASE_HOST=db \
  --from-literal=RAILS_LOG_TO_STDOUT=true \
  --from-literal=REDIS_PROVIDER=REDISGREEN_URL \
  --from-literal=REDISGREEN_URL=redis://redis:6379/0

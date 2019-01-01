DOCKERHUB_USERNAME=devmasx

kubectl set image deployment/rails-nginx \
  nginx=${DOCKERHUB_USERNAME}/dockerize-nginx-production \
  rails=${DOCKERHUB_USERNAME}/dockerize-rails-production

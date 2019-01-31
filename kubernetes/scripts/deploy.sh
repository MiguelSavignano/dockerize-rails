USERNAME=devmasx

kubectl set image deployment/rails-nginx \
  nginx=${USERNAME}/dockerize-nginx-production \
  rails=${USERNAME}/dockerize-rails-production

# build rails image
docker build \
  --build-arg RAILS_MASTER_KEY=ea3aaacc43f832b6e9049e61211561dc \
  -t dockerize-rails-production \
  -f docker/production/rails/Dockerfile \
  .

# build nginx image
docker build \
  --build-arg WEBAPP_HOST=http://localhost:3000 \
  -t dockerize-nginx-production \
  -f ./docker/production/nginx/Dockerfile \
  ./docker/production/nginx

DOCKERHUB_USERNAME=devmasx
docker tag dockerize-rails-production ${DOCKERHUB_USERNAME}/dockerize-rails-production
docker tag dockerize-nginx-production ${DOCKERHUB_USERNAME}/dockerize-nginx-production

docker push ${DOCKERHUB_USERNAME}/dockerize-rails-production
docker push ${DOCKERHUB_USERNAME}/dockerize-nginx-production

GIT_HASH=$(git rev-parse --short HEAD)
USERNAME=devmasx

# build rails image
docker build \
  --build-arg RAILS_MASTER_KEY=ea3aaacc43f832b6e9049e61211561dc \
  -t ${USERNAME}/dockerize-rails-production \
  -t ${USERNAME}/dockerize-rails-production:$GIT_HASH \
  -f docker/production/rails/Dockerfile \
  .

# build nginx image
docker build \
  --build-arg WEBAPP_HOST=http://localhost:3000 \
  -t ${USERNAME}/dockerize-nginx-production \
  -t ${USERNAME}/dockerize-nginx-production:$GIT_HASH \
  -f ./docker/production/nginx/Dockerfile \
  ./docker/production/nginx

docker push ${USERNAME}/dockerize-rails-production:$GIT_HASH
docker push ${USERNAME}/dockerize-rails-production
docker push ${USERNAME}/dockerize-nginx-production:$GIT_HASH
docker push ${USERNAME}/dockerize-nginx-production

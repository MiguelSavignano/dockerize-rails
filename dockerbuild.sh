set -e

# ===========COFIGURATION===============================
#IMAGE_TAG=${GITHUB_SHA}
IMAGE_TAG=`git rev-parse --short HEAD`
SERVICE_NAME=rails-nginx
IMAGE_NAME=gcr.io/docker-rails-258302/rails-sqlite
POD_CONTAINER_NAME_1=rails
# ==================================================

gcloud auth configure-docker

docker pull ${IMAGE_NAME} || exit 0

docker build \
  --cache-from=${IMAGE_NAME} \
  -t ${IMAGE_NAME} \
  -t ${IMAGE_NAME}:${IMAGE_TAG} \
  .

docker push ${IMAGE_NAME}
docker push ${IMAGE_NAME}:${IMAGE_TAG}

echo $IMAGE_NAME:${IMAGE_TAG}

if [ "$1" == "--deploy" ]; then
  kubectl set image deployment/$SERVICE_NAME ${POD_CONTAINER_NAME_1}=${IMAGE_NAME}:${IMAGE_TAG}
fi

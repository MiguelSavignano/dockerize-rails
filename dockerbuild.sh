set -e

IMAGE_NAME=devmasx/rails-sqlite
SERVICE_NAME=rails-nginx
IMAGE_TAG=`git rev-parse --short HEAD`

docker build -t rails-sqlite -t $IMAGE_NAME -t $IMAGE_NAME:$IMAGE_TAG .

docker push $IMAGE_NAME
docker push $IMAGE_NAME:$IMAGE_TAG

echo  $IMAGE_NAME:$IMAGE_TAG

if [ "$1" == "--deploy" ]; then
  kubectl set image deployment/$SERVICE_NAME rails=$IMAGE_NAME:$IMAGE_TAG
fi

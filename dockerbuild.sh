set -e

IMAGE_NAME=devmasx/rails-sqlite
SERVICE_NAME=rails-nginx
GIT_HASH=`git rev-parse --short HEAD`

docker build -t rails-sqlite -t $IMAGE_NAME -t $IMAGE_NAME:$GIT_HASH .

docker push $IMAGE_NAME
docker push $IMAGE_NAME:$GIT_HASH

echo  $IMAGE_NAME:$GIT_HASH

if [ "$1" == "--deploy" ]; then
  kubectl set image deployment/$SERVICE_NAME rails=$IMAGE_NAME:$GIT_HASH
fi

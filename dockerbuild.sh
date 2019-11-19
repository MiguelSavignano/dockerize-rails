IMAGE_NAME=devmasx/rails-sqlite
GIT_HASH=`git rev-parse --short HEAD`

docker build -t rails-sqlite -t $IMAGE_NAME -t $IMAGE_NAME:$GIT_HASH .

docker push $IMAGE_NAME
docker push $IMAGE_NAME:$GIT_HASH

echo  $IMAGE_NAME:$GIT_HASH

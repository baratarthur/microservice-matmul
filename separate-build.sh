docker buildx build \
  --builder mybuilder \
  --platform linux/amd64 \
  -t matmul-flask:amd64 \
  --load .

docker buildx build \
  --builder mybuilder \
  --platform linux/arm64 \
  -t matmul-flask:arm64 \
  --load .


docker tag matmul-flask:amd64 my.private-registry.lan:5000/matmul-flask:amd64
docker tag matmul-flask:arm64 my.private-registry.lan:5000/matmul-flask:arm64


docker push my.private-registry.lan:5000/matmul-flask:amd64
docker push my.private-registry.lan:5000/matmul-flask:arm64

docker manifest create my.private-registry.lan:5000/matmul-flask:latest \
  --amend my.private-registry.lan:5000/matmul-flask:amd64 \
  --amend my.private-registry.lan:5000/matmul-flask:arm64

docker manifest push my.private-registry.lan:5000/matmul-flask:latest

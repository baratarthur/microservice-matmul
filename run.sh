docker buildx build \
        --platform linux/amd64,linux/arm \
        --provenance=false \
        --sbom=false \
        -t my.private-registry.lan:5000/matmul-flask:latest \
        --push .

echo "Pushing image into local repository..."
# docker tag matmul-flask:latest my.private-registry.lan:5000/matmul-flask:latest
# docker push my.private-registry.lan:5000/matmul-flask:latest

echo "Veryfying deploied image..."
curl -X GET http://my.private-registry.lan:5000/v2/_catalog

echo "Applying Kubernetes manifest..."
kubectl apply -f hpa.yaml
kubectl apply -f manifest.yaml

kubectl rollout restart deployment flask-app-deployment
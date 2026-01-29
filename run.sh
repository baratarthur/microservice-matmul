docker build -t matmul-flask:latest .

echo "Pushing image into local repository..."
docker tag matmul-flask:latest localhost:5000/matmul-flask:latest
docker push localhost:5000/matmul-flask:latest

echo "Veryfying deploied image..."
curl -X GET http://localhost:5000/v2/_catalog

echo "Applying Kubernetes manifest..."
kubectl apply -f manifest.yaml

sleep 10
kubectl port-forward service/matmul-flask-app-service 5050:5050
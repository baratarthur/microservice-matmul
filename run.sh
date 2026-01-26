docker build -t matmul-flask:latest .

minikube image rm matmul-flask:latest
echo "Loading image into minikube..."
minikube image load matmul-flask:latest

echo "Applying Kubernetes manifest..."
kubectl apply -f manifest.yaml

sleep 10
kubectl port-forward service/matmul-flask-app-service 5050:5050
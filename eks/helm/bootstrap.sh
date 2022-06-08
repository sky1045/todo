# metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# nginx ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
kubectl create ns nginx
helm install todo -n nginx ingress-nginx/ingress-nginx -f nginx-values.yaml

# redis
kubectl apply -f gp3-def-sc.yaml
helm repo add bitnami https://charts.bitnami.com/bitnami
helm update
kubectl create ns redis
helm install todo -n redis bitnami/redis -f redis-values.yaml

# todo
kubectl create ns todo
# wait for nginx admission controller service endpoint
sleep 15
helm install todo -n todo todo/

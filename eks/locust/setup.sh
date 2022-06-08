# Helm chart repo setting
helm repo add deliveryhero "https://charts.deliveryhero.io/"
helm repo update deliveryhero

# Create ConfigMap 'eks-loadtest-locustfile' from the locustfile.py created above
kubectl create configmap eks-loadtest-locustfile --from-file ./locustfile.py

# Install Locust Helm Chart
helm upgrade --install awsblog-locust deliveryhero/locust \
 --set loadtest.name=eks-loadtest \
 --set loadtest.locust_locustfile_configmap=eks-loadtest-locustfile \
 --set loadtest.locust_locustfile=locustfile.py \
 --set worker.hpa.enabled=true \
 --set worker.hpa.minReplicas=5

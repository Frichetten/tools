K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
CACERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/healthz

# Example if you get kubectl into the container
./kubectl --token $TOKEN --server $K8S get pods

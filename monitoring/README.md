Loki Installation using helm chart
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

Kubectl create namespace prometheus
helm install loki-stack grafana/loki-stack --namespace prometheus

kubectl get secret db-user-pass -o jsonpath='{.data}'
echo 'UyFCXCpkJHpEc2I9' | base64 --decode

kubectl edit secrets <secret-name>

15757 grafana dashboard

kubectl get secret prometheus-grafana -n prometheus -o jsonpath='{.data}'
echo 'cHJvbS1vcGVyYXRvcg==' | base64 --decode

Or edit sic

Kubectl edit svc “service-name” -n “namespace”
Kubectl create namespace prometheus

helm install prometheus prometheus-community/kube-prometheus-stack --namespace prometheus
Grafana Dashboard Url code
https://grafana.com/grafana/dashboards/?plcmt=top-nav&cta=downloads&search=dotdc

###Commands used to setup Prometheus and Grafana with Helm:

Dependencies required:
- kubectl 1.16+
- kubens
- kubectx
- helm 3+

Create namespace for the monitoring tools:
```
kubectl create ns monitoring
```

Change from default namespace into the created one
```
kubens monitoring
```

Add Prometheus the local helm repository:
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

Update the repositories:
```
helm repo update
```

Install Prometheus:
```
helm install [NAME] prometheus-community/kube-prometheus-stack
```
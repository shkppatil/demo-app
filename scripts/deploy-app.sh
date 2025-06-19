#!/bin/bash
# Build Docker images
docker build -t node-app:blue ../node-app/blue
docker build -t node-app:green ../node-app/green

# Load images into kind
kind load docker-image node-app:blue --name dev-cluster
kind load docker-image node-app:green --name dev-cluster

# Apply Kubernetes deployments
kubectl apply -f ../node-app/k8s/blue-deployment.yaml
kubectl apply -f ../node-app/k8s/green-deployment.yaml
kubectl apply -f ../node-app/k8s/service.yaml

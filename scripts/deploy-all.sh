#!/bin/bash

# ./scripts/deply-all.sh

kubectl apply -f kubernetes/manifests/secrets/
kubectl apply -f kubernetes/manifests/configmaps/
kubectl apply -f kubernetes/manifests/databases/
kubectl apply -f kubernetes/manifests/rabbitmq/
kubectl apply -f kubernetes/manifests/billing-app/
kubectl apply -f kubernetes/manifests/inventory-app/
kubectl apply -f kubernetes/manifests/api-gateway-app/
kubectl apply -f kubernetes/manifests/ingress/

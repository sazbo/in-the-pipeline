#!/bin/sh

NAME_OF_CHART="prometheus"

helm status $NAME_OF_CHART

if [ $? == "1" ]
then
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   helm install $NAME_OF_CHART prometheus-community/kube-prometheus-stack
fi
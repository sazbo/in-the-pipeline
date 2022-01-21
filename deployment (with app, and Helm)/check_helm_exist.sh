#!/bin/sh

NAME_OF_CHART="kotlin-webapp"
NAME_OF_HELM_DIR="webapp-with-monitoring"

helm status $NAME_OF_CHART

if [ $? == "0" ]
then
   cd $NAME_OF_HELM_DIR
   helm upgrade $NAME_OF_CHART .
else
   cd $NAME_OF_HELM_DIR
   helm install -f values.yaml $NAME_OF_CHART .
fi
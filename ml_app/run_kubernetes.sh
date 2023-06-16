#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=lukhee/udacity_ml_micoservice_5:latest

# Step 2
# Run the Docker Hub container with kubernetes
# kubectl run ml-micro --image=$dockerpath --port=80
kubectl run ml-micro --image=$dockerpath 


# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward ml-micro 8080:80


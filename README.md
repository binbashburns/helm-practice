# Hello World App Deployment

## Overview

This repository contains a simple "Hello World" web application written in Node.js, containerized using Docker, and deployed to a Kubernetes cluster using Helm.

### Repository Structure

```
.
├── README.md
├── hello-world-app
│   ├── Dockerfile
│   ├── app.js
│   └── package.json
└── hello-world-chart
    ├── Chart.yaml
    ├── charts
    ├── templates
    │   ├── NOTES.txt
    │   ├── _helpers.tpl
    │   ├── deployment.yaml
    │   ├── hpa.yaml
    │   ├── ingress.yaml
    │   ├── service.yaml
    │   └── serviceaccount.yaml
    └── values.yaml
```
## Prerequisites

- Kubernetes cluster (local or remote)
- kubectl (command-line tool for Kubernetes)
- Helm (package manager for Kubernetes)
- Docker (for building and managing containers)

## Application Details

The "Hello World" application is a simple web server that responds with "Hello World" when accessed. It is built using Node.js and runs inside a Docker container.

## How to Deploy

### Step 1: Build the Docker Image

First, ensure you are in the root directory of the repository, where the `hello-world-app` directory is located. Then, build the Docker image:

```
docker build -t your-dockerhub-username/hello-world-app:latest ./hello-world-app
```

### Step 2: Push the Docker Image to a Registry (Optional)
If you're using a public Docker registry like Docker Hub, push the image:
```
docker push your-dockerhub-username/hello-world-app:latest
```

### Step 3: Deploy with Helm
Create a Namespace (if it doesn't exist):

```
kubectl create namespace hello-world-test
```

**Update values.yaml in hello-world-chart**. Ensure values.yaml is updated to point to your Docker image. 

If it's in *****Dockerhub*****, it should look something like this:

```
image:
  repository: your-dockerhub-username/hello-world-app
  tag: latest
  pullPolicy: IfNotPresent
```

If the container image is on *****your machine*****, it should look something like this:

```
image:
  repository: hello-world-app
  tag: latest
  pullPolicy: IfNotPresent
```

Deploy the Helm Chart:
```
helm install hello-world-test ./hello-world-chart --namespace hello-world-test
```

Verify the Deployment:
```
kubectl get all --namespace hello-world-test
```

### Step 4: Access the Web Application
#### Using External IP (LoadBalancer)
Get the External IP:

```
kubectl get svc --namespace hello-world-test
```

You should see an output similar to:

```
NAME                                       TYPE           CLUSTER-IP        EXTERNAL-IP    PORT(S)        AGE
hello-world-test-hello-world-chart         LoadBalancer   192.168.194.243   <external-ip>  80:31794/TCP   68s
```

Open Your Browser:

Navigate to `http://<external-ip>:80`

#### Using Port-Forwarding (Alternative)
Port-Forward the Service:

```
kubectl port-forward --namespace hello-world-test svc/hello-world-test-hello-world-chart 8080:80
```

Open Your Browser:

Navigate to http://localhost:8080.

### Clean Up
To remove the deployment, use Helm to uninstall the release:

```
helm uninstall hello-world-test --namespace hello-world-test

kubectl delete namespace hello-world-test
```
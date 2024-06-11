# ivolve
# lab13
## Jenkins Deployment with Init Container and Health Probes in Kubernetes

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Setup Instructions](#setup-instructions)
    1. [Create Namespace](#create-namespace)
    2. [Create Jenkins Deployment](#create-jenkins-deployment)
    3. [Set Up Readiness and Liveness Probes](#set-up-readiness-and-liveness-probes)
    4. [Create NodePort Service to Expose Jenkins](#create-nodeport-service-to-expose-jenkins)
4. [Verification](#verification)
5. [Understanding Concepts](#understanding-concepts)
    1. [Readiness Probe vs. Liveness Probe](#readiness-probe-vs-liveness-probe)
    2. [Init Container vs. Sidecar Container](#init-container-vs-sidecar-container)
6. [Cleanup](#cleanup)
7. [Appendix](#appendix)
    1. [Useful Commands](#useful-commands)

## Introduction

This guide walks through deploying a Jenkins application in a Kubernetes cluster. It includes setting up an init container to delay the start of the Jenkins container, configuring readiness and liveness probes for health monitoring, and exposing Jenkins via a NodePort service.

## Prerequisites

- Kubernetes cluster
- `kubectl` configured to interact with your cluster
- Basic knowledge of Kubernetes concepts (namespaces, deployments, services, probes)

## Setup Instructions

### Create Namespace

First, create a namespace called `nti`.

```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: nti
```

Apply the namespace configuration:

```sh
kubectl apply -f namespace.yaml
```

### Create Jenkins Deployment

Create a file named `deploy.yaml` with the following content:

```yaml
# jenkins-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins
  namespace: nti
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      initContainers:
      - name: init-container
        image: busybox
        command: ["sh", "-c", "sleep 10"]
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - containerPort: 8080
        readinessProbe:
          httpGet:
            path: "/login"
            port: 8080
          initialDelaySeconds: 60
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: "/login"
            port: 8080
          initialDelaySeconds: 90
          periodSeconds: 20
        resources:
          requests:
            memory: "1Gi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "1"
```

Apply the deployment:

```sh
kubectl apply -f deploy.yaml
```

### Set Up Readiness and Liveness Probes

In the above deployment file:
- **Readiness Probe**: Ensures Jenkins is ready to serve traffic by checking the `/login` path. It starts after 60 seconds and checks every 10 seconds.
- **Liveness Probe**: Ensures Jenkins is running by checking the `/login` path. It starts after 90 seconds and checks every 20 seconds.

### Create NodePort Service to Expose Jenkins

Create a file named `serv.yaml` with the following content:

```yaml
# jenkins-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service
  namespace: nti
spec:
  type: NodePort
  selector:
    app: jenkins
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: 32000  # You can choose a different port in the range 30000-32767
```

Apply the service configuration:

```sh
kubectl apply -f serv.yaml
```

## Verification

1. **Check the Pod Status**:

    ```sh
    kubectl get pods -n nti
    ```

2. **Describe the Jenkins Pod**:

    ```sh
    kubectl describe pod <jenkins-pod-name> -n nti
    ```

    Ensure the init container ran successfully.

3. **Access Jenkins**:

    Open a browser and go to `http://<node-ip>:32000` to access Jenkins.

4. **Check Logs**:

    ```sh
    kubectl logs <jenkins-pod-name> -n nti
    ```

    Verify that Jenkins has started without errors.

## Understanding Concepts

### Readiness Probe vs. Liveness Probe

- **Readiness Probe**: Checks if the application is ready to handle requests. If it fails, the Pod is marked as not ready, and it is removed from the Service endpoints.
- **Liveness Probe**: Checks if the application is still running. If it fails, the Pod is restarted.

### Init Container vs. Sidecar Container

- **Init Container**: Runs to completion before the main application containers start. Used for initialization tasks like setting up environment variables, waiting for dependencies, etc.
- **Sidecar Container**: Runs alongside the main application container in the same Pod. Used for tasks like logging, monitoring, or proxying traffic.

## Cleanup

To remove all resources created by this setup, run:

```sh
kubectl delete namespace nti
```

## Appendix

### Useful Commands

- List all namespaces:

    ```sh
    kubectl get namespaces
    ```

- Describe resources in the `nti` namespace:

    ```sh
    kubectl describe resourcequota -n nti
    kubectl describe configmap -n nti
    kubectl describe secret -n nti
    ```

- View logs of the Jenkins pod:

    ```sh
    kubectl logs <jenkins-pod-name> -n nti
    ```


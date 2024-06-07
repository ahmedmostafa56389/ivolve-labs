# ivolve 
# Lab 8
## Deployment VS Statefulset

------------------

## Overview
This lab focuses on understanding the differences between Deployments and StatefulSets in Kubernetes. You will learn when to use each type of resource and how to create a StatefulSet for MySQL with an accompanying Service configuration.

## Table of Contents
- Prerequisites
- Comparing Deployment and StatefulSet
- YAML Configuration Files
    - MySQL StatefulSet
    - MySQL Service
- Usage
- Conclusion
- References

## Prerequisites
- Basic understanding of Kubernetes concepts (Pods, Services, etc.).
- A running Kubernetes cluster.
- kubectl or (oc cli) installed and configured to interact with your cluster.

## Comparing Deployment and StatefulSet
************
### Deployment
- Use Case: Stateless applications.
- Pod Identity: Pods are interchangeable and do not have a persistent identity.
- Scaling: Easy to scale up and down.
- Updates: Rolling updates are supported out-of-the-box.
- Storage: Ephemeral storage.
### StatefulSet
- Use Case: Stateful applications.
- Pod Identity: Each Pod has a unique, persistent identity.
- Scaling: Pods are created and deleted in a defined order.
- Updates: Supports ordered, graceful rolling updates.
- Storage: Persistent storage with stable network identity.
## YAML Configuration Files
### MySQL StatefulSet
Create a file named mysql.yaml with the following content:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql-statefulset
spec:
  serviceName: mysql
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:latest
        ports:
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "ahmed123"
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-persistent-storage
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi

```
### MySQL Service
Create a file named srv.yaml with the following content:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  selector:
    app: mysql
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306


```

## Usage
1- Apply the Mysql.yml StatefulSet configuration:

```sh
kubectl apply -f mysql.yaml
```

2-Apply the service configuration:
```sh
kubectl apply -f srv.yaml
```
Then run get all command to show the statefulset and its service 

![alt text](service.png)
***
4- Verify the PVC for each pod:
```sh
kubectl get pvc 
```
![alt text](pv.png)


## Conclusion
In this lab, you learned the differences between Deployments and StatefulSets, created a MySQL StatefulSet, and defined a service for it. StatefulSets are essential for stateful applications that require persistent storage and stable network identities.


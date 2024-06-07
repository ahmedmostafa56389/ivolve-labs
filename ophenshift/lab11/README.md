# ivolve
## lab11
## Kubernetes Role-Based Access Control (RBAC) Setup

## Setup Instructions

Follow the steps:

### 1. Create a ServiceAccount

Create a service account named `ahmedmostafa` in your desired namespace (replace `lab11` with your namespace):
yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ahmedmostafa
  namespace: lab11


Apply the configuration:
bash
kubectl apply -f servaccount.yaml


### 2. Define a Role

Define a role named `pod-reader` allowing read-only access to pods in the namespace `lab11`:
yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: lab11
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]


Apply the configuration:
bash
kubectl apply -f role.yaml


### 3. Bind the Role to the ServiceAccount

Bind the `pod-reader` role to the `ahmedmostafa` service account:
yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: lab11
subjects:
- kind: ServiceAccount
  name: ahmedmostafa
  namespace: lab11
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io


Apply the configuration:
bash
kubectl apply -f rolebinding.yaml


### 4. Get ServiceAccount Token

After applying the service account, retrieve the token using:
bash
kubectl get secret $(kubectl get serviceaccount my-serviceaccount -o jsonpath='{.secrets[0].name}' -n my-namespace) -o jsonpath='{.data.token}' -n my-namespace | base64 --decode


This token can be used for authentication purposes.

## Role vs. ClusterRole

- **Role**: Defines permissions within a namespace.
- **ClusterRole**: Defines permissions across the entire cluster.
- **Scope**: Role is limited to a specific namespace, while ClusterRole applies across all namespaces.
- **Example Use Case**: Role for providing access to resources within a single namespace, ClusterRole for cluster-wide access control.

## RoleBinding vs. ClusterRoleBinding

- **RoleBinding**: Binds a Role to a user, group, or service account within a namespace.
- **ClusterRoleBinding**: Binds a ClusterRole to a user, group, or service account across the entire cluster.
- **Scope**: RoleBinding applies within a namespace, while ClusterRoleBinding applies across all namespaces.
- **Example Use Case**: RoleBinding for managing access within a namespace, ClusterRoleBinding for managing access across multiple namespaces.



#################
# Setup Cluster #
#################

# Requirements
- kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

#Install k3d: 
- k3d installation guide: https://k3d.io/v5.4.6/#installation

#Create demo cluster:
k3d cluster create demo-cluster

# Create demo namespace
kubectl create namespace demo


#############################
# Install Stakatar Reloader #
#############################

# Stakatar reloader runs in the default namespace and watches for changes in all other namespaces
kubectl apply -f https://raw.githubusercontent.com/stakater/stakater-reloader/master/deployments/kubernetes/reloader.yaml

# Confirm that the reloader is running
kubectl get pods -n default

#######################
# Setup Demo Ping App #
#######################

# Clone the ping-app repo 
git clone https://github.com/galonge/ping-app.git

# Update the ping-app deployment to use the stakater reloader annotation

# Add the following annotation to the metadata field of the ping-app deployment
File: /deploy-gke/base/ping-app.yml 

```
  annotations:
    reloader.stakater.com/auto: "true"
```

Full deployment file should now be as follows:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ping-app
  annotations:
    reloader.stakater.com/auto: "true"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ping-app
  template:
    metadata:
      labels:
        app: ping-app
    spec:
      containers:
        - name: ping-app
          image: ghcr.io/galonge/ping-app:1.0
          envFrom:
          - configMapRef:
              name: app-config
          resources:
            requests:
              cpu: 50m
              memory: 64Mi
            limits:
              cpu: 50m
              memory: 64Mi
          command: ["/app/ping.sh", "$(PING_HOST)"]
  ```

# Apply the ping-app deployment to the demo namespace
kubectl apply -k deploy-gke/base/v1 -n demo

# Confirm that the ping-app deployment is running
kubectl get pods -n demo


##########################
# Test Stakatar Reloader #
##########################

# Watch running pods status in the demo namespace
kubectl get pods -n demo -w

# Preview the ping-app deployment logs (new terminal)
kubectl logs -f deployment/ping-app -n demo

# Get the name of the ping-app configmap with awk and edit  POD_HOST to facebook.com.
kubectl get configmap \
  -n demo | awk 'NR==2{print $1}' \
  | xargs kubectl edit configmap -n demo


# Confirm that the ping-app deployment is restarted and the logs show that the ping host is now facebook.com
kubectl logs -f deployment/ping-app -n demo


###########
# Destroy #
###########

# Delete the demo namespace and resources 
kubectl delete namespace demo

# Delete stakater Reloader
kubectl delete -f https://raw.githubusercontent.com/stakater/stakater-reloader/master/deployments/kubernetes/reloader.yaml
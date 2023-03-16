
#################
# Setup Cluster #
#################

# Requirements
- Docker
- kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

#Install k3d: 
- k3d installation guide: https://k3d.io/v5.4.6/#installation

#Create demo cluster:
k3d cluster create demo-cluster

# Create demo namespace
kubectl create namespace dev

# Set the demo namespace as the default namespace
kubectl config set-context --current --namespace=dev

#########################
# Setup Demo Microservice App #
#########################

# Clone the demo-app repo 
git clone https://github.com/galonge/voting-app-kustomized

# View content of the deploy/kustomize/overlays/v2 directory
tree deploy/kustomize/overlays/v2 -L 2

cat deploy/kustomize/overlays/v2/vote-ui-service.yaml

# Apply the v2 manifests to the demo namespace
kubectl apply -k deploy/kustomize/overlays/v2

# Confirm that the voting deployment is running
kubectl get pods

# Confirm that the voting service is running
kubectl get svc

# Confirm app is unreachable from a browser.

##########################
# Update k3d cluster     #
##########################

# Update the k3d cluster to map the node ports 31000 to 31005 to the host machine
k3d cluster edit demo-cluster --port-add 31000-31005:31000-31005@loadbalancer

# Confirm that the k3d cluster has been updated and the app is now reachable from a browser.

# Preview the voting app deployment logs (new terminal)
kubectl logs -f deployment/vote-ui

# Delete the cluster and recreate setting the port mapping
k3d cluster delete demo-cluster

k3d cluster create demo-cluster --agents 2 --port 31000-31005:31000-31005@loadbalancer


###########
# Destroy #
###########

# Delete the cluster and all resources
k3d cluster delete demo-cluster

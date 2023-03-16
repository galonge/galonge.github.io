
######################
  # Setup Cluster ###
######################

# Requirements
- kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

#Install k3d: 
- k3d installation guide: https://k3d.io/v5.4.6/#installation



###########################
  # Create demo cluster. 
  # The --agents 2 flag creates 2 worker nodes
  # The --port 31000-31005:31000-31005@loadbalancer 
  # flag maps the node ports 31000 to 31005 to the host machine
###########################
k3d cluster create demo-cluster --agents 2 --port 31000-31005:31000-31005@loadbalancer

aclea

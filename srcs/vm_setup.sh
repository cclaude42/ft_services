#!/bin/bash

vm_setup()
{
	if [ ! -f ~/.vm_setup ];
	then
		echo "Setting up VM..."
		sudo apt update &> /dev/null
		echo "Updating kubectl..."
		sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl &> /dev/null
		echo "Updating minikube..."
		sudo curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o /usr/local/bin/minikube &> /dev/null
		sudo chmod +x /usr/local/bin/kubectl /usr/local/bin/minikube &> /dev/null
		echo "Setting docker user..."
		touch ~/.vm_setup
		echo "VM is set !"
		echo "Run ./setup.sh again."
		sudo usermod -aG docker user42 && newgrp docker
	fi
}

vm_setup

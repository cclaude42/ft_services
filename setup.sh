#!/bin/bash -e

vm_setup()
{
	if [ ! -f ~/.vm_setup ];
	then
		echo "Setting up VM..."
		sudo apt update &> /dev/null
		sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl &> /dev/null
		sudo curl -L minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o /usr/local/bin/minikube &> /dev/null
		sudo chmod +x /usr/local/bin/kubectl /usr/local/bin/minikube &> /dev/null
		sudo usermod -aG docker user42 &> /dev/null
		sudo newgrp docker &
		touch ~/.vm_setup
	fi
}

minikube_setup()
{
	minikube delete
	minikube start --driver=docker --cpus=2
	minikube addons enable metrics-server
	minikube addons enable dashboard
	minikube addons enable metallb
	kubectl apply -f srcs/yaml_metallb/metallb.yaml
	eval $(minikube docker-env)
}

image_build()
{
	docker build -t ${1}_alpine srcs/$1/.
}

deployment_build()
{
	kubectl create -f srcs/yaml_deployments/$1.yaml
}

service_build()
{
	kubectl create -f srcs/yaml_services/$1.yaml
}

images()
{
	imgs=("nginx" "wordpress" "mysql" "phpmyadmin")

	for img in "${imgs[@]}"
	do
		image_build $img
	done
}

deployments()
{
	deps=("nginx" "wordpress" "mysql" "phpmyadmin")

	for dep in ${deps[@]}
	do
		deployment_build $dep
	done
}

services()
{
	svcs=("nginx" "wordpress" "mysql" "phpmyadmin")

	for svc in ${svcs[@]}
	do
		service_build $svc
	done
}

custom()
{
	for i in $@
	do
		if [[ $i =~ ^(nginx|wordpress|mysql|phpmyadmin|influxdb|grafana|ftps)$ ]];
		then
			image_build $i
			deployment_build $i
			service_build $i
		elif [ $i = vm ]
		then
			vm_setup
		elif [ $i = minikube ]
		then
			minikube_setup
		elif [ $i = img ]
		then
			images
		elif [ $i = dep ]
		then
			deployments
		elif [ $i = svc ]
		then
			services
		fi
	done
}

main()
{
	vm_setup
	minikube_setup
	images
	deployments
	services
}

if [ $1 ]
then
	custom $@
else
	main
fi

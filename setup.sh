#!/bin/bash

vm_setup()
{
	echo Setup VM
}

minikube_setup()
{
	minikube delete
	minikube start --driver=docker --cpus=2
	minikube addons enable metrics-server
	minikube addons enable dashboard
	eval $(minikube docker-env)
}

image_build()
{
	docker build -t ${1}_alpine srcs/$1/.
}

deployment_build()
{
	kubectl create -f ${1}_deployment srcs/yaml/deployments/$1.yaml
}

service_build()
{
	kubectl create -f ${1}_service srcs/yaml/services/$1.yaml
}

images()
{
	imgs=("nginx" "wordpress" "mysql")

	for img in "${imgs[@]}"
	do
		image_build $img
	done
}

deployments()
{
	deps=("nginx" "wordpress" "mysql")

	for dep in ${deps[@]}
	do
		deployment_build $dep
	done
}

services()
{
	svcs=("nginx" "wordpress" "mysql")

	for svc in ${svcs[@]}
	do
		service_build $svc
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

main

#!/bin/bash -e

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
	imgs=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps")

	for img in "${imgs[@]}"
	do
		image_build $img
	done
}

deployments()
{
	deps=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps")

	for dep in ${deps[@]}
	do
		deployment_build $dep
	done
}

services()
{
	svcs=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps")

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
	./srcs/vm_setup.sh
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

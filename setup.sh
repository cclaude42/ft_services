#!/bin/bash -e

minikube_setup()
{
	minikube delete
	minikube start --driver=docker --cpus=2
	minikube addons enable metrics-server
	minikube addons enable dashboard &> /dev/null
	echo "🌟  The 'dashboard' addon is enabled"
	minikube addons enable metallb
	kubectl apply -f srcs/yaml_metallb/metallb.yaml
	eval $(minikube docker-env)
	echo
}

image_build()
{
	echo "Building $1 image..."
	docker build -t ${1}_alpine srcs/$1/. | grep "Step"
	echo -e "Successfully built $1 image !\n"
}

deployment_build()
{
	kubectl create -f srcs/yaml_deployments/$1.yaml &> /dev/null
	echo -e "Successfully deployed $1 !"
}

service_build()
{
	kubectl create -f srcs/yaml_services/$1.yaml &> /dev/null
	echo -e "Successfully exposed $1 !"
}

images()
{
	imgs=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps")

	for img in "${imgs[@]}"
	do
		image_build $img
	done
	echo
}

deployments()
{
	deps=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps")

	for dep in ${deps[@]}
	do
		deployment_build $dep
	done
	echo
}

services()
{
	svcs=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps")

	for svc in ${svcs[@]}
	do
		service_build $svc
	done
	echo
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
	echo "Ft_services is ready !"
}

if [ $1 ]
then
	custom $@
else
	main
fi

#!/bin/bash -e

RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
PURPLE="\e[95m"
CYAN="\e[96m"
WHITE="\e[97m"

banner()
{
	echo -e $PURPLE
	echo "###############################################################################################"
	echo -e $CYAN
	echo " 8888888888 88888888888                                          d8b                           "
	echo " 888            888                                              Y8P                           "
	echo " 888            888                                                                            "
	echo " 8888888        888           .d8888b   .d88b.  888d888 888  888 888  .d8888b .d88b.  .d8888b  "
	echo " 888            888           88K      d8P  Y8b 888P\"   888  888 888 d88P\"   d8P  Y8b 88K      "
	echo " 888            888           \"Y8888b. 88888888 888     Y88  88P 888 888     88888888 \"Y8888b. "
	echo " 888            888                X88 Y8b.     888      Y8bd8P  888 Y88b.   Y8b.          X88 "
	echo " 888            888   88888888 88888P'  \"Y8888  888       Y88P   888  \"Y8888P \"Y8888   88888P' "
	echo -e $PURPLE
	echo "###############################################################################################"
	echo -e $WHITE
}

footer()
{
	echo -e $GREEN
	kubectl get svc
	echo -e $CYAN
	echo "FT_SERVICES IS READY !"
	echo "Go to 172.17.0.2 to try it."
	echo -e $GREEN
	echo "Services    | Wordpress  | Grafana    | FTPS       | SSH        "
	echo "Login       | wp_admin   | admin      | ftp_admin  | ssh_admin  "
	echo "Password    | 1010       | admin      | 01010      | 0101       "
	echo -e $WHITE
}

minikube_setup()
{
	echo "Configuring minikube..."
	echo -en $BLUE
	minikube delete
	minikube start --driver=docker --cpus=2
	minikube addons enable metrics-server
	minikube addons enable dashboard &> /dev/null
	echo "🌟  The 'dashboard' addon is enabled"
	minikube addons enable metallb
	kubectl apply -f srcs/yaml_metallb/metallb.yaml
	eval $(minikube docker-env)
	echo -en $GREEN
	echo "Minikube is ready !"
}

image_build()
{
	echo -en $WHITE
	echo "Building $1 image..."
	echo -en $YELLOW
	docker build -t ${1}_alpine srcs/$1/. | grep "Step"
	echo -en $GREEN
	echo "Successfully built $1 image !\n"
}

deployment_build()
{
	kubectl apply -f srcs/yaml_deployments/$1.yaml &> /dev/null
	echo -en $BLUE
	echo "Successfully deployed $1 !"
}

volume_build()
{
	kubectl apply -f srcs/yaml_volumes/$1.yaml &> /dev/null
	echo -en $RED
	echo "Successfully created $1 volume !"
}

service_build()
{
	kubectl apply -f srcs/yaml_services/$1.yaml &> /dev/null
	echo -en $BLUE
	echo "Successfully exposed $1 !"
}

images()
{
	imgs=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps" "grafana" "influxdb")

	for img in "${imgs[@]}"
	do
		image_build $img
	done
	echo
}

deployments()
{
	deps=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps" "grafana" "influxdb")

	for dep in ${deps[@]}
	do
		deployment_build $dep
	done
	echo
}

volumes()
{
	deps=("mysql" "influxdb")

	for dep in ${deps[@]}
	do
		volume_build $dep
	done
	echo
}

services()
{
	svcs=("nginx" "wordpress" "mysql" "phpmyadmin" "ftps" "grafana" "influxdb")

	for svc in ${svcs[@]}
	do
		service_build $svc
	done
	echo
}

main()
{
	./srcs/vm_setup.sh
	banner
	minikube_setup
	images
	deployments
	volumes
	services
	footer
}

custom()
{
	for i in $@
	do
		if [[ $i =~ ^(nginx|wordpress|mysql|phpmyadmin|ftps|grafana|influxdb)$ ]];
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

if [ $1 ]
then
	custom $@
else
	main
fi

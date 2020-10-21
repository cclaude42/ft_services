# ft_services

42 project, setup of a Kubernetes cluster. Services include an nginx, an FTPS, a Wordpress and a PHPMyAdmin working with a MySQL database, and a Grafana linked to an InfluxDB database for monitoring. The script builds the custom Docker images for each of those, before deploying and exposing them all with custom yaml files.

## Final grade : 100/100

Mandatory part : 100/100

### How to use it

Simply run the setup script :

```
./setup.sh
```

Run it again once it's installed the requirements.

### Outside the VM

This project is meant to run is the 42 xubuntu VM. Running it anywhere else would cause problems, because of the VM setup. If you want to run it anywhere else, install the requirements (minikube, kubectl, docker...) yourself and run :

```
./setup.sh x
```

### Available options

You can run the script with a few options, if you only want certain things.

For example, ``./setup.sh minikube img`` will only setup minikube and build images.

``./setup.sh nginx`` would build, deploy and expose nginx only (careful, minikube needs to be set up). Useful to reset certain containers without resetting everything.

Following that logic, ``./setup.sh vm minikube img dep svc`` or ``./setup.sh vm minikube nginx wordpress mysql phpmyadmin ftps grafana influxdb`` do the same as ``./setup.sh``.

### Credit

Thank you to macrespo, darbib and lnezonde, who helped me understand any and all of this. Without them, I'd probably still be searching Google to understand what a server is.

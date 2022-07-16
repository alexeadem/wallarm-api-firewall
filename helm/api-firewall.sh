#!/bin/bash
#helm install -f api-firewall/values.yaml api-firewall ./api-firewall

usage (){
	echo "$0 {install | uninstall}"
	exit  1;
}

if [ ! -z $1 ]; then

	if [ "install" = "$1" ]; then

		helm install -f api-firewall.yaml api-firewall ./api-firewall
	elif [ "uninstall" = "$1" ]; then

		helm uninstall api-firewall
	else
		usage
	fi

else 
	usage
fi

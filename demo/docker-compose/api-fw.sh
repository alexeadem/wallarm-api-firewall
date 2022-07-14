#!/bin/bash

F=docker-compose.yml


usage () {
	echo -e "\033[31;1m $0\033[0m \033[37;1m { start | stop | restart | logs | mode { log | block } } \033[0m"
	exit 1;

}

if [ ! -z $1 ]; then

	if [ "$1" = "start" ]; then
		echo -e "\033[42;1m starting $0 \033[0m"
		(set -x; make start)
	elif [ "$1" = "stop" ]; then
		echo -e "\033[42;1m stopping $0 \033[0m"
		(set -x; make stop)
	elif [ "$1" = "restart" ]; then
		echo -e "\033[42;1m stopping $0 \033[0m"
                (set -x; make stop)
		echo -e "\033[42;1m starting $0 \033[0m"
                (set -x; make start)
	elif [ "$1" = "logs" ]; then
		echo -e "\033[44;1m test #3: docker logs \033[0m"
		(set -x; docker logs api-firewall)
	elif [ "$1" = "mode" ]; then
		if [ ! -z $2 ]; then
			if [ "log" = "$2" ]; then
                		sed -i 's/APIFW_REQUEST_VALIDATION: .*$/APIFW_REQUEST_VALIDATION: \"LOG_ONLY\"/g' $F
                		sed -i 's/APIFW_RESPONSE_VALIDATION: .*$/APIFW_RESPONSE_VALIDATION: \"LOG_ONLY\"/g' $F
                		cat $F | grep --color=always APIFW_.*_VALIDATION
        		elif [ "block" = "$2" ]; then
                		sed -i 's/APIFW_REQUEST_VALIDATION: .*$/APIFW_REQUEST_VALIDATION: \"BLOCK\"/g' $F
                		sed -i 's/APIFW_RESPONSE_VALIDATION: .*$/APIFW_RESPONSE_VALIDATION: \"BLOCK\"/g' $F
                		cat $F | grep --color=always APIFW_.*_VALIDATION
			else
				usage
			fi
		else
			usage
		fi
	else
		usage
	fi
else
	usage

fi



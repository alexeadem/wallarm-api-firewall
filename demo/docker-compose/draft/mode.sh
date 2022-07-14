#!/bin/bash


F=docker-compose.yml
usage () {
	echo "$0 { block | log }"
	exit 1
}

if [ ! -z $1 ]; then

	if [ "log" = "$1" ]; then
		sed -i 's/APIFW_REQUEST_VALIDATION: .*$/APIFW_REQUEST_VALIDATION: \"LOG_ONLY\"/g' $F
		sed -i 's/APIFW_RESPONSE_VALIDATION: .*$/APIFW_RESPONSE_VALIDATION: \"LOG_ONLY\"/g' $F
		cat $F | grep --color=always APIFW_.*_VALIDATION
	elif [ "block" = "$1" ]; then
		sed -i 's/APIFW_REQUEST_VALIDATION: .*$/APIFW_REQUEST_VALIDATION: \"BLOCK\"/g' $F
		sed -i 's/APIFW_RESPONSE_VALIDATION: .*$/APIFW_RESPONSE_VALIDATION: \"BLOCK\"/g' $F
		cat $F | grep --color=always APIFW_.*_VALIDATION
	fi
else
	usage
fi

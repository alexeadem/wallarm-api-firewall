#!/bin/bash

usage () {
	
        echo -e "\033[31;1m $0\033[0m \033[37;1m { enforce | discover } \033[0m"
        exit 1;
}

if [ ! -z $1 ]; then
	if [ "$1" = "enforce" ]; then
		echo -e "\033[41;1m test #1: unexposed path \e[0m"
		(set -x; curl -sD - http://localhost:8080/unexposed/path)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[41;1m test #2: required int \033[0m"
		(set -x; curl -sD - http://localhost:8080/get?int=arewfser)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[41;1m test #3: required query param \033[0m"
		(set -x; curl -sD - http://localhost:8080/get)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[42;1m test #4: valid range \033[0m"
		(set -x; curl -sD - http://localhost:8080/get?int=15)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[41;1m test #5: invalid range \033[0m"
		(set -x; curl -sD - http://localhost:8080/get?int=5)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[41;1m test #6: 8-byte integer overflow \033[0m"
		# POTENTIAL EVIL: 8-byte integer overflow can respond with stack drop
		(set -x; curl -sD - http://localhost:8080/get?int=18446744073710000001)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[41;1m test #7: invalid regex \033[0m"
		# Request with the str parameter value that does not match the defined regular expression
		(set -x; curl -sD - "http://localhost:8080/get?int=15&str=faswerffa-63sss54")
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[42;1m test #8: valid regex \033[0m"
		# Request with the str parameter value that does not match the defined regular expression
		(set -x; curl -sD - "http://localhost:8080/get?int=15&str=ri0.2-3ur0-6354")
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[41;1m test #9: regex sqli \033[0m"
		# Request with the str parameter value that does not match the defined regular expression
		(set -x; curl -sD - 'http://localhost:8080/get?int=15&str=";SELECT%20*%20FROM%20users.credentials;"')
	elif [ "$1" =  "discover" ]; then
		echo -e "\033[41;1m test #1: shadow API endpoint \e[0m"
		(set -x; curl -sD - http://localhost:8080/)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[42;1m test #2: nonexistent API endpoint \033[0m"
		(set -x; curl -sD - "http://localhost:8080/sss<code></code>")
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[44;1m test #3: docker logs \033[0m"
		(set -x; docker logs api-firewall)
		read -n 1 -s -r -p "<Press any key to continue>"
		printf "\n"
		echo -e "\033[44;1m test #5: shadow api log entry \033[0m"
		(set -x; docker logs api-firewall 2>&1 | grep --color=always Shadow)
	else
		usage

	fi
else 
	usage
fi


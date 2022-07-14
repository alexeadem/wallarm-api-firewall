#!/bin/bash
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



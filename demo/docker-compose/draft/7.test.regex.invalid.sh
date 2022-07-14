# Request with the str parameter value that does not match the defined regular expression
(set -x; curl -sD - "http://localhost:8080/get?int=15&str=faswerffa-63sss54")


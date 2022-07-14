# POTENTIAL EVIL: 8-byte integer overflow can respond with stack drop
(set -x; curl -sD - http://localhost:8080/get?int=18446744073710000001)

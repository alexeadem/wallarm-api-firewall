#!/bin/bash
(set -x; curl -sD - http://localhost:8080/unexposed/path)

#!/bin/bash
cd volumes/init-backend/
ls -1 | egrep '.(yml|yaml)$$' | sort | xargs -L1 kubectl create -f || true

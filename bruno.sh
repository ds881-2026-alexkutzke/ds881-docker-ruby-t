#!/usr/bin/env sh
set -eu

docker build -f bruno.Dockerfile -t bruno-calculadora:latest .
docker run -d --name bruno-calculadora -p 8080:8080 bruno-calculadora:latest

#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Use stop {name} (name is your container name)."
    exit 1
fi

docker stop $1
docker stop mysql-server

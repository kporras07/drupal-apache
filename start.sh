#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Use start.sh {name} (name is your container name)."
    exit 1
fi

docker start mysql-server
docker start $1

#!/bin/bash

MYSQL_PASSWORD='root'
DOCROOT=`pwd`
VOLUME=' '
NAME=' '
SSH_PORT=22
APACHE_PORT=80

for i in "$@"
do
    case $i in
        -d=*|--docroot=*)
            DOCROOT="${i#*=}"
            shift # past argument=value
            ;;
        -v=*|--volume=*)
            VOLUME=" -v ${i#*=} "
            shift # past argument=value
            ;;
        -p=*|--mysql-password=*)
            MYSQL_PASSWORD="${i#*=}"
            shift # past argument=value
            ;;
        -n=*|--name=*)
            NAME=" --name=${i#*=} "
            shift # past argument=value
            ;;
        -s=*|--ssh-port=*)
            SSH_PORT="${i#*=}"
            shift # past argument=value
            ;;
        -a=*|--apache-port=*)
            APACHE_PORT="${i#*=}"
            shift # past argument=value
            ;;
        -h|--help)
            echo 'Usage of run-first-time.sh:'
            echo '-d="", --docroot=""  Path to mount as apache docroot. (Only local path). Do not use it for actual path. Use only absolute paths.'
            echo '-v="", --volume=""    Path to mount as extra volume. Format: /local/path:/docker/path. Use only absolute paths.'
            echo '-p="", --mysql-password="" Password for mysql. Do not use it for "root"'
            echo '-n="", --name="" Name for identifying this container.'
            echo '-s="", --ssh-port="" Port for ssh. Defaults to 22.'
            echo '-a="", --apache-port="" Port for apache. Defaults to 80.'
            echo '-h="", --help Prints this help.'
            exit 0
            shift
            ;;
        *)
            echo 'Unrecognized options. Exiting'
            exit 1
            # unknown option
            ;;
    esac
done

docker run --name mysql-server -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD -d mysql:5.5
docker run -p $SSH_PORT:22 -p $APACHE_PORT:80 -v $DOCROOT:/home/www $VOLUME $NAME --link mysql-server:mysq-server -d jmsv23/drupal-apache

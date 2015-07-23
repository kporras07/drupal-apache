#!/bin/bash

service ssh restart
service apache2 start
service mysql start
tail -F /start.sh
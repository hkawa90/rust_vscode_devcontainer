#!/bin/bash

container_name=$1
user_id=`id -u`

docker build -t $container_name --build-arg user=$USER --build-arg userid=$user_id .


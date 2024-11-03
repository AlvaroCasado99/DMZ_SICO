#!/bin/bash
ssh-keygen -f "/home/horus/.ssh/known_hosts" -R "[172.17.0.2]:2222"
ssh-keygen -f "/home/horus/.ssh/known_hosts" -R "172.17.0.2"
ssh-keygen -f "/home/horus/.ssh/known_hosts" -R "[172.17.0.3]:2222"
ssh-keygen -f "/home/horus/.ssh/known_hosts" -R "172.17.0.3"

docker stop test
docker rm test
docker rmi test

docker build --tag test .
docker run --name test --privileged -d test

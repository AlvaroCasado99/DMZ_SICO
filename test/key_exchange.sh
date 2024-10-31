#!/bin/bash

USER="sico"
SERVER="172.17.0.2"
PORT=2222

# Delete previous keys
rm ~/.ssh/id_rsa.pub
rm ~/.ssh/id_rsa

# Generate Key-pair
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""

# Send pub key to server
ssh-copy-id -p $PORT $USER@$SERVER

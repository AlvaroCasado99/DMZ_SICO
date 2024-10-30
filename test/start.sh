#!/bin/bash

# Start Fail2Ban service
service fail2ban start

# Start SSH service
/usr/sbin/sshd -D

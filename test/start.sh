#!/bin/bash

# Initialize google-authenticator
#google-authenticator

# Start rsyslog daemon
# ... Con service no arranca
rsyslogd

# Start Fail2Ban service
service fail2ban start

# Start SSH service
/usr/sbin/sshd -D

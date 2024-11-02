#!/bin/bash

# Initialize google-authenticator
# google-authenticator -f -t -r 3 -R 30 -w 3 -l "docker@hostname" -s /root/.google_authenticator

# Start rsyslog daemon
rsyslogd

# Start Fail2Ban service
fail2ban-server -f &

# Start SSH service
/usr/sbin/sshd -D

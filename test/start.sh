#!/bin/bash

# Initialize google-authenticator
#google-authenticator


# Start rsyslog daemon
rsyslogd

# Start Fail2Ban service
fail2ban-server -f &

# Start SSH service
/usr/sbin/sshd -D

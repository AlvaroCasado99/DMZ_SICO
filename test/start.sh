#!/bin/bash

# Start rsyslog daemon
rsyslogd

# Start Fail2Ban service
fail2ban-server -f &

# Start SSH service
/usr/sbin/sshd -D

# Start supervisord
# ---- Supervisor es incompatible con rsyslogd
#/usr/bin/supervisord 

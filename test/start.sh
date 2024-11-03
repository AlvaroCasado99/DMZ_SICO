#!/bin/bash

# Initialize google-authenticator
#google-authenticator -f -t -r 6 -R 60 -w 3 -l "SICO" -s /home/sico/.google_authenticator

# Start rsyslog daemon
rsyslogd

# Start Fail2Ban service
fail2ban-server -D &

# Start SSH service
/usr/sbin/sshd -D

# Start supervisord
# ---- Supervisor es incompatible con rsyslogd
#/usr/bin/supervisord 

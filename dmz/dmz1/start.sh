#!/bin/bash

# Workarround para solventar el error que aparece si en la definici´on de la red ponemos como gateway
# la IP de m´aquina que queremos que ejerza como tal (en este caso, fw). No podemos poner IPs
# repetidas en el fichero docker-compose.yml
route add default gw 10.5.1.1
route del default gw 10.5.1.254

# Cambiar nombre interefaz
ip link set eth0 name dmz1

# Cowrie
iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222

# Iniciar servicio sshd
#/usr/sbin/sshd -D &

# Iniciar servico httpd
#apache2ctl -D FOREGROUND

# Exec supervidord
/usr/bin/supervisord

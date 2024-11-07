#!/bin/bash

# Workarround para solventar el error que aparece si en la definici´on de la red ponemos como gateway
# la IP de m´aquina que queremos que ejerza como tal (en este caso, fw). No podemos poner IPs
# repetidas en el fichero docker-compose.yml
route add default gw 10.5.2.1
route del default gw 10.5.2.254

# Cambiar nombre interefaz
ip link set eth0 name int3

# Iniciar el servidor openvpn
#openvpn --config /etc/openvpn/server.conf &

# Iniciar servicio sshd
#/usr/sbin/sshd -D

# Exec supervidord
/usr/bin/supervisord

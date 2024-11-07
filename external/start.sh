#!/bin/bash

# Workarround para solventar el error que aparece si en la definici´on de la red ponemos como gateway
# la IP de m´aquina que queremos que ejerza como tal (en este caso, fw). No podemos poner IPs
# repetidas en el fichero docker-compose.yml
route add default gw 10.5.0.1
route del default gw 10.5.0.254

# Cambiar nombre interefaz
ip link set eth0 name ext1

# Iniciar daemon de OpenVPN Client
openvpn --config /etc/openvpn/client.conf --daemon

# Iniciar servicio sshd
/usr/sbin/sshd -D &

# Iniciar servico httpd
apache2ctl -D FOREGROUND


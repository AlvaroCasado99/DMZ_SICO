#!/bin/bash

# Workarround para solventar el error que aparece si en la definici´on de la red ponemos como gateway
# la IP de m´aquina que queremos que ejerza como tal (en este caso, fw). No podemos poner IPs
# repetidas en el fichero docker-compose.yml
route add default gw 10.5.2.1
route del default gw 10.5.2.254

# Cambiar nombre interefaz
ip link set eth0 name int3

# Reglas Server VPN
#iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o int3 -j SNAT --to-source 10.5.2.22
#iptables -A FORWARD -i tun0 -o int3 -s 10.8.0.0/24 -d 10.5.2.0/24 -j ACCEPT
#iptables -A FORWARD -i int3 -o tun0 -s 10.5.2.0/24 -d 10.8.0.0/24 -j ACCEPT
#iptables -A INPUT -i tun0 -j ACCEPT

# Iniciar el servidor openvpn
#openvpn --config /etc/openvpn/server.conf &

# Iniciar servicio sshd
#/usr/sbin/sshd -D

# Exec supervidord
/usr/bin/supervisord

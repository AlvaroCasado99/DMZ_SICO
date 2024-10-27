#!/bin/bash

# Aseguro el bit de forwarding 
echo 1 > /proc/sys/net/ipv4/ip_forward

# Política para la cadena INPUT: Rechazar todo
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT 
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT 
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT 

# Politica para la cadena OUTPUT: Permitir todo
iptables -P OUTPUT ACCEPT

# Política para la cadena FORWARD: Rechazar todo
iptables -P FORWARD DROP

# Permitir el paso de paquetes para conexiones abiertas o relacionadas
iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir todas las conexiones que salcan de la red intena 
iptables -A FORWARD -i eth2 -s 10.5.2.0/24 -o eth1 -p tcp -j ACCEPT 
iptables -A FORWARD -i eth2 -s 10.5.2.0/24 -o eth1 -p udp -j ACCEPT 
iptables -A FORWARD -i eth2 -s 10.5.2.0/24 -o eth1 -p icmp -j ACCEPT

# Iniciar servicio sshd
/usr/sbin/sshd -D

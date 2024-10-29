#!/bin/bash

# Aseguro el bit de forwarding 
echo 1 > /proc/sys/net/ipv4/ip_forward

# Política para la cadena INPUT: Rechazar todo
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT 
# iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT 
iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED  -j ACCEPT 
iptables -A INPUT -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT 

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

# Configuro el fw para que enmascare las IPs de la red interna con la Ip de la gateway de la red externa
iptables -t nat -A POSTROUTING -s 10.5.2.0/24 -o eth1 -j SNAT --to-source 10.5.0.1

# --- Configuración de la política para la red DMZ
# Accesos permitidos tcp desde la red interna
iptables -A FORWARD -i eth2 -s 10.5.2.0/24 -o eth0 -p tcp --dport 80 -j ACCEPT

# Accesos permitidos tcp desde la red externa ¿?
iptables -A FORWARD -i eth1 -s 10.5.0.0/24 -o eth0 -p tcp --dport 80 -j ACCEPT

# Privilegio de administrador para la maquina Int1 
iptables -A FORWARD -i eth2 -s 10.5.2.20 -o eth0 -p tcp --dport 22 -j ACCEPT

# Prevenir ataques DoS con ICMP desde la red DMZ al fw
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/minute --limit-burst 5 -j ACCEPT

# Iniciar servicio sshd
/usr/sbin/sshd -D

FROM ubuntu:latest

EXPOSE 22
EXPOSE 1194/udp

COPY ./start.sh /start.sh

RUN apt-get update && apt-get install -y \
    openssh-server \
    net-tools \
    iputils-ping \
    traceroute \
    vim \
    iproute2 \
    tcpdump \
    nmap \
    iptables \
    pkg-config \
    curl \ 
    hping3 \
    openvpn \
    supervisor
    #easy-rsa

# Crea el directorio /run/sshd
RUN mkdir -p /run/sshd

# Permito la conexion con root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

# El entry point necesita permisos de ejecucion por ser un script
RUN chmod +x /start.sh

# Copiar configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# VPN configuration
COPY ./openvpn/dh2048.pem   /etc/openvpn/dh2048.pem
RUN chmod 600 /etc/openvpn/dh2048.pem
COPY ./openvpn/ca.crt       /etc/openvpn/ca.crt
RUN chmod 600 /etc/openvpn/ca.crt
COPY ./openvpn/server.crt   /etc/openvpn/server.crt
RUN chmod 600 /etc/openvpn/server.crt
COPY ./openvpn/server.key   /etc/openvpn/server.key
RUN chmod 600 /etc/openvpn/server.key
COPY ./openvpn/server.conf  /etc/openvpn/server.conf
COPY ./openvpn/ta.key       /etc/openvpn/ta.key
RUN chmod 600 /etc/openvpn/ta.key

RUN sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf

# Lanza los servicios
CMD ["/start.sh"]

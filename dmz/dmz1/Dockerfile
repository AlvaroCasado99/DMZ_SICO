FROM ubuntu:latest

EXPOSE 22
EXPOSE 80

COPY ./start.sh /start.sh
COPY ./index.html   /var/www/html/index.html

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
    apache2 \
    curl \
    hping3

# Crea el directorio /run/sshd
RUN mkdir -p /run/sshd

# Configuro el servicio apache
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

# Creo usuario ROOR
RUN echo 'root:root' | chpasswd

# Permito la conexion con root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Creo un usuario sin privilegios para crowie
RUN useradd -m sico && echo 'sico:sico' | chpasswd

#Doy permisos de ejecucion al start
RUN chmod +x /start.sh

CMD ["/start.sh"]

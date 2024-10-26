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
    curl 

# Crea el directorio /run/sshd
RUN mkdir -p /run/sshd

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

RUN echo 'root:root' | chpasswd

RUN chmod +x /start.sh

CMD ["/start.sh"]

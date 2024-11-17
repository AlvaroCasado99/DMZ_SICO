FROM ubuntu:latest

EXPOSE 22

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
    hping3

# Crea el directorio /run/sshd
RUN mkdir -p /run/sshd

# Permito la conexion con root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo 'root:root' | chpasswd

RUN chmod +x /start.sh


# Obtener las claves ssh
COPY ./ssh/id_rsa.pub /root/.ssh
COPY ./ssh/id_rsa /root/.ssh

CMD ["/start.sh"]

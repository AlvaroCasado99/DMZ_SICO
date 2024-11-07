FROM ubuntu:latest

EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 1149/udp

COPY ./start.sh /start.sh
COPY ./index.html   /var/www/html/index.html
COPY ./ssl.conf /etc/apache2/sites-available/ssl.conf 

RUN apt-get update && apt-get install -y \
    openssh-server \
    openssl \
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
    hping3 \
    openvpn \
    supervisor

# Crea el directorio /run/sshd
RUN mkdir -p /run/sshd

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

# Permito la conexion con root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo 'root:root' | chpasswd

RUN chmod +x /start.sh

# Copiar configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configuración SSL para Apache
# --- Generar un certificado de autofirmado para SSL (tambien la clave privada)
RUN mkdir -p /etc/apache2/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/server.key -out /etc/apache2/ssl/server.crt \
    -subj "/C=ES/ST=León/L=León/O=Universidad de León/OU=Facultad de Ingeniería/CN=10.5.0.20"
RUN a2enmod ssl     # Habilita el módulo SSL en Apache
RUN a2ensite ssl 

# Configuracioin de OpenVPN Client
COPY ./openvpn/ca.crt       /etc/openvpn
COPY ./openvpn/client.conf  /etc/openvpn
COPY ./openvpn/client.crt   /etc/openvpn
COPY ./openvpn/client.key   /etc/openvpn
COPY ./openvpn/ta.key       /etc/openvpn

CMD ["/start.sh"]

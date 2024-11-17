FROM ubuntu:latest

#EXPOSE 22
EXPOSE 2222
EXPOSE 80
EXPOSE 443

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
	git \
	python3-venv \
	libssl-dev \
	libffi-dev \
	build-essential \
	libpython3-dev \
	python3-minimal \
	authbind \
	iptables \
    supervisor

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

# Copiar configuracion de supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Configuración SSL para Apache
# --- Generar un certificado de autofirmado para SSL (tambien la clave privada)
RUN mkdir -p /etc/apache2/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/server.key -out /etc/apache2/ssl/server.crt \
    -subj "/C=ES/ST=León/L=León/O=Universidad de León/OU=Facultad de Ingeniería/CN=10.5.1.20"
RUN a2enmod ssl     # Habilita el módulo SSL en Apache
RUN a2ensite ssl

# COnfiguracion de cowrie
RUN adduser --disabled-password cowrie
USER cowrie
WORKDIR /home/cowrie
RUN git clone http://github.com/cowrie/cowrie
WORKDIR /home/cowrie/cowrie
RUN python3 -m venv cowrie-env
RUN cowrie-env/bin/pip install --upgrade pip
RUN cowrie-env/bin/pip install --upgrade -r requirements.txt
COPY --chown=cowrie:cowrie ./cowrie/cowrie.cfg /home/cowrie/cowrie/etc/cowrie.cfg
COPY --chown=cowrie:cowrie ./cowrie/userdb.txt /home/cowrie/cowrie/etc/userdb.txt

# Volver al usuario root
USER root
WORKDIR /

CMD ["/start.sh"]

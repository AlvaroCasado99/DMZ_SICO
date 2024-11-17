FROM ubuntu:latest

#EXPOSE 22
EXPOSE 2222
EXPOSE 80
EXPOSE 443

COPY ./start.sh /start.sh
COPY ./index.html   /var/www/html/index.html
COPY ./fail2ban /etc/fail2ban/jail.local
COPY ./custom_banner ./custom_banner
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
    fail2ban \
    rsyslog \
    # supervisor \ # rsyslog no funciona con supervisor
    libpam-google-authenticator

# Crea el directorio /run/sshd
RUN mkdir -p /run/sshd

# Configuro el servicio apache
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

# Permito la conexion con root
#RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#Creo usuario ROOR
RUN echo 'root:root' | chpasswd

#Doy permisos de ejecucion al start
RUN chmod +x /start.sh

# New user without privilages
RUN useradd -m -s /bin/bash sico &&  echo "sico:sico" | chpasswd


# ---------- SSH HARDENING -----------
# Change ssh default port to 2222
RUN sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Disable ssh root connection 
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Passwd login enable only if not empty
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Pubkey login enable
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Maximun number of login tries is 2
# ...En el proceso de conexión se consumen 2 intentos
RUN sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config

# Create a banner
RUN sed -i 's/#Banner none/Banner custom_banner/' /etc/ssh/sshd_config

# Fail2Ban

# TODO: Multififactor Authenticator (GoogleAuth)
RUN sed -i '/@include common-account/a auth required pam_google_authenticator.so' /etc/pam.d/sshd
RUN sed -i 's/UsePAM yes/UsePAM yes/' /etc/ssh/sshd_config
RUN sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config


# Configuración SSL para Apache
# --- Generar un certificado de autofirmado para SSL (tambien la clave privada)
RUN mkdir -p /etc/apache2/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/server.key -out /etc/apache2/ssl/server.crt \
    -subj "/C=ES/ST=León/L=León/O=Universidad de León/OU=Facultad de Ingeniería/CN=10.5.1.21"
RUN a2enmod ssl     # Habilita el módulo SSL en Apache
RUN a2ensite ssl


CMD ["/start.sh"]

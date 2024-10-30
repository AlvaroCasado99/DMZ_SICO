FROM ubuntu:latest

EXPOSE 2222

COPY ./start.sh ./start.sh
COPY ./custom_banner ./custom_banner
COPY ./fail2ban /etc/fail2ban/jail.local

# Download dependencies
RUN apt-get update && apt-get install -y \
	openssh-server \
	iputils-ping \
	iproute2 \
	traceroute \
	net-tools \
	nmap \
	vim \
	fail2ban \
	libpam-google-authenticator 

# Create folder /run/sshd
RUN mkdir -p /run/sshd

# Add execution privileged to start.sh
RUN chmod +x /start.sh

# Set root password
RUN echo "root:root" | chpasswd

# New user without privilages
RUN useradd -m -s /bin/bash sico &&  echo "sico:sico" | chpasswd

# ---------- SSH HARDENING -----------
# TODO: Change ssh default port to 2222
RUN sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config 

# TODO: Disable ssh root connection 
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# TODO: Passwd login enable only if not empty
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# TODO: Pubkey login enable
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# TODO: Maximun number of login tries is 2
# En el proceso de conexión se consumen 2 intentos
RUN sed -i 's/#MaxAuthTries 6/MaxAuthTries 4/' /etc/ssh/sshd_config

# TODO: Create a banner
RUN sed -i 's/#Banner none/Banner custom_banner/' /etc/ssh/sshd_config

# TODO: Fail2Ban
# Create logfile for Fail2ban
RUN sed -i 's/#SyslogFacility AUTH/SyslogFacility AUTH/' /etc/ssh/sshd_config
RUN sed -i 's/#LogLevel INFO/LogLevel INFO/' /etc/ssh/sshd_config
# Make sure log file exists
RUN touch /var/log/auth.log 

# TODO: Multififactor Authenticator (GoogleAuth)

CMD ["/start.sh"]

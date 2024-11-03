# DMZ_SICO

### Comandos:
- Comprobar el demonio de syslog: `docker exec test ps aux | grep rsyslogd`

(Debido a usar un certificado de autofirmado, los otros contenedores no confia en el Common Name y no aceptan la conexion)
- Petición HTTPS con `curl`: `curl -k https://IP_CONTENEDOR`
- Petición HTTPS con `wget`: `wget --no-check-certificate https://IP_CONTENEDOR`

Proceso para configurar google-authenticator
- Modo interactivo: `docker exec -it test /bin/bash`
- Cambiar a SICO: `su - sico`
- Inicializar: `google-authenticator -f -t -r 6 -R 60 -w 3 -l "SICO" -s /home/sico/.google_authenticator`
- Escaner QR desde el movil
- Volver a root: su - root
- Reiniciar SSH: `supervisorctl restart sshd` (fail2ban no funciona con supervisor)
- Ver registros: `cat /var/log/auth.log`



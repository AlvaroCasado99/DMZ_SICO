# DMZ_SICO

### Comandos:
- Comprobar el demonio de syslog: `docker exec test ps aux | grep rsyslogd`i

(Debido a usar un certificado de autofirmado, los otros contenedores no confia en el Common Name y no aceptan la conexion)
- Petición HTMLS con `curl`: `curl -k https://IP_CONTENEDOR`
- Petición HTMLS con `wget`: `wget --no-check-certificate https://IP_CONTENEDOR`


# Define imagem base
FROM ubuntu:latest
VOLUME /data
# Set timezone linux
ENV TZ=Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update do repositório
RUN apt-get update

# Instala apache
RUN apt-get -y install apache2

# Fix error Apache error “Could not reliably determine the server's fully 
# qualified domain name”
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn

# Escuta porta 80
EXPOSE 80

# Começa apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]



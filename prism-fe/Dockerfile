FROM ubuntu:jammy

RUN apt update && apt install apache2 -y && a2enmod rewrite headers proxy proxy_http lbmethod_byrequests && /etc/init.d/apache2 start

COPY workspace/ /var/www/html/

EXPOSE 80

# CMD ["tail", "-f", "/dev/null"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
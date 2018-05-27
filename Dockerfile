FROM alpine:3.7
RUN apk add --no-cache apache2 apache2-utils

RUN mkdir -p /run/apache2/

# PHP - APACHE
ADD httpd /

RUN set -eux \
	; apk add --no-cache --virtual \
	php7-apache2 \
	php7-mcrypt \ 
    php7-soap \ 
    php7-openssl \ 
	php7-mysqli \
	php7-pdo_mysql \
	php7-bz2 

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# SSH
RUN apk add --no-cache --virtual openssh-server openssh-server-common

RUN mkdir -p /root/.ssh

ADD ssh-key/id_rsa.pub /root/.ssh/authorized_keys

RUN echo "PermitRootLogin Yes" | tee -a /etc/ssh/sshd_config

CMD ["/bin/sh","/etc/init.d/sshd","restart"]

EXPOSE 80 443 22

CMD ["/bin/sh","/httpd"]
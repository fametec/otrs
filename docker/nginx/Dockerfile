FROM nginx

MAINTAINER eduardo@fametec.com.br

ADD certs/fametec.crt /etc/nginx/

ADD certs/fametec.key /etc/nginx/

ADD index.html /usr/share/nginx/html/

ADD nginx.conf /etc/nginx/nginx.conf

VOLUME [ "/etc/nginx/", "/usr/share/nginx/html/" ]

EXPOSE 80 443

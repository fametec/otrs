FROM docker.io/debian:stable

ENV OTRS_VERSION 6.0.28
ENV LANGUAGE pt_BR
ENV FQDN "localhost"
ENV ADMINEMAIL "root@localhost"
ENV ORGANIZATION "FAMETEC"
ENV DB_TYPE mysql
ENV DB_NAME otrs
ENV DB_USER otrs
ENV DB_PASSWORD otrs
ENV DB_HOST db-otrs

RUN apt-get update && apt-get -y update

RUN apt-get install -qq --no-install-recommends -y \
	supervisor \
	libapache2-mod-perl2 \
	libdbd-mysql-perl \
	libtimedate-perl \
	libnet-dns-perl \
	libnet-ldap-perl \
	libio-socket-ssl-perl \
	libpdf-api2-perl \
	libdbd-mysql-perl \
	libsoap-lite-perl \
	libtext-csv-xs-perl \
	libjson-xs-perl \
	libapache-dbi-perl \
	libxml-libxml-perl \
	libxml-libxslt-perl \
	libyaml-perl \
	libyaml-libyaml-perl \
	libarchive-zip-perl \
	libcrypt-eksblowfish-perl \
	libencode-hanextra-perl \
	libmail-imapclient-perl \
	libauthen-sasl-perl \
	libtemplate-perl \
	libcrypt-ssleay-perl \
	libdatetime-perl \
	libdbd-odbc-perl \
	libdbd-pg-perl \
	libauthen-ntlm-perl \
	libmoo-perl \
	curl \
	apache2 \ 
	cron \
	anacron

ADD https://ftp.otrs.org/pub/otrs/otrs-6.0.28.tar.gz / 

RUN tar -zxvf /otrs-6.0.28.tar.gz -C /opt \
	&& mv /opt/otrs-6.0.28 /opt/otrs \
	&& rm -f /otrs-6.0.28.gz

RUN perl /opt/otrs/bin/otrs.CheckModules.pl

RUN useradd -d /opt/otrs -c 'OTRS user' otrs \
	&& usermod -G www-data otrs

ADD confs/Config.pm /opt/otrs/Kernel/Config.pm

RUN perl -cw /opt/otrs/bin/cgi-bin/index.pl \
	&& perl -cw /opt/otrs/bin/cgi-bin/customer.pl \
	&& perl -cw /opt/otrs/bin/otrs.Console.pl

ADD confs/zzz_otrs.conf /etc/apache2/sites-available/zzz_otrs.conf

RUN a2ensite zzz_otrs \
	&& a2enmod perl \
	&& a2enmod deflate \
	&& a2enmod filter \
	&& a2enmod headers

RUN /opt/otrs/bin/otrs.SetPermissions.pl

ADD scripts /scripts

ADD confs/otrs-cron /etc/cron.d/otrs-cron 

ADD confs/otrs-supervisor.conf /etc/supervisor/conf.d/

RUN cd /opt/otrs/var/cron \
	&& for foo in *.dist; do mv $foo `basename $foo .dist`; done 

RUN chmod 755 /etc/cron.d/otrs-cron /scripts/install_modules.sh /scripts/secure_mode.sh

VOLUME ["/opt/otrs/"]

EXPOSE 80/tcp

CMD [ "/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf" ]
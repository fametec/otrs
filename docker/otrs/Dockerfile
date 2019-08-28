FROM docker.io/debian:stable

ENV LANGUAGE pt_BR
ENV FQDN "localhost"
ENV ADMINEMAIL "root@localhost"
ENV ORGANIZATION "FAMETEC"
ENV DB_TYPE mysql
ENV DB_NAME otrs
ENV DB_USER otrs
ENV DB_PASSWORD otrs
ENV DB_HOST db-otrs

#RUN apt update && apt install -y locales && rm -rf /var/lib/apt/lists/* \
#    && localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8

RUN apt-get update && apt-get -y update

RUN apt-get install -qq --no-install-recommends -y \
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
	curl \
	apache2\ 
	ssl-cert \
	cron \
	anacron

# ADD otrs-6.0.18 /opt/otrs 
ADD http://ftp.otrs.org/pub/otrs/otrs-6.0.21.tar.gz / 

RUN tar -zxvf /otrs-6.0.21.tar.gz -C /opt && mv /opt/otrs-6.0.21 /opt/otrs \
	&& rm -f /otrs-6.0.21.tar.gz
	

# wget -c http://ftp.otrs.org/pub/otrs/otrs-6.0.18.tar.gz

RUN perl /opt/otrs/bin/otrs.CheckModules.pl

RUN useradd -d /opt/otrs -c 'OTRS user' otrs \
	&& usermod -G www-data otrs

ADD Config.pm /opt/otrs/Kernel/Config.pm

RUN perl -cw /opt/otrs/bin/cgi-bin/index.pl \
	&& perl -cw /opt/otrs/bin/cgi-bin/customer.pl \
	&& perl -cw /opt/otrs/bin/otrs.Console.pl

ADD zzz_otrs.conf /etc/apache2/sites-enabled/zzz_otrs.conf

RUN a2enmod perl \
	&& a2enmod deflate \
	&& a2enmod filter \
	&& a2enmod headers

RUN a2ensite default-ssl \
	&& a2enmod ssl

RUN /opt/otrs/bin/otrs.SetPermissions.pl

ADD secure_mode.sh configure.sh install_modules.sh entrypoint.sh /

ADD otrs-cron /etc/cron.d/otrs-cron 

RUN cd /opt/otrs/var/cron \
	&& for foo in *.dist; do mv $foo `basename $foo .dist`; done 

RUN chmod 755 /etc/cron.d/otrs-cron /entrypoint.sh /install_modules.sh /secure_mode.sh /configure.sh

VOLUME ["/opt/otrs/"]

EXPOSE 80/tcp 443/tcp

ENTRYPOINT ["/entrypoint.sh" ]


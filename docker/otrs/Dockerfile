FROM docker.io/debian:9.6

#ENV LANG pt_BR.utf8

ENV FQDN "localhost"
ENV ADMINEMAIL "root@localhost"
ENV ORGANIZATION "FAMETEC"
ENV MYSQL_ROOT_PASSWORD "qaz123"
ENV DBUSER "otrs"
ENV DBHOST "172.17.0.2"
ENV DBNAME "otrs"
ENV SYSTEMID "12"
ENV MYSQL_NEW_ROOT_PASSWORD "qaz123"
ENV MYSQL_NEW_OTRS_PASSWORD "otrs"




#RUN apt update && apt install -y locales && rm -rf /var/lib/apt/lists/* \
#    && localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8

RUN apt update && apt -y update

RUN apt install -y \
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
	libarchive-zip-perl \
	libcrypt-eksblowfish-perl \
	libencode-hanextra-perl \
	libmail-imapclient-perl \
	libtemplate-perl \
	libcrypt-ssleay-perl \
	libdatetime-perl \
	libdbd-odbc-perl \
	libdbd-pg-perl \
	libauthen-ntlm-perl \
	curl \
	apache2 

	
ADD otrs-6.0.16 /opt/otrs

RUN perl /opt/otrs/bin/otrs.CheckModules.pl

RUN useradd -d /opt/otrs -c 'OTRS user' otrs \
	&& usermod -G www-data otrs

ADD Config.pm /opt/otrs/Kernel/Config.pm
# ADD RUN cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm

RUN perl -cw /opt/otrs/bin/cgi-bin/index.pl \
	&& perl -cw /opt/otrs/bin/cgi-bin/customer.pl \
	&& perl -cw /opt/otrs/bin/otrs.Console.pl

# RUN ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/zzz_otrs.conf

ADD zzz_otrs.conf /etc/apache2/sites-enabled/zzz_otrs.conf

RUN a2enmod perl \
	&& a2enmod deflate \
	&& a2enmod filter \
	&& a2enmod headers

RUN /opt/otrs/bin/otrs.SetPermissions.pl

ADD *.sh /

RUN chmod 755 /entrypoint.sh /configure.sh

EXPOSE 80 443

CMD [ "apache2ctl", "-d", "/etc/apache2", "-D", "FOREGROUND" ]

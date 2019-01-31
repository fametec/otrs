FROM fametec/otrs:latest


RUN apt install -y cron anacron

# ADD crontab /etc/crontab

RUN cd /opt/otrs/var/cron \
	&& for foo in *.dist; do cp $foo `basename $foo .dist`; done \
	&& su -c '/opt/otrs/bin/Cron.sh start' -s /bin/bash otrs

RUN echo '*/5 * * * * otrs /opt/otrs/bin/otrs.Daemon.pl start' >> /etc/crontab

CMD [ "cron", "-f" ]


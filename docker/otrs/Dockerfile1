FROM docker.io/juanluisbaptiste/otrs

# OTRS_HOSTNAME Sets the container's hostname (auto-generated if not defined).
# OTRS_DB_NAME Name of database to use. Default is otrs.
# OTRS_DB_HOST Hostname or IP address of the database server. Default is mariadb.
# OTRS_DB_PORT Port of the database server. Default is 3306.
# OTRS_DB_USER Database user. Default is otrs.
# OTRS_DB_PASSWORD otrs user database password. Default password is changeme.
# OTRS_ROOT_PASSWORD root@localhost user password. Default password is changeme.
# MYSQL_ROOT_PASSWORD Database root password so it can be setup. Default password is changeme.
# OTRS_LANGUAGE Set the default language for both agent and customer interfaces (For example, "es" for spanish).
# OTRS_TIMEZONE to set the default timezone.
# OTRS_TICKET_COUNTER Sets the starting point for the ticket counter.
# OTRS_NUMBER_GENERATOR Sets the ticket number generator, possible values are : DateChecksum, Date, AutoIncrement or Random.
# SHOW_OTRS_LOGO To disable the OTRS ASCII logo at container startup.

ENV OTRS_HOSTNAME otrs
ENV OTRS_DB_NAME otrs
ENV OTRS_DB_HOST mariadb-otrs
# ENV OTRS_DB_PORT 3306
ENV OTRS_DB_USER otrs
ENV OTRS_DB_PASSWORD otrs
ENV OTRS_ROOT_PASSWORD qaz123
ENV MYSQL_ROOT_PASSWORD qaz123
ENV OTRS_LANGUAGE pt_BR
ENV OTRS_TIMEZONE America/Fortaleza
# ENV OTRS_TICKET_COUNTER
ENV OTRS_NUMBER_GENERATOR Date
# ENV SHOW_OTRS_LOGO no
# ENV OTRS_INSTALL yes

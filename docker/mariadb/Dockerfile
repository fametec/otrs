FROM docker.io/mariadb:latest

ENV MYSQL_ROOT_PASSWORD=qaz123
ENV MYSQL_DATABASE=otrs
ENV MYSQL_USER=otrs
ENV MYSQL_PASSWORD=otrs

# VOLUME /var/lib/mysql

# VOLUME /etc/mysql/conf.d

RUN { \
        echo '[mysqld]';\
	echo 'max_allowed_packet   = 64M'; \
	echo 'query_cache_size     = 32M'; \
	echo 'innodb_log_file_size = 256M'; \
	echo 'character-set-server = utf8'; \
	echo 'collation-server     = utf8_general_ci'; \
        echo; \
    } >> /etc/mysql/conf.d/otrs.cnf


EXPOSE 3306



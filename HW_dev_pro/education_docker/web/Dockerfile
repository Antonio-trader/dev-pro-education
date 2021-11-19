FROM   registry.access.redhat.com/ubi8/ubi:latest

RUN yum install -y sudo && \
    sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    sudo dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    sudo dnf -y install php php-common php-process php-xmlrpc php-xml php-soap php-snmp php-recode php-bcmath php-cli php-dba php-dbg php-mbstring php-odbc php-pecl-apcu-devel php-pecl-zip php-pgsql php-pecl-apcu php-pear php-pdo php-opcache php-devel php-embedded php-enchant php-gd php-fpm php-gmp php-intl php-ldap php-json php-mysqlnd php-pdo php-gd php-mbstring zip unzip tar wget && \
    sudo dnf -y install nginx nginx-all-modules && \
    sudo curl -o phpMyAdmin-5.0.0-all-languages.zip https://files.phpmyadmin.net/phpMyAdmin/5.0.0/phpMyAdmin-5.0.0-all-languages.zip && \
    sudo unzip -q phpMyAdmin*.zip && \
    sudo mv phpMyAdmin-5.0.0-all-languages /usr/share/nginx/html/phpmyadmin && \
    sudo cp /usr/share/nginx/html/phpmyadmin/config.sample.inc.php  /usr/share/nginx/html/phpmyadmin/config.inc.php && \
    sudo mkdir /var/lib/phpmyadmin && \
    sudo mkdir /var/lib/phpmyadmin/tmp && \
    sudo chown -R nginx:nginx /var/lib/phpmyadmin/tmp && \
    yum install -y policycoreutils && \
    sudo restorecon -Rv /usr/share/nginx/html/phpmyadmin && \
    mkdir -p /run/php-fpm && \
    sudo chmod 777 /usr/sbin/php-fpm

CMD ./usr/sbin/php-fpm && nginx -g 'daemon off;'

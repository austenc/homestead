#!/usr/bin/env bash

echo "-------- Reconfiguring Database --------"

# Reset the mysql root user password to blank
mysql -uroot -p"secret" -Bse "use mysql; UPDATE user SET password=PASSWORD('') WHERE User='root'; FLUSH PRIVILEGES;"

# install phpmyadmin
echo phpmyadmin       phpmyadmin/reconfigure-webserver  text              | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/dbconfig-install       boolean  true     | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/mysql/admin-pass       password          | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/mysql/app-pass         password          | sudo debconf-set-selections
sudo apt-get install -y phpmyadmin
sed -ire '/\$cfg\['\''Servers'\''\]\[\$i\]\['\''AllowNoPassword'\''\] = TRUE/ s/^.*\/\/ /    /' /etc/phpmyadmin/config.inc.php

# upgrade npm
npm update -g npm

# install bower
npm install -g bower

# phantomJS
sudo apt-get install -y phantomjs
class wpdb {
exec{"mysqladmin -u root password abcd1234 && touch /tmp/file1":
path => "/usr/bin/",
creates => "/tmp/file1"
}
exec{"wget https://raw.githubusercontent.com/roybhaskar9/chefwordpress-1/master/wordpress/files/default/mysqlcommands && touch /tmp/file2":
path => "/usr/bin/",
cwd => "/var/",
creates => "/tmp/file2",
require =>Exec['mysqladmin -u root password abcd1234 && touch /tmp/file1']
}
exec{"mysql -u root -pabcd1234 < /var/mysqlcommands && touch /tmp/file3":
path => "/usr/bin/",
creates => "/tmp/file3",
require =>Exec['wget https://raw.githubusercontent.com/roybhaskar9/chefwordpress-1/master/wordpress/files/default/mysqlcommands && touch /tmp/file2']
}

exec{"wget https://raw.githubusercontent.com/roybhaskar9/chefwordpress-1/master/wordpress/files/default/wp-config-sample.php -O wp-config.php && touch /tmp/file4":
cwd => "/var/www/html",
path => "/usr/bin/",
creates => "/tmp/file4",
require=>Exec['mysql -u root -pabcd1234 < /var/mysqlcommands && touch /tmp/file3']
}

}

#! /bin/bash

TIMESTAMP=`date +%F-%R`
BACKUP_DIR=/backup
OLDEST_BACKUP=`date +%F -d"28 days ago"`
DATE=`date +%F`
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump
databases=`$MYSQL  -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema)"`

mkdir -p "$BACKUP_DIR/$DATE"
rm -rf $BACKUP_DIR/$OLDEST_BACKUP

cd $BACKUP_DIR/$DATE

for db in $databases; do
  $MYSQLDUMP --force --databases $db > $db.sql 2> /dev/null
done

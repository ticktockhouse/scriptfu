#!/bin/bash

## Takes a commandline argument, or if no argument, asks for the string
if [ ! $1 ]
        then
                echo "All mysql DBs - Enter string to search for: "
                read STRING
        else
                STRING=$1
fi
##Plesk specific password finding
MYSQLPASS=`cat /etc/psa/.psa.shadow`
DATABASES=`mysql -uadmin -p"$MYSQLPASS" -e "SHOW DATABASES;" |grep -Ev "(Database|information_schema)"`

## Step through all DBs, grepping for the relevant string

for i in $DATABASES
        do echo "*** Database: $i ***:"     
        mysqldump -uadmin -p"$MYSQLPASS" $i --extended=FALSE |grep $STRING
done

#!/bin/bash

## Takes a commandline argument, or if no argument, asks for the string
# DISCLAIMER: Needs a working ~/.my.cnf. Test if you can log in to your mysql install using just "mysql" on the command line...

if [ ! $1 ]
        then
                echo "All mysql DBs - Enter string to search for: "
                read STRING
        else
                STRING=$1
fi

databases=$(mysql -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema)")
## Step through all DBs, grepping for the relevant string

for i in $databases
        do echo "*** Database: $i ***:"     
        mysqldump $i --extended=FALSE |grep $STRING
done

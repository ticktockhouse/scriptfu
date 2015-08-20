#!/bin/bash
echo -n "Enter database name: " ; read db_name
echo -n "Enter search string: " ; read search_string
echo -n "Enter replacement string: " ; read replacement_string
 
MYSQL="/usr/bin/mysql --skip-column-names" 
 
echo "SHOW TABLES;" | $MYSQL $db_name | while read db_table
do
	echo "SHOW COLUMNS FROM $db_table;" | $MYSQL $db_name| 
	awk -F '\t' '{print $1}' | while read tbl_column
	do
		echo "update $db_table set ${tbl_column} = replace(${tbl_column}, '${search_string}', '${replacement_string}');" |
		$MYSQL $db_name
	done
done

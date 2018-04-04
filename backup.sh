#!/bin/sh
 
# MySQL information: replace it with your own
hostname=localhost
username=MY_USER
password=MY_PASS
database=MY_DB
 
cur=`date +"%Y-%m-%d"`
dbfile=db.$cur.sql
wpfile=backup.$cur.tar.bz2
 
cd ~/public_html
 
echo "back up database"
mysqldump --add-drop-table -h$hostname -u$username -p$password $database > db.$cur.sql
 
echo "compress database"
bzip2 $dbfile
 
echo "back up wordpress"
tar -jcvf ../$wpfile --exclude='wp-content/cache/*' .
 
echo "done!"

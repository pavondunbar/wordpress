#!/bin/sh
 
# MySQL information: replace it with your own
hostname=MY_HOST
username=MY_USER
password=MY_PASS
database=MY_DB
 
# AWS S3 information: replace it with your own
bucket=MY_BUCKET
s3Key=MY_S3_KEY
s3Secret=MY_S3_SECRET
 
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
 
echo "transfer to s3"
resource="/${bucket}/${wpfile}"
contentType="application/x-compressed-tar"
dateValue=`date -R`
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT -T "../${wpfile}" \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  https://${bucket}.s3.amazonaws.com/${wpfile}
 
echo "done!"

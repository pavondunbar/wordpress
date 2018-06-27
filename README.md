# wordpress
Backup Wordpress Site and Database to Linux Server & Send Copy To Amazon S3 or DropBox

This shell script will backup your entire Wordpress website as well as your database and save it on your server. There si also a shell script to backup your Wordpress site and database and port a copy over to Amazon S3 or Dropbox.

It is advisable to set a cronjob to automatically run the script.

Credit goes to XMODULO for this script. I've tested it on my sites as well as my clients' sites, and it works flawlessly.

How To Use:

1) In Linux, Install Python PIP Package 
2) Next, install AWS CLI (pip install awscli --upgrade)
3) Next, install secondary package to address any potential bugs (pip install --upgrade s3transfer)
4) Run "aws configure" as root and enter in your AWS Access and Secret Keys
5) Open shell script and change data to suit your specific server and accounts with AWS.
6) Finally, set a cron job for the script

That's it.  Let me know if you need any help with configuring this shell script at pavondunbar@gmail.com

Thanks.

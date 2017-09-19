#!/bin/bash
#	TO BACKUP MYSQL DATABASES	#
#	日志按天记录，备份文件按秒记录	#
#	mysql_backup.conf is your config file for user,passwd	#
#	example conf 	#
#	USER	PASSWORD	DATABASE	#

##	SETTINGS	##

DATEDAY=`date "+%Y-%m-%d"`
DATENOW=`date "+%Y-%m-%d_%H%M%S"`
USERLIST="mysql_backup.conf"	#配置文件，和脚本放在同个路径
#BACK_UP_USER=
#BACK_UP_PASSWORD=
#DATABASE=
#TABLE=$4
PATH_FOR_BACKUP_FILE="放备份文件的目录，格式/a/b"
LOG_PATH="放日志的目录，格式 /a/b"
MYNAME=`basename $0`
BACKUP_FILE="$MYNAME"_"$DATENOW.sql"
LOG_FILE="$MYNAME"_"$DATEDAY.log"

##	END	##

cd `dirname $0`

while read line
do
BACK_UP_USER=`echo $line|awk '{print $1}'`
BACK_UP_PASSWORD=`echo $line|awk '{print $2}'`
BACK_UP_DATABASE=`echo $line|awk '{print $3}'`
if [ -z "$BACK_UP_DATABASE" ] ; then
BACK_UP_DATABASE="--all-databases"
fi

mysqldump -u$USER -p$BACK_UP_PASSWORD $BACK_UP_DATABASE  > $PATH_FOR_BACKUP_FILE/$BACK_UP_USER"_"$BACK_UP_DATABASE"_"$BACKUP_FILE
echo "$DATENOW , backup database for `hostname` ( user : $BACK_UP_USER , database : $BACK_UP_DATABASE )" >> $LOG_PATH/$LOG_FILE
done < mysql_backup.conf &>> $LOG_PATH/$LOG_FILE

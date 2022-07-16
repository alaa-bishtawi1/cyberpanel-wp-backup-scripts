#!/bin/bash
NOW=$(date +"%Y-%m-%d")
NOW_TIME=$(date +"%Y-%m-%d_%T_%p")
NOW_MONTH=$(date +"%Y-%m")

########
#Eexamples
#WEBSITE_PATH="/home/abd.alaabishtawi.com/public_html"
#WEBSITE_NAME="abd.alaabishtawi.com"
WEBSITE_PATH=$1
WEBSITE_NAME=$2
#########
MYSQL_DATABASE=$(sed -n "s/define( *'DB_NAME', *'\([^']*\)'.*/\1/p" $WEBSITE_PATH/wp-config.php)
MYSQL_USER=$(sed -n "s/define( *'DB_USER', *'\([^']*\)'.*/\1/p" $WEBSITE_PATH/wp-config.php)
MYSQL_PASSWORD=$(sed -n "s/define( *'DB_PASSWORD', *'\([^']*\)'.*/\1/p" $WEBSITE_PATH/wp-config.php)
MYSQL_HOST_PORT=$(sed -n "s/define( *'DB_HOST', *'\([^']*\)'.*/\1/p" $WEBSITE_PATH/wp-config.php)

arrIN=(${MYSQL_HOST_PORT//:/ })
MYSQL_HOST=${arrIN[0]}
MYSQL_PORT=${arrIN[1]}

MYSQL_BACKUP_DIR="/home/backup/$WEBSITE_NAME/mysql/$NOW_MONTH"
MYSQL_BACKUP_FULL_PATH="$MYSQL_BACKUP_DIR/$MYSQL_DATABASE-$NOW_TIME.sql.gz"




#################################################################

mkdir -p ${MYSQL_BACKUP_DIR}

backup_mysql(){
       mysqldump -h ${MYSQL_HOST} \
         -P ${MYSQL_PORT} \
         -u ${MYSQL_USER} \
         -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} | gzip > ${MYSQL_BACKUP_FULL_PATH}
}

backup_mysql

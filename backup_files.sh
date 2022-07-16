#!/bin/bash
##   https://www.mkyong.com/mysql/mysql-backup-and-restore-a-database-or-table/
##   https://www.mkyong.com/linux/how-to-zip-unzip-tar-in-unix-linux/
##
################################################################
NOW=$(date +"%Y-%m-%d")
NOW_TIME=$(date +"%Y-%m-%d_%T_%p")
NOW_MONTH=$(date +"%Y-%m")
### Examples
#WEBSITE_PATH="/home/abd.alaabishtawi.com/public_html"
#WEBSITE_NAME="abd.alaabishtawi.com"

WEBSITE_PATH=$1

WEBSITE_NAME=$2

FILES_BACKUP_DIR="/home/backup/$WEBSITE_NAME/public_html/$NOW_MONTH"
FILES_BACKUP_FULL_PATH="$FILES_BACKUP_DIR/$WEBSITE_NAME-$NOW_TIME.tar"



mkdir -p ${FILES_BACKUP_DIR}

backup_files(){
      tar -zcf ${FILES_BACKUP_FULL_PATH} --absolute-names ${WEBSITE_PATH}
}
backup_files

#!/bin/bash
WEBSITE_NAME=$1
mkdir -p "/home/backup/$WEBSITE_NAME/log"
touch "/home/backup/$WEBSITE_NAME/log/mysql_log"
touch "/home/backup/$WEBSITE_NAME/log/file_log"
touch "/home/backup/$WEBSITE_NAME/log/upload_log"
touch "/home/backup/$WEBSITE_NAME/log/clear_log"


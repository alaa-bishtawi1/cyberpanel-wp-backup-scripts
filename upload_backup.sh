#!/bin/bash

#WEBSITE_NAME="abd.alaabishtawi.com"
#S3_BUCKET="abd.alaa"

WEBSITE_NAME=$1
S3_BUCKET=$2


AMAZON_S3_BUCKET="s3://$S3_BUCKET/"
AMAZON_AWS_BIN="/usr/local/bin/aws"
BACKUP_PATH="/home/backup/$WEBSITE_NAME"

sync_s3(){

      ${AMAZON_AWS_BIN} s3 sync $BACKUP_PATH ${AMAZON_S3_BUCKET}

}
sync_s3


# check if any error
#if [ $? -eq 0 ]; then
# ok, no error, log and send email?
#else
# failed, got error, log and send email?
#fi;


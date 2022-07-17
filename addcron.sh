#!/bin/bash
#WEBSITE_NAME="abd.alaabishtawi.com"
#S3_BUCKET_NAME="abd.alaa"
#WEBSITE_PATH="/home/abd.alaabishtawi.com/public_html"
# SCRIPTS_PATH=/home/

usage="$(basename "$0")  -- script to run cronjob

where:
    --S3_BUCKET_NAME  s3 bucket name like 'abd.alaa'
    --WEBSITE_PATH  Absolute Website path like '/home/abd.alaabishtawi.com/public_html'
    --WEBSITE_NAME  Website name like 'abd.alaabishtawi.com'
    --SCRIPTS_PATH  Absolute Scripts path
    "
ARGUMENT_LIST=(
  "S3_BUCKET_NAME"
  "WEBSITE_PATH"
  "WEBSITE_NAME"
  "SCRIPTS_PATH"
)


# read arguments
opts=$(getopt \
  --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
  --name "$(basename "$0")" \
  --options "" \
  -- "$@"
)

eval set --$opts

while [[ $# -gt 0 ]]; do
  case "$1" in
    --S3_BUCKET_NAME)
      S3_BUCKET_NAME=$2
      shift 2
      ;;

    --WEBSITE_PATH)
      WEBSITE_PATH=$2
      shift 2
      ;;

    --WEBSITE_NAME)
      WEBSITE_NAME=$2
      shift 2
      ;;

    --SCRIPTS_PATH)
      SCRIPTS_PATH=$2
      shift 2
      break
      ;;
      

    *)
      echo "$usage"
      exit 1
      break
      ;;
  esac
done
is_epmty () {
  if [ -z "$1" ]
    then
          
          echo "$2 is empty"
          exit 1
  fi


}
is_epmty "$S3_BUCKET_NAME" "S3_BUCKET_NAME"
is_epmty "$WEBSITE_PATH" "WEBSITE_PATH"
is_epmty "$WEBSITE_NAME" "WEBSITE_NAME"
is_epmty "$SCRIPTS_PATH" "SCRIPTS_PATH"
/bin/bash ${SCRIPTS_PATH}/create_logs.sh ${WEBSITE_NAME}

(crontab -l; echo "25 * * * * $SCRIPTS_PATH/backup_sql.sh $WEBSITE_PATH $WEBSITE_NAME 2>>/home/backup/$WEBSITE_NAME/log/mysql_log") | sort -u | crontab -
(crontab -l; echo "30 * * * * $SCRIPTS_PATH/backup_files.sh $WEBSITE_PATH $WEBSITE_NAME 2>>/home/backup/$WEBSITE_NAME/log/file_log") | sort -u | crontab -
(crontab -l; echo "35 * * * * $SCRIPTS_PATH/upload_backup.sh $WEBSITE_NAME $S3_BUCKET_NAME 2>>/home/backup/$WEBSITE_NAME/log/upload_log") | sort -u | crontab -
(crontab -l; echo "40 * * * * rm -rf /home/backup/$WEBSITE_NAME 2>>/home/backup/$WEBSITE_NAME/log/clear_log && $SCRIPTS_PATH/create_logs.sh $WEBSITE_NAME") | sort -u | crontab -
echo "All cronjob has been set successfully"


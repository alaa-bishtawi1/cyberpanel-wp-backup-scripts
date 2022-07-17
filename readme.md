# Backup Cyberpanel Wordpress  Script


### prerequisite

install aws cli using on droplet the following link from [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

log in to aws console :
* Create s3 Bucket for website and block public access
* Create Iam user with Access key - Programmatic access without any permission
* Add inline policy for that user as the below json but **change the bucket name in all Resource**
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::abd.alaa"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::abd.alaa/*"
            ]
        }
    ]
}

```
* Configure aws on droplet by running the below command and entering aws access key for iam user and the default region

```bash
aws configure
```

## Downlad and use the script
* clone the repo
* cd to the cloned repo
* change permisson
```bash
chmod +x  *.sh
```
* Before Runing  the script change the follwoing
    * cronjob time inside addcron.sh
    * script parameter
        * --S3_BUCKET_NAME
        * --WEBSITE_PATH
        * --WEBSITE_NAME
        * --SCRIPTS_PATH

```bash
./addcron.sh --S3_BUCKET_NAME abd.alaa --WEBSITE_PATH /home/abd.alaabishtawi.com/public_html/ --WEBSITE_NAME abd.alaabishtawi.com --SCRIPTS_PATH /home/passing
```

#!/usr/bin/env bash

REMOTE_DIR="/"
LOCAL_DIR="/backup/ftp"

echo
echo "Starting download $REMOTE_DIR from $FTP_HOST to $LOCAL_DIR"
date

lftp -u "$FTP_USER","$FTP_PASSWORD" $FTP_HOST <<EOF
set ssl:verify-certificate no
mirror --delete --parallel=4 --use-pget-n=10 $REMOTE_DIR $LOCAL_DIR;
exit
EOF
echo
echo "Transfer finished"
date

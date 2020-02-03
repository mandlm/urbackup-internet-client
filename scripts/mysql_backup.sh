#!/usr/bin/env bash

BACKUP_DIR="/backup/database"

echo "Starting to backup database"

mkdir --parents $BACKUP_DIR
mysqldump --single-transaction --host=$MYSQL_BACKUP_HOST --user=$MYSQL_BACKUP_USER --password=$MYSQL_BACKUP_PASSWORD $MYSQL_BACKUP_DATABASE > $BACKUP_DIR/$MYSQL_BACKUP_DATABASE.sqldump

echo "Database backup finished"

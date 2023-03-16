#!/bin/bash

# MySQL credentials
DB_USER="username"
DB_PASSWORD="password"
DB_NAME="database_name"

# Backup directory
BACKUP_DIR="/path/to/backup/directory"

# Date format for backup file name
DATE_FORMAT=$(date +%Y-%m-%d-%H-%M-%S)

# Create backup file name
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE_FORMAT.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Dump database to backup file
mysqldump --user=$DB_USER --password=$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Compress backup file
gzip $BACKUP_FILE

# Keep only last 7 backup files and delete older ones
ls -t $BACKUP_DIR/$DB_NAME-*.sql.gz | tail -n +8 | xargs rm -f

# Print message
echo "Backup complete: $BACKUP_FILE.gz"

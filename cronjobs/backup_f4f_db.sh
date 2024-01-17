#!/bin/sh
#date (dd.mm.yyyy) 11.01.2024
#update 11.01.2024
#author Ivan Palmegiani
#purpose Dumps local F4F monitoring database to tar file in shared Drobbox folder

# Define variables 
db_backups_folder="$DROPBOX_CF/ARD/db_backups" # It is assumed a environment variable named DROPBOX_CF exists and points to the Dropbox home directory
backup_log_file="backup_log.txt"
f4f_db_host="localhost"
superuser="postgres"
data_directory="/opt/homebrew/var/postgresql@14"
f4f_db_name="f4f_restoration_db"
backup_file_prefix="f4f_restoration_db_backup_"

# Ensure existence of db_backups folder and log file
if [ ! -d "$db_backups_folder" ]; then
    mkdir -p "$db_backups_folder"
fi

logs_file="$db_backups_folder/$backup_log_file"

if [ ! -d "$logs_file" ]; then
    touch "$logs_file"
fi

# Generate tar backup of f4f_restoration_db using pg_dump, timestamped
backup_file="$db_backups_folder/$backup_file_prefix$(date "+%Y%m%d").tar.gz"
pg_dump -h "$f4f_db_host" -U "$superuser" -d "$f4f_db_name" | gzip > "$backup_file"
if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Database backup succeeded: $backup_file" >> "$db_backups_folder/$backup_log_file"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error during database backup." >> "$db_backups_folder/$backup_log_file"
    exit 1
fi

# Append details of latest dump to backup_log.txt
backup_time=$(date '+%Y-%m-%d %H:%M:%S')
database_volume=$(du -sh "$data_directory")
echo "[$backup_time] Backup completed. Database size: $database_volume" >> "$logs_file"

# Backup integrity verification
gzip -t "$backup_file" | tar -t > /dev/null
if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup verification succeeded: $backup_file" >> "$logs_file"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup verification failed for: $backup_file" >> "$logs_file"
fi

# Add line to cron report file
NOW=$(date +"%Y-%m-%d %H:%M:%S")
echo -e Backed-up F4F databases on ${NOW} >> $HOME/cron_reports.txt
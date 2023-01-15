#!/usr/bin/sh
backup_dir=$1

    echo "\n\n --> RaspiBackupper started on $(date +"%d-%m-%y") at $(date +"%H:%M")."
    echo " --> Backup Location: $backup_dir"
    echo "\n\n --> Backing up Plex..."

cd "$backup_dir"  
sudo service plexmediaserver stop
sudo 7z a PLEX/plex_backup-$(date +%Y-%m-%d-%H:%M).zip /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/ /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
sudo service plexmediaserver start 

    wait
        echo "\n\n --> Making an image of the system (start: $(date +"%d-%m-%y") at $(date +"%H:%M"))..."

sudo imgclone -d RPI/backupPI_"`date +"%d-%m-%Y"`" -gzip > /dev/null

    wait
        echo "\n\n --> Uploading everything to the cloud  (start: $(date +"%d-%m-%y") at $(date +"%H:%M"))...\n"

rclone sync $backup_dir GoogleDrive:/RaspiBackupper/ -P --stats 1000s

    wait
        echo "\n\n --> Deleting local backups older than 30 days (start: $(date +"%d-%m-%y") at $(date +"%H:%M"))..."

/usr/bin/find $backup_dir -type f -mtime +30 -delete

    wait
        echo "\n\n --> Deleting remote backups older than 60 days (start: $(date +"%d-%m-%y") at $(date +"%H:%M"))..."

rclone delete GoogleDrive:/RaspiBackupper --min-age 60d -v

        echo "\n\n --> RaspiBackupper finished on $(date +"%d-%m-%y") at $(date +"%H:%M").\n"
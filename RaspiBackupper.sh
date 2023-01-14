#!/usr/bin/sh
backup_dir=$1

    echo "\n\n --> RaspiBackupper partito il $(date +"%d-%m-%y") alle $(date +"%H:%M")."
    echo " --> Posizione Backup: $backup_dir"
    echo "\n\n --> Backuppando Plex..."

cd "$backup_dir"  
sudo service plexmediaserver stop
sudo 7z a PLEX/plex_backup-$(date +%Y-%m-%d-%H:%M).zip /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/ /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
sudo service plexmediaserver start 

    wait
        echo "\n\n --> Realizzando una immagine del sistema (inizio: $(date +"%d-%m-%y") alle $(date +"%H:%M"))..."

sudo imgclone -d RPI4/backupPI_"`date +"%d-%m-%Y"`" -gzip > /dev/null

    wait
        echo "\n\n --> Caricando tutto in cloud (inizio: $(date +"%d-%m-%y") alle $(date +"%H:%M"))...\n"

rclone sync $backup_dir GoogleDrive:/RaspiBackupper/ -P --stats 1000s

    wait
        echo "\n\n --> Cancellando i backup locali più vecchi di 30 giorni (inizio: $(date +"%d-%m-%y") alle $(date +"%H:%M"))..."

/usr/bin/find $backup_dir -type f -mtime +30 -delete

    wait
        echo "\n\n --> Cancellando i backup remoti più vecchi di 60 giorni (inizio: $(date +"%d-%m-%y") alle $(date +"%H:%M"))..."

rclone delete GoogleDrive:/RaspiBackupper --min-age 60d -v

        echo "\n\n --> RaspiBackupper ha finito il $(date +"%d-%m-%y") alle $(date +"%H:%M").\n"
        3
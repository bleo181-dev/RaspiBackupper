# RaspiBackupper

Questo script accetta in input una directory dove destinare il backup locale. Questa è necessario abbia le seguenti due sottocartelle:

* **RPI4**
  * Qui verrà salvata l'immagine di sistema (compressa)
    è necessario aver installato sul proprio Pi la [seguente repository](https://github.com/tom-2015/imgclone)
* **PLEX**
  * Qui invece verranno salvati i database e il file Preferences.xml di Plex (compressi). Nel mio caso mi interessano solo questi due elementi perché  preferisco riscaricare sul momento i metadati in caso di necessità. Evitando di sottoporli a backup risparmio tempo e spazio

A backup locale terminato lo script procederà a caricare su Google Drive, tramite Rclone, tutti i file ottenuti in una cartella remota chiamata *RaspiBackupper*. Assicurarsi dunque, per un corretto funzionamento, di avere un "*remote*" di Rclone (che punti a Google Drive) chiamato **GoogleDrive**

Per concludere, lo script cancella i backup locali più vecchi di 30 giorni. Cancella anche i backup remoti più vecchi di 60 giorni

# RaspiBackupper

This script accepts as input a directory (absolute path) where to save the local backup. This directory must contain the following two subdirectories. :

* **RPI**
  * The (compressed) system image will be saved here
    you must have installed on your Pi the [following repository](https://github.com/tom-2015/imgclone)
* **PLEX**
  * This is where the databases and the Plex Preferences.xml file (both compressed with 7z) will be saved. In my case I am only interested in these two things because I prefer to re-download the metadata on the spot if needed. By avoiding backing them up I save time and space

When the local backup is complete, the script will proceed to upload to Google Drive, via Rclone, all the files obtained in a remote folder called *RaspiBackupper*. So make sure, for proper operation, that you have an Rclone "*remote*" (pointing to Google Drive) called **GoogleDrive**

After this process the script deletes local backups older than 30 days. It also deletes remote backups older than 60 days

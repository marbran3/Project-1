#!/bin/bash

#Create /var/backup if it doesn't exist
mkdir -p /var/backup

#Create new /var/backup/hom.tar
tar cvf /var/backup/home.tar /home

#Move file /var/backup/home.tar to /var/backup/home.MMDDYYYY.tar
mv /var/backup/home.tar /var/backup/home.01102022.tar

#Create tar archive of /home. Save to /var/backup/system.tar
tar cvf /var/backup/system.tar /home

#List all files in /var/backup, including file sizes, save to /var/backup/file_report.txt
ls -lh /var/backup > /var/backup/file_report.txt

#Print free memory. Save to /var/backup/disk_report.txt
free -h > /var/backup/disk_report.txt


#!/bin/bash

#Check if script was run as root. Exit if false.
if [ $UID -eq 0 ]
then 
  echo "Please do not run this script as root."
  exit
fi

#Definte Variables
output=$HOME/research/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
suids=$(sudo find /home -type f -perm 777 2> /dev/null)
cpu=$(lscpu | grep CPU)
disk=$(df -H | head -2)

#Define commands to use later
commands=(
  'date'
  'uname -a'
  'hostname -s'
)

files=(
  '/etc/shadow' 
  '/etc/passwd'
  '/etc/hosts'
)

#Check for research directory. Creat it if needed.
if [ ! -d $HOME/research ]
then 
   mkdir $HOME/research  
fi

#Check for output file. Clear it if needed.
if [ -f $output ]
then
  rm $output
fi

#############################################
#Start Script

echo -e "A Quick System Audit Script\n" >> $output
echo "" >> $output

for x in {0..2};
do 
  results=$(${commands[$x]})
  echo "Results of "${commands[x]}" command:" >> $output
  echo $results >> $output
  echo "" >> $output
done

#Display machine type
echo "Machine Type Info:" >> $output
echo -e "$MACHTYPE \n" >> $output

#Display IP address info
echo -e "\nIP info:" >> $output
echo -e "$ip \n" >> $output

#Display memory usage
echo -e "\nMemory info:" >> $output
free >> $output

#Display CPU usage
echo -e "\nCPU info:" >> $output
echo -e "$cpu \n" >> $output

#Display disk usage
echo -e "\nDisk usage:" >> $output
echo -e "\n$disk" >> $output

#Display who is logged in
echo -e "\nWho is logged in: \n $(who -a) \n" >> $output

#Display DNS info
echo -e "DNS servers:\n" >> $output
cat /etc/resolv.conf >> $output

#List SUID files
echo -e "\nSUID Files:" >> $output
for suid in $suids;
do
  echo $suid >> $output
done

#List Top 10 processes
echo -e "\nTop 10 processes: \n" >> $output
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output

#Check the permission on files
echo -e "\nThe permissions for sensitive /etc files: \n" >> $output
for file in ${files[@]};
do
  ls -l $file >> $output
done



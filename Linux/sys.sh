#!/bin/bash

#Check if script was run as root. Exit if false.
if [ $UID -ne 0 ]
then 
  echo "Please run this script with sudo."
  exit
fi

#Definte Variables
output=$HOME/research/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
execs=$(find /home -type f -perm 777 2> /dev/null)


#Check for research directory. Creat it if needed.
if [ ! -d $HOME/research ]
then 
   mkdir ~/research 2> /dev/null 
fi

#Check for output file. Clear it if needed.
if [ -f $output ]
then
  rm $output
fi


echo -e "A Quick System Audit Script\n" >> $output
date >> $output
echo "" >> $output
echo "Machine Type Info:" >> $output
echo "$MACHTYPE" >> $output
echo -e "Uname info: $(uname -a)\n" >> $output
echo -e "IP info: 
echo -e "$ip \n" >> $output
echo -e "Host name: $(hostname -s)\n" >> $output
echo -e "DNS servers:\n" >> $output
cat /etc/resolv.conf >> $output
echo -e "\nMemory info:" >> $output
free >> $output
echo -e "\nCPU info:" >> $outputfile
lscpu | grep CPU >> $outputfile
echo -e "\nDisk usage:" >> $outputfile
df -H | head -2 >> $outputfile
echo -e "\nWho is logged in: \n $(who -a) \n" >> $outputfile
echo -e "\nExec files:\n" >> $outputfile
for exec in  $execs 
do 
  echo $exec
done

echo -e "\nTop 10 processes:\n" >> $outputfile
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $outputfile
fi





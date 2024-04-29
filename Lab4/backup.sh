
currentBackup=""
source="/home/user/source"
backupPath="/home/user/Backup-"$(date +%Y-%m-%d)""
wasUpdatedOnce=0

dirs=$(ls /home/user |  grep -E "Backup")


for i in $dirs
do

backupDate=${i#Backup-}

backupTimeInSeconds=$(date -d "$backupDate" +%s)

if [ "$backupTimeInSeconds" -gt "$(date -d '7 day ago' +%s)" ] ; then
    currentBackup=$i
fi
done

if [[ $currentBackup == "" ]]
then


  $(mkdir $backupPath)
  
  echo "Backup file was created. Name of backup file : Backup  " "date of creation " "$(date +%Y-%m-%d)"   >> /home/user/backup-report.txt

  files=$(ls $source)

  for j in $files
  do
        echo  $source/$j >> /home/user/backup-report.txt
        cp $source/$j $backupPath
    
  
  done

else

    files=$(ls $source)

    for j in $files
        do
            if [ ! -f $backupPath/$j ]
            then
            
            cp $source/$j $backupPath
            
            else
                sizeOfFileInBackup=$(wc -c $backupPath/$j | awk '{print $1}')
                sizeOfFileInSource=$(wc -c $source/$j | awk '{print $1}')

                if [ $sizeOfFileInBackup != $sizeOfFileInSource ]
                
                then
                    mv $backupPath/$j  $backupPath/"$(date +%Y-%m-%d)""-"$j
                    cp $source/$j $backupPath

                    if [ $wasUpdatedOnce == 0 ]
                    then
                       echo "File Backup was updated at "$(date +%Y-%m-%d)"" >> /home/user/backup-report.txt
                        wasUpdatedOnce=1
                    fi

                    echo "Versioned copy file name : " $backupPath/"$(date +%Y-%m-%d)""-"$j >> /home/user/backup-report.txt
                    echo "New file name : " $source/$j >> /home/user/backup-report.txt

                fi

            fi

        done

fi



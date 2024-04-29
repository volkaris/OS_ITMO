fileName=$1
trashLog="/home/user/.trash/trash.log"


if [ $# -ne 1  ]
then
    echo "Incorrect number of arguments"
    exit 1
fi


grep -E $fileName $trashLog | while read line || [[ -n $line ]]; do
    untrashFileName=$(echo $line | awk '{print $1}')
    hardLinkName=$(echo $line | awk '{print $2}')

    echo "Do you want to restore" $untrashFileName "? " "y/n " 

    read answer </dev/tty

    if [[  $answer == "y" ]]
    then
        
        if [ -d $(dirname "${untrashFileName}") ]

        then

            if [  -f $untrashFileName  ]

            then
                echo "file with this name created already , rename file"
                read newName </dev/tty
        
                newNewName=$(dirname "${untrashFileName}")
                newNewName+="/"
                newNewName+=$newName

                ln -P $hardLinkName $newNewName

            else

                ln -P $hardLinkName $untrashFileName
        
            fi
        else 
            echo "path doesn't exists, untrashing into user folder"

            newPath="/home/user/"
            newPath+=$(basename "${untrashFileName}")
            
             ln -P $hardLinkName $newPath

        fi
        

        rm -f  $hardLinkName
   
    fi
done
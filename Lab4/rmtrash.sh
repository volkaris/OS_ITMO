fileName=$1
trash="/home/user/.trash"
trashLog="/home/user/.trash/trash.log"

if [ $# -ne 1  ]
then
    echo "Incorrect number of arguments"
    exit 1
fi


if  [ ! -d $trash ] 
then
     mkdir $trash
      
fi 


uniqueHardLinkName=/home/user/.trash/$(uuidgen | cut -d "-" -f5)

ln -P $fileName $uniqueHardLinkName


fileFullPath=$(readlink -f $fileName)

 rm -f $fileName


 if  [ ! -d $trashLog ] 
then
     touch $trashLog  
fi 

echo $fileFullPath $uniqueHardLinkName >> $trashLog
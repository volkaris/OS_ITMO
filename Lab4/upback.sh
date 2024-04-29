Backup=$(ls /home/user |  grep -E "Backup-" | sort -rn | head -1)

for file in $(ls /home/user/$Backup) 
do
i=$(echo $file |  grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}")

if [[ $i == "" ]]
then
    cp /home/user/$Backup/$file /home/user/restore

fi
done
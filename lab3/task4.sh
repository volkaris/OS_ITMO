
./firstProccesFor4ThTask.sh&pid1=$!
./firstProccesFor4ThTask.sh&pid2=$!
./firstProccesFor4ThTask.sh&pid3=$!

max_cpu=10

renice -n 5 -p $pid1

kill -SIGTERM $pid3

while [ true ] 
do
	sleep 30
	cpu=$(ps -p $pid1 -o pcpu | tail -n 1)
	echo $cpu
	if (( $(echo "$max_cpu < $cpu" | bc -l) ))
	then
		new_nice=$(ps -p $pid1 -o ni | tail -n 1)
		if [[ $new_nice -le 19 ]]
		then		
			new_nice=$(($new_nice+1))
		fi
		echo $new_nice
		renice -n $new_nice -p $pid1
	fi 
done 


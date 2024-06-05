for i in $( ps aux | awk ' NR>1 {print ($2)}' )

do 

 ppid=$(sudo cat /proc/$i/status | grep 'PPid' | awk '{print($2)}')
 exec_runtime=$(sudo cat /proc/$i/sched | grep 'se.sum_exec_runtime' | awk -F ":" '{print($2)}')
 nr_switches=$(sudo cat /proc/$i/sched | grep 'nr_switches' | awk -F ":" '{print($2)}')
 result=$(echo "$exec_runtime / $nr_switches" | bc -l)

 echo "ProcessID = $i : Parent_ProcessID = $ppid : Avegage_Time =  $result" >> temp.txt
done
 sort -nk2 temp.txt >> task.txt
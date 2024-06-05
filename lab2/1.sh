
let pid=0
let peak=0

for i in $( ps aux | awk ' NR>1 {print ($2)}' ) 
do

       VmPeak=$(sudo cat /proc/$i/status | grep 'VmRSS'  | awk '{print ($2)}')
       
       if [[  "$VmPeak" -ne "" ]]  
       then
              if [ $VmPeak -gt $peak  ]

               then
                     peak=$VmPeak
                     pid=$i
              fi
   
       fi
done

echo  PID:  $pid Memory usage $peak



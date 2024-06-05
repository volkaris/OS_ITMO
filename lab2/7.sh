pid_list=$(ls -d /proc/[0-9]* 2>/dev/null)

for pid_dir in $pid_list; do
    
    pid=$(basename "$pid_dir")
    
    cmd=$(cat "$pid_dir/cmdline" | tr '\0' ' ')

    
    read_bytes=$(cat "$pid_dir/io" 2>/dev/null | grep 'read_bytes' | awk '{print $2}')

    
        echo "PID: $pid, Command: $cmd, Data Read: $read_bytes" >> tmp.txt
  
done

sort -t ":" -nrk 4 tmp.txt | head -n 3
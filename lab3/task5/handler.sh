
mode="+"
x=1

(tail -f canal.txt) |

while true; do

read line;
echo $line
case $line in 
      "+")
       mode="+"
       ;;
      "*")
      mode="*" 
      ;;

    "QUIT")
        echo "Terminating proccess because of command"
        killall tail
        exit 0;
        ;;
      [0-9]*) 
      case $mode in 
            "+")
            echo "Sum" $x "and " $line
            x=$(($x + $line))
            echo $x
            ;;
        "*")
            echo "Mult" $x "and " $line
            x=$(($x * $line))
            echo $x
        ;;
        esac
      ;;  
      *)
      echo "Invalid data.Terminating proccess"
      killall tail
      exit 1;
      ;;

esac 
done

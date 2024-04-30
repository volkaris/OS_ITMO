echo $$ > .pid

x=1

usr1()
{
   x=$(($x + 2))
    echo $x
}

usr2()
{
     x=$(($x * 2))
     echo $x

}

sigterm1()
{
    echo "exiting"
         exit 0
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm1' SIGTERM

while true; do
        tmp=$((1+1))
    sleep 1
done

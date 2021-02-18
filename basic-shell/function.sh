#!/bin/bash

Hello (){
	echo "Hello world!"
}

PrintArgs (){
	for arg in $*
	do
		echo $arg
	done
}

Return10 (){
	return 10
}

findcpu(){
	grep 'model name' /proc/cpuinfo  | uniq | awk -F':' '{ print $2}'
}
 
findkernelversion(){
	uname -mrs
}
 
totalmem(){
	grep -i 'memtotal' /proc/meminfo | awk -F':' '{ print $2}'
}

is_reachable()
{
	ping -c 1 -W 5 $1 > /dev/null
	if [ $? -eq 0 ]; then
		echo Node $1 is reachable.
	fi
}

#invoke function
Hello
PrintArgs $*
echo "Return value is:$(Return10)$?"
echo "CPU Type : $(findcpu)"
echo "Kernel version : $(findkernelversion)"
echo "Total memory : $(totalmem)"
#-----------------------
echo "----------- Ping -----------"
for i in 192.168.15.{1..254}
do
	is_reachable $i &
done

jobs=`jobs -p`
for pid in $jobs
do
	wait $pid
done

echo `date`
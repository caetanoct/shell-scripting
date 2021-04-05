#sudo nmap -sn 192.168.15.*
is_reachable()
{
	ping -c 1 -W 5 $1 > /dev/null
	if [ $? -eq 0 ]; then
		echo Node $1 is reachable.
	fi
}

for i in 192.168.15.{1..254}
do
	is_reachable $i &
done

jobs=`jobs -p`
for pid in $jobs
do
	wait $pid
done
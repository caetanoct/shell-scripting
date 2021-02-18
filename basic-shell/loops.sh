#!/bin/sh
for var in 0 1 2 3
do
	echo $var
done
# while
a=0
while [ $a -lt 4 ]
do
	echo $a
	a=`expr $a + 1`
done
# until
b=0
until [ $b -gt 3 ]
do
	echo $b
	b=`expr $b + 1`
done
# nested loop
a=0
while [ $a -lt 10 ]
do
	b=$a
	while [ $b -ge 0 ]
	do
		# echo without skiping line
		echo -n "$b "
		b=`expr $b - 1`
	done
	# skip line
	echo
	a=`expr $a + 1`
done

while true
do
	echo infinite loop
	if [ true ]
	then
		break #continue
	fi
done
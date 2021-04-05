#!/bin/bash
FILE=/usr/share/ieee-data/oui.txt
arp | awk '{ print substr($3,1,8) }' | while read PREFIX;
do
	if [[ $PREFIX != HWaddres ]]; then
		temp=`echo $PREFIX | tr : -`
		var=$(grep -i "$temp" $FILE)
		echo $var
	fi
done

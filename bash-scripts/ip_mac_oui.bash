#!/bin/bash
#FILE=/usr/share/ieee-data/oui.txt
FILE=/var/lib/ieee-data/oui.txt
arp -a | while read PREFIX;
do
	IP=$( echo $PREFIX | awk '{ print $2 }'| tr -d "()" )	
	MAC_PREFIX=$( echo $PREFIX | awk '{ print substr($4,1,8) }' )
	GREP_MAC=$( echo $MAC_PREFIX | tr : - )
	var=$( grep -i "$GREP_MAC" $FILE )
	if [[ -z $var ]]; then
		echo $IP " =  MAC not in database."
	else
		echo $IP " = " $var
	fi
done

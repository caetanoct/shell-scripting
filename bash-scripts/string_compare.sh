#!/bin/bash
if [ $# != 2 ]; then
	echo "type 2 strings as args"
else
	if [ $1 = $2 ]; then
		echo "two args are equal"
	else
		echo "two args are not equal"
	fi
fi

echo "enter 1st string"
read $st1
echo "enter 2nd string"
read $st2

if [ ]
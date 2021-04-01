#!/bin/bash

#The getopts function reads the flags in the input, and OPTARG refers to the corresponding values
while getopts i:p:t: flag
do
    case "${flag}" in
        i) ipaddr=${OPTARG};;
        p) packets=${OPTARG};;
        t) timeout=${OPTARG};;
    esac
done
echo "Ip address: $ipaddr";
echo "Packets amount: $packets";
echo "Timeout: $timeout";
ping -c $packets -W $timeout $ipaddr
#!/bin/bash

split_by () {
    string=$1
    separator=$2

    tmp=${string//"$separator"/$'\2'}
    IFS=$'\2' read -a arr <<< "$tmp"
    for substr in "${arr[@]}" ; do
        echo "<$substr>"
    done
    echo
}


split_by '1--123--23' '--'
split_by '1?*123' '?*'

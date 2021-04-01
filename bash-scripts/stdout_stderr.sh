#!/bin/bash
mkdir files 2> /dev/null
# redirect stderr/stdout to file
ls -al 1>./files/stdout.txt 2>./files/stderr.txt
# redirect to file and redirect stderr to stdout
ls +al > ./files/stdout_stderr.txt 2>&1
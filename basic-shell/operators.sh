#!/bin/sh
echo `expr $1 + $2`
echo `expr $1 - $2`
echo `expr $1 \* $2`
echo `expr $1 / $2`
echo `expr $1 % $2`
#$1 = $2
#[$1 == $2]
#[$1 != $2]
# relational -eq, -ne, -gt, -lt, -ge, -le ex: [$a -eq $b]
# boolean !,-o,-a
# string operators =,!=,-z (zero length), -n (non zero), str (check if str is not the empty string)
# file test operators:
# [-b $file] - check if file is a block special
# [-c $file] check if character special
# [-d $file] check if directory
# [-f $file] check if file
# [-g $file] check if has set group ID  bit set
# [-k $file] check if has sticky bit set
# [-p $file] check if file is a named pipe
# [-t $file] check if file descriptor is open and associated with a terminal
# [-u $file] check if file has set user id bit set
# [-r $file] check if file is readable
# [-w $file] check if file is writable
# [-x $file] check if file is executable
# [-s $file] check if file size is greater than 0
# [-e $file] check if file exists
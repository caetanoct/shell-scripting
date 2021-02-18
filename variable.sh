$0	#The filename of the current script.
$n	#These variables correspond to the arguments with which a script was invoked. Here n is a positive decimal number corresponding to the position of an argument (the first argument is $1, the second argument is $2, and so on).
$$	#The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.
$#	#The number of arguments supplied to a script.
$@	#All the arguments are individually double quoted. If a script receives two arguments, $@ is equivalent to $1 $2.
$*	#All the arguments are double quoted. If a script receives two arguments, $* is equivalent to $1 $2.
$?	#The exit status of the last command executed.
$!	#The process ID of the last background command.
$_	#The last argument of the previous command.

#  Shell Scripting Repository

Repository used for Shell/Bash Scripting Reference Material

# Shell

shell / bourne again shell (bash) are the **de facto** shell for vast majority of linux distributions

- once started, every shell will execute some startup scripts that will configure the current session

Let’s explore the concepts of interactive and login in the context of shell:

**Interactive/Non interactive shells**:  the user provides input using keyboard, the shell provide output by printing to the screen

**Login/Non login shells**: event of a user accessing a computer system providing its credentials

So interactive login shells are executed when users log into the system and are used to customize users configurations, example: group of users from the same department who need a particular variabble set in their sessions.

by interactive non-login shells we refer to any other shell opened by the user after logging into the system.

on the other hand, non interactive shells do not require human interaction (don’t ask for input and their output - if exists - is written to a log)

Non-interactive login shells are quite rare and impractical. Their uses are virtually non-existent
and we will only comment on them for the sake of insight into shell behaviour. Some odd
examples include forcing a script to be run from a login shell with /bin/bash --login
<some_script> or piping the standard output (stdout) of a command into the standard input
(stdin) of an ssh connection:
<some_command> | ssh <some_user>@<some_server>

As for non-interactive non-login shell there is neither interaction nor login on behalf of the user, so
we are referring here to the use of automated scripts. These scripts are mostly used to carry out tasks, like cronjobs. in those cases, bash does not need any startup file

**Opening terminals**

you can open terminals via terminal application or via system console. `pts` shell is for shells opened from terminal emulators and `tty` shells are for shells run from the system console.

using `ctrl`+`alt`+`F1-F6` will prompt for console logins which open a interactive login shell. `ctrl`+`alt`+`F7`will take the session back to desktop

tty stands for teletypewritter; pts stands for pseudo terminal slave. for more info use `man tty` or `man pts`

**Launching shells with bash**

`bash -l` will invoke a login shell

`bash -i` will invoke an interactive shell

`bash --noprofile` will ignore both system wide profile in `/etc/profile` and user-level startup file `~/.bash_profile`,`~/.bash_login` and `~/profile`

`bash --norc` will ignore both the system wide startup script in `/etc/bash.bashrc` and user-level startup file in `~/.bashrc`

`bash --rcfile <file>` take file as the startup script, ignoring system wide (/etc/bash.bashrc) and user level ~/.bashrc

**********Launching shells with `su` and `sudo`**

`su`will change the user ID or become superuser (root). we can invoke login and non-login shells:

- `su - user2` or `su -l user2` or `su --login user2` will start a interactive login shell as user2.
- `su user2` will start a interactive non-login shell
- `su - root` or `su -` will start a interactive login shell as root.
- `su root` or `su` will start a interactive non-login shell as root

`sudo` lets you execute commands as another user. usually used to gain root privileges temporarily, the user must be in the `sudoers` file. to do this you can use:

```bash
usermod -aG sudo user2
```

`sudo` will allow us to invoke both login and non-login shells:

- `sudo su - user2` , `sudo su -l user2` or `sudo su --login user2` will start an interactive login shell as user2
- `sudo su user2` will start a interactive non-login shell as user2
- `sudo -u user2 -s` will start an interactive non-login shell as user2
- `sudo su - root` or `sudo su -` will start an interactive login shell as root
- `sudo -i` will start an interactive login shell as root
- `sudo -i <command>` will start an interactive login shell as root, run the command and return to the original user
- `sudo su root` or `sudo su` will start an interactive non-login shell as root
- `sudo -s` or `sudo -u root -s` will start a non login shell as root

**Which shell type is my current shell?**

you can type `echo $0` and get the following output:

- Interactive Login
    - -bash or -su
- Interactive Non-login
    - bash or /bin/bash
- Non interactive non login (scripts)
    - <name_of_script>

**How many shells do we have?**

to see how many shells you have up and running you can run `ps aux | grep bash`

**Shell configuration files: startup files**

when there is more than one file to be searched, once one is found and run the others are
ignored

**Interactive Login Shells Configurations**

- Global Level
    - `/etc/profile` - for bourne shells and compatible (like bash). sets PATH and PS1. Also does sourcing `(. /etc/bash.bashrc)` in the same shell
    - `/etc/profile.d/*` - scripts that get executed by /etc/profile
- Local Level
    - `~/.bash_profile` - configure user environment, can be used to source ~/.bashlogin and ~/.profile
    - `~/.bash_login` - this file will only be executed if there is no ~/.bash_profile file.
    - `~/.profile`gets sourced if neither of the above exist (is not bash specific). it checks if bash shell is being run and source `~/.bashrc`. it also sets PATH variable so that is includes user private ~/bin
    - `~/.bash_logout` clean-up operations after exiting shell (convienient in remote sessions, for example).

**********************************************Interactive Non-Login Shells Configuration**********************************************

- Global Level
    - `/etc/bash.bashrc` - system wide `bashrc` for interactive bash shells. checks window size, sometimes change prompt, check if being run interactively
- Local Level
    - `~/.bashrc` - does the similar to global bashrc and also sets some history variables and sources `~/.bash_aliases` (if exists). also can store user specific aliases and functions.
        - it is also worthwhile noting that ~/.bashrc is read if bash detects its <stdin> is a
        network connection (as it was the case with the Secure Shell (SSH) connection in the example
        above).

**Non-Interactive Login Shell**

you can create a script and invoke it with `bash -l script.sh` to create a non-interactive login shell. (will run /etc/profile and ~/.profile)

**Non-Interactive Non-Login Shell**

Scripts do not read any of the files listed above but look for the environment variable BASH_ENV,
expand its value if needed and use it as the name of a startup file to read and execute commands.

---

**Sourcing Files**

The (.) dot is used to execute other scripts within the same script. 

we can use the . whenever we have modified a startup file and want to make the
changes effective without a reboot. for example:

1. Modify .bashrc adding an alias `echo "alias hello='echo hello world'" >> ~/.bashrc`
2. Source file by hand `. ~/.bashrc`
3. Invoke alias using `hello`

you can also use `source` command instead of `.`

**The origin of Shell Startup Files (SKEL)**

SKEL is a variable that contains the absolute path to the **skel directory (/etc/skel)**. It is a template for other home directories. related variables are stored in `/etc/adduser.conf` which is the configuration file for `adduser` 

# Shell Variables

In Bash variables can be either:
1. shell/local (these variables only exist in the scope of the running shell) - by convention they are in lowercase
or
2. environment/global (these variables are inherited by child shells) - by convention they are in UPPERCASE

Assigning variables in bash followes the following syntax: VARIABLE_NAME=VARIABLE_VALUE, for example: `os=ubuntu`. Variable name may contain letters, numbers and underscores. It may not contain spaces or start with a number.

To reference a variable value you can prefix the variable name with `$`, for example: `echo $os`

Variable values must be enclosed in quotes if they contain single spaces, or redirection symbols (<,>,|).

In variable assignment you can use single quotes or double quotes:
- **Single Quotes**: Take all characters of the variable value literally.
- **Double Quotes**: Allow variable substitution.

When referencing variables that include initial or extra spaces (sometimes with asterisks) you will need to use double quotes after the echo command to avoid *field splitting* and *pathname expansion*:

```bash
variable="       abc |      defg"
```

`echo $variable` would result in `abc | defg` and `echo "$variable"` would result in `       abc |      defg`.

* If the variable contains closing exclamation mark, this must be the last character in the string (otherwide bash will think we are referring to a history event).
* Any backslashes must be escaped with another backslash. If a backslash is the last character in the string (and is not escaped), bash will interpret that we want a line break and will give us a new line to input characters.
* use `readonly` before variable name to make the variable immutable. (you can print all `readonly` variables using `readonly -p`).
	```bash
	readonly VAR=variablevalue
	VAR_2=variablevalue2
	readonly VAR_2
	```
* `set` command will output all local/shell varibalbes (recommended tu use a page, example `set | less`).
* you can `unset` variables (local or global) using `unset varname`.
* to make a **local** variable **global** you can use: `export varname`.
* to make a **global** variable **local** you can use: `export -n varname`.
* `export` command will output all global/environment variables when typed without argumentes.
* `env` and `printenv` will print a list of all environment variables.

---

**Running a Shell in a Modified Environment**

`env -i bash` will start a new bash session as empty as possible.
`env BASH_ENV=/custom/path/to/environment /path/to/script` will run a script in a modified environment.

**Relevant Environment Variables**

These variables are usually set in Bash configuration files.

* DISPLAY
	* hostname:number is the format
	* if hostname is localhost it will be blank. the number 0 refers to the computer display.
	* empty value for the variable would mean a server without a X Window System. And, a extra number would mean to the screen number if more than one exists.

* HISTCONTROL
	* This will control what gets saved to **HISTFILE**. The tree possible values are:
		* ingnorespace - commands starting with a space won't be saved
		* ignoredups - command which is the same as the previous one won't be saved
		* ignoreboth - command which fall into any of the both categories above.

* HISTSIZE
	* This sets the number of commands to be stored in memory while the shell session lasts.

* HISTFILESIZE
	* Number of commands to be saved in **HISTFILE**. both at the start and at the end of the session.

* HISTFILE
	* the name of the file which stores all commands. by default it is **~/.bash_history**

* HOME
	* Absolute path of the current user's home directory, it is manually **set when the user logs in**.

* HOSTNAME
	* TCP/IP name of the host computer.

* HOSTTYPE
	* Architecture of host computer processor.

* LANG
	* Locale of the System.

* LD_LIBRARY_PATH
	* Colon separated set of directories where shared libraries are shared by programs.

* MAIL
	* File in which bash searches for email.

* MAILCHECK
	* Numberic value in seconds of the frequency which bash checks for new email.

* PATH
	* List of directories where bash looks for executables/binaries whenever a program is run. `:` separated list of directories, where the first directory is the first to be searched.

* PS1
	* Value of the bash prompt.

* PS2
	* Usually is `>`. It is used as a continuation prompt for multiline commands.

* PS3
	* prompt for `select` command.

* PS4
	* Usually is `+`. Used for debugging.

* SHELL
	* Absolute path of current shell.

* USER
	* Current user name.

Command substitutions:

1. var=`cmd`
2. var=$(cmd)

# Aliases

- An alias is a shortcut for another command(s). The syntax is `alias alias_name=commands`.
- The semicolon (;) is used as a delimiter for a series of command, for example: `alias git_information='which git;git --version'`
- If you just type `alias` you will produce a listing of all available aliases.
- If you type `unalias git_information` you will remove the alias.
- You can reference variables in aliases.
- Aliases takes precedence if another command has the same name, and you can escape the alias using '\', this would allow the original command to be called.
- Single quotes makes expansion dynamic and Double Quotes make expansion static.
- A good place to store aliases is on `~/.bashrc`.

# Functions

you can define funteions in two ways:

1) Using `function` keyword:

```bash
function name {
.
}
```

2) Using `()`:

```bash
function_name() {
.
}
```

Usually functions are stored in files (scripts). But they can be written directly into the shell prompt (using PS2 and multiline input).

You can also define the function in a single line, but you need to separate commands by semicolons (including on the last command).

# Special Variables

- `$?`
    - result of the last command, where 0 usually means the command was executed successfully

- `$$`
    - shell process id (PID)

- `$!`
    - PID of the last background job

- `$0` to `$9`
    - Posistional parameters where `$0` is the name of the script or shell.

- `$#`
    - Number of arguments passed to the command

- `$@` `$*`
    - Expand to the arguments passed to the command

- `$_`
    - Expand to the last parameter or the name of the script (amongst others)

## Function Within an Alias

You can put a function inside an alias, for example:

```bash
alias great_editor='gr8_ed() {echo $1 is a great editor; unset -f gr8_ed;}; gr8_ed'
```

- `unset -v` is used to unset variables and `unset -f` is used to unset functions.

# Scripts

- When a script is executed, the commands are read and executed line by line (you can also use semicolon to replace line breaks).
- Scripts are not executed by the main shell, but executed by a sub-shell to avoid messing with environment variables and unwanted changes.
- If you want to run the script in the current shell session, you need to source it with `. script.sh`.
    - The shell will be locked and only available when it ends the execution (code available at $?).  to end the current shell when the scrip end, you can preceed with the exec command.

## Variables

- If you use `"$@"` every argument will be enclosed by double quotes
- If positional parameters are greater than nine, it must be referenced with curly braces as in `${11}`, `${10}`
- To interact with the user you can use `read` command and `$REPLY` env var
- You can read simultaneaously using `read NAME SURNAME`
- You can print messages using `read -p "type your name" NAME`
- You can always retrieve the Length of a variable (quantity of characters) by prepending it with `#`
    - Example: `echo ${#OS}`

## Arrays

- Bash has arrays and can be declared using: `declare -a SIZES`
- You can also declare arrays and populate with `SIZES=( 102 103 )`
- Array elements **must** be referenced with curly braces, for example: `echo ${SIZES[0]}`
- To change values, you don't need the curly braces: `SIZES[0]=103`.
- To retrieve the total number of elements in array you can use the `#` combined with `@` or `*`, for example: `echo ${#SIZES[@]}`
- Arrays can be declared using the output of a command, for example: TEST=( $(cut -f 2 < /proc/filesystems) )
    - By default, any terms delimited by space, tab or newline will become an array element.

- Bash treats each char of an environment variable $IFS as a delimiter. 

## Arithmetic Expressions

The builtin command `expr` can be used to perform arithmetic expressions, for example:

```bash
SUM=`expr $value1 + $value2`
```

the command `expr` can be rewritten as `$(())`, for example:

```bash
SUM=$(( $value1 + $value2 ))
```

## Conditional Execution

- You can separate commands with `&&` to execute commands only if the command on the left did not envounter an error (exit code was equal to 0).
- The opposite behaviour occurs if commands are separated with `||`. In this case, the command will only be executed if the previous command encountered an error (exit code is not 0).
- the builtin `if` command in bash, only executes if the command given as argument returns a 0.
- the utility `test` can be used to assess many different criteria, for example:

```bash
if test -x /bin/bash ; then
    echo "/bin/bash is executable"
fi
```

> This means test -x will return 0 if the path is executable.

- square brackets `[]` can be used as a substitute to `test`, for example:

```bash
if [ -x /bin/bash ] ; then
    echo "is executable!"
fi
```

try running:
```bash
test -d /etc
echo $?
```

## Script Output

- `echo -e` enables interpretation of backslash characters and can be used to output `\t`  or `\n` characters, for example.
- `printf` utility gives a lot of control over how to display the variables.
    - the command will take the first argument as the format of the output and placeholders will be replaced by the following arguments, for example:
        
        ```bash
        printf "OS:\t%s\nRAM:\t%d" $0S $(( $FREE / 1024** 2 ))
        ```

## Using `test` and `[]`

you can use the following arguments to `test`:

**Files/Directories**

- -a path
    - check if the path exists and it is a file
- -b path
    - evaluates if path is a special block file
- -c path
    - evaluete if the path is a special character file
- -d path
    - evaluates if path is a directory
- -f path
    - evalueate if path is a file
- -g path
    - evaluates if the path has SGID Permission
- -h path
    - evaluates if the path is a symbolic link
- -L path
    - evaluates if the path is a symbolic link
- -k path
    - evaluates if the path has the sticky bit permission
- -p path
    - evaluates if the path is a pipe file
- -r path
    - evaluates if the path is readable
- -s path
    - evaluates if the path exists and is not empty
- -S path
    - evaluates if the path is a socket
- -t path
    - evaluates if the path is open in terminal
- -u path
    - evaluates if the path has the SUID permission
- -w path
    - evaluates if path is writable by the current user
- -x path
    - evaluates if path is executable by the current user
- -O path
    - evaluates if path is owned by current user
- -G path
    - evaluates if path belongs to the effective group of the current user
- -N path
    - evaluates if the path has been modified since the last time it was accessed
- "$path1" -nt "$path2"
    - evaluates if path1 is newer than path2 according to modified date
- "$path1" -ot "$path2"
    - evaluates if path1 is older than path2
- "$path1" -ef "$path2"
    - evaluates to true if path is path1 is a hardlink to path2

> it is recommended to enclose variables in double quotes to avoid syntax errors when using `test` command

---

**Variables**

- -z "$VAR"
    - evaluates if the $VAR is empty (zero size)
- -n "$var"
    - evaluates if variable is not empty
- "$var1" = "$var2" **or** "$var1" == "$var2"
    - evaluates if var1 and var2 are equal
- "$var1" != "$var2"
    - evaluates if var1 and var2 are not equal
- "$var1" < "$var2"
    - evaluates if var2 comes before var2 in alphabetical order
- "$var1" > "$var2"
    - evaluates if var1 comes after var2 in alphabetical order

---

**Numeric Tests**

- $NUM1 -lt $NUM2
    - less than
- $NUM1 -gt $NUM2
    - greater than
- $NUM1 -le $NUM2
    - less or equal
- $NUM1 -ge $NUM2
    - greater of equal
- $NUM1 -eq $NUM2
    - equal
- $NUM1 -ne $NUM2
    - not equal

---

**Modifiers**

- ! expr
    - evaluate if expr is false
- EXPR1 -a EXPR2
    - evaluate if both expr1 and expr2 are true
- EXPR1 -o EXPR2
    - evaluate if at least one of the two expressions are true

## `case`

Case is a variation of the *if* construct. it will execute commands if the content of a variable can be found in a list of items separated by pipes and terminated by ).

example:

```bash
case "$DISTRO" in
    debian | ubuntu)
    echo -n ".deb"
    ;;
    centos | fedora)
    echo -n ".rpm"
    ;;
    *)
    echo -n "default"
    ;;
esac
```

you can use `shopt -s nocasematch` before the case construct to enable case-insensitive pattern matching. This command will change a bash buil-in option, you can use `shopt -u` to unset a given option. And it will only take effect for the current shell session, not affecting the parent session.

if searched item is specified in quotes, they will be removed before matching.

## Loops

### For

walks through a list of items 

```bash
for VAR in LIST
do
    commands
done
```

- LIST is any sequence of separated terms. The delimiting character splitting items in the list is defined by the **IFS** environment variable.
- **IFS** Default value is SPACE, TAB and NEWLINE.
- Sorting shour be done using `LANG=C`
An alternative format using `(())` is:

```bash
for (( ID = 0; I < ${#SEQ[@]}; ID++ ))
do
    commands
done
```

### Until

```bash
until [ $ID -e ${#SEQ[@]}]
do
    commands
done
```

### While

```bash
while [ $ID -lt ${#SEQ[@]} ]
do
    commands
done
```

- `mapfile -t LIST < $FILE` will storee in list each line and remove trailing newline characters.
- You can reference unicode characters using `\u2192` for right arrow character, for example.


# References:

1. [Linux LPIC-101 Learning Material](https://learning.lpi.org/en/learning-materials/learning-materials/)
2. [Link for bash hints](https://devhints.io/bash)
3. [CLI arguments + bash](https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script)
4. [Bash documentation](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

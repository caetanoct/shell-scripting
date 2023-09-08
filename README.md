#  Shell Scripting Repository

Repository used for Shell/Bash Scripting Reference Material

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

When working with arrays in Bash, understanding the difference between `$*` and `$@` is crucial, especially when dealing with arguments that might contain spaces or special characters.

1. **$***: This treats the command-line arguments as a single string. The value of `$*` is a single string that consists of all the arguments separated by the first character in the `IFS` (Internal Field Separator) variable, which is a space by default.

   If you do `PARAMS=( $* )`, you are initiating an array, `PARAMS`, with each word (separated by spaces) as an element. This can lead to unexpected behavior if your command-line arguments include spaces.

   Example:
   ```
   script.sh arg1 "arg2 with spaces" arg3
   ```
   Using `PARAMS=( $* )` will create an array like:
   ```
   PARAMS[0]="arg1"
   PARAMS[1]="arg2"
   PARAMS[2]="with"
   PARAMS[3]="spaces"
   PARAMS[4]="arg3"
   ```

2. **$@***: This treats the command-line arguments as separate strings. The value of `$@` is all the arguments as separate strings. When you quote it as `"$@"`, each argument is treated as a separate element.

   Using `PARAMS=( "$@" )` will preserve the integrity of arguments with spaces.
   
   Example:
   ```
   script.sh arg1 "arg2 with spaces" arg3
   ```
   Using `PARAMS=( "$@" )` will create an array like:
   ```
   PARAMS[0]="arg1"
   PARAMS[1]="arg2 with spaces"
   PARAMS[2]="arg3"
   ```

In general, if you're dealing with command-line arguments or any situation where spaces or special characters might be involved, it's safer to use `"$@"` to ensure data integrity.

## Function Within an Alias

You can put a function inside an alias, for example:

```bash
alias great_editor='gr8_ed() {echo $1 is a great editor; unset -f gr8_ed;}; gr8_ed'
```

- `unset -v` is used to unset variables and `unset -f` is used to unset functions.

# References:

1. [Linux LPIC-101 Learning Material](https://learning.lpi.org/en/learning-materials/learning-materials/)
2. [Link for bash hints](https://devhints.io/bash)
3. [CLI arguments + bash](https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script)
4. [Bash documentation](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

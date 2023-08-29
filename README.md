#  Shell Scripting Repository

###  Repository used for Shell/Bash scripting study

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

# References:

1. [Linux LPIC-101 Learning Material](https://learning.lpi.org/en/learning-materials/learning-materials/)
2. [Link for bash hints](https://devhints.io/bash)
3. [CLI arguments + bash](https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script)
4. [Bash documentation](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

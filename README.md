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

# References:

1. [Linux LPIC-101 Learning Material](https://learning.lpi.org/en/learning-materials/learning-materials/)
2. [Link for bash hints](https://devhints.io/bash)
3. [CLI arguments + bash](https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script)
4. [Bash documentation](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

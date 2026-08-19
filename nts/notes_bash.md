<!-- <h1 style="color:red" align="center" >BASH PROGRAMMING:</h1> -->

<details open><summary style="font-size:25px;color:Orange;text-align:center">BASH PROGRAMMING</summary>

### Usefule Links

-   [[notes_shell]]
-   [Bash Cheatsheet](https://devhints.io/bash)
-   [The Complete How To Guide Of Bash Functions](https://www.shell-tips.com/bash/functions/)
-   [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
-   [Interview Bit](https://www.interviewbit.com/shell-scripting-interview-questions/)
-   [Interview Questions](https://www.guru99.com/shell-scripting-interview-questions.html)

<details><summary style="font-size:18px;color:red;">Terms & Concepts</summary>

-   `Kernel`: Every operating system (OS) has a kernel. The kernel is the layer of the OS that bridges the hardware with the main programs that run on a computer. The kernel is the core of the OS and is the first to load when the computer boots up. It remains in the computer's memory throughout a session. It is responsible for providing an interface for all applications, controlling the hardware and allowing processes to get information from each other. There are three types of kernel:

    -   Microkernel
    -   Hybrid
    -   Monolithic
    -   Linux uses a monolithic kernel, so called because it includes device drivers and the file management system and therefore requires more memory. On the opposite end of the spectrum, a microkernel aims to occupy the smallest amount of memory by managing only the necessities such as the CPU, memory and inter-process communication (IPC).

-   `The Shell`: The shell forms the layer between the user and the kernel so the user can enter commands. The kernel 'understands' only binary language, which is composed exclusively of ones and zeros. In early computing, any instructions/commands from the users were entered in binary language, but this evolved so that the user can enter commands in a more recognizable language. It is the shell that acts as the go-between, accepting the commands entered in the language recognizable by the user, and translating them to binary language for the kernel.

-   `Bash`: Bash stands for Bourne Again SHell, and is **a type of shell** found in Linux, which is the default shell in several versions ('distributions') of Linux. Other common types of shell are cshell and kshell, though there are others. The most primitive type of shell in Linux is sh.

-   `Terminal`: The terminal is the application that brings it all together, in the sense that it provides a visual representation of the shell for the user to enter commands. In other words, in a GUI (graphical user interface), where applications and other features are visually represented by images that the user can manipulate by clicking on them with a cursor, a terminal application opens a window where the user can type in commands for the shell to interpret into binary language for the kernel.

-   `Bash Session`: In Bash, a session refers to a user's interaction with the command-line environment. It represents the period of time during which a user is logged in and actively running commands within a shell. When a user logs into a Bash shell, a new session is created. The session retains information about the user's environment variables, current working directory, and any active processes or jobs associated with that session. Here are some key characteristics of a Bash session:

    -   `User Interaction`: During a session, the user can interact with the command-line interface by entering commands, executing scripts, and interacting with various shell features and utilities.

    -   `Environment Variables`: Each session has its own set of environment variables that define the user's environment. These variables can control various aspects of the shell's behavior, such as the PATH variable, which determines the locations where executable programs are searched.

    -   `Process Management`: The session keeps track of the processes spawned by the user. This includes both foreground processes that are executed interactively and background processes that continue running after the user exits the shell.

    -   `Job Control`: Bash provides job control features that allow users to manage multiple processes running within a session. This includes the ability to run processes in the background, bring them to the foreground, pause or resume their execution, and manage their output and input streams.

    -   `Session Termination`: A session ends when the user logs out or the shell process is terminated. Upon session termination, any running processes associated with that session are also terminated.

</details>

### Elements of Bash:

-   [Pipeline](https://tiswww.case.edu/php/chet/bash/bashref.html#Pipelines):

    -   A pipeline is a sequence of one or more commands separated by one of the control operators `|` or `|&`
    -   The output of each command in the pipeline is connected via a pipe to the input of the next command. That is, each command reads the previous command’s output. This connection is performed before any redirections.
    -   If `|&` is used, command1’s standard error, in addition to its standard output, is connected to command2’s standard input through the pipe; it is shorthand for 2>&1 |. This implicit redirection of the standard error to the standard output is performed after any redirections specified by command1.

-   [Array in Bash](https://tiswww.case.edu/php/chet/bash/bashref.html#Arrays):

-   [Grouping Commands](https://ss64.com/bash/syntax-brackets.html): Bash provides two ways to group a list of commands to be executed as a unit. When commands are grouped, redirections may be applied to the entire command list. For example, the output of all the commands in the list may be redirected to a single stream.

    -   `()` (`(list)`)
        -   Placing a list of commands between parentheses forces the shell to create a subshell (see Command Execution Environment), and each of the commands in list is executed in that subshell environment. Since the list is executed in a subshell, variable assignments do not remain in effect after the subshell completes.
    -   `{}` (`{list;}`)
        -   Placing a list of commands between curly braces causes the list to be executed in the current shell context. No subshell is created. The semicolon (or newline) following list is required.

-   [Shell Expansion](https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Expansions): Expansion is performed on the command line after it has been split into tokens. There are seven kinds of expansion performed:

    -   `Brace Expansion` → Expansion of expressions within braces.
    -   `Tilde Expansion` → Expansion of the ~ character.
    -   [Shell Parameter Expansion](https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Parameter-Expansion) → How Bash expands variables to their values.
    -   `Command Substitution` → Using the output of a command as an argument.

        -   `$(command)`: Executes the command within the parentheses and substitutes the output of the command into the command line.
        -   `` `command` `` (backticked): Similar to $(command), it executes the command within the backticks and substitutes the output.

    -   `Arithmetic Expansion` → How to use arithmetic in shell expansions.
    -   `Process Substitution` → A way to write and read to and from a command.
    -   `Word Splitting` → How the results of expansion are split into separate arguments.
    -   `Filename Expansion` → A shorthand for specifying filenames matching patterns.

-   [getopts, OPTIND, OPTARG, shift]()

    -   These concepts—OPTIND, OPTARG, and shift—are commonly used in combination with getopts to handle command-line options and arguments in Bash scripts effectively.

### Flags/Options in Bash:

-   [Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html)
-   [Taking command line arguments using flags in bash](https://dev.to/shriaas2898/taking-command-line-arguments-using-flags-in-bash-121)
-   [Different ways to implement flags in bash](https://jonalmeida.com/posts/2013/05/26/different-ways-to-implement-flags-in-bash/)
-

| **Term**     | **Preceded By**                         | **Takes a Value**                              | **Purpose**                                   |
| ------------ | --------------------------------------- | ---------------------------------------------- | --------------------------------------------- |
| **Flag**     | Single dash (`-`)                       | Rarely                                         | Toggles a feature on or off.                  |
| **Option**   | Single dash (`-`) or double dash (`--`) | Sometimes (e.g., `-o value`, `--option=value`) | Modifies command behavior.                    |
| **Argument** | No dash                                 | Yes (e.g., filename, string)                   | Specifies the input or target of the command. |

### Special Variables in Bash:

-   [Shell Parameters](https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Parameters)

-   `$0` → The filename of the current script.
-   `$n` → The Nth argument passed to script was invoked or function was called.
-   `$#` → The number of argument passed to script or function.
-   `$@` → All arguments passed to script or function.
-   `$*` → All arguments passed to script or function.
-   `$?` → The exit status of the last command executed.
-   `$$` → The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.
-   `$!` → The process number of the last background command.
-   `$IFS` → In Bash, IFS (Internal Field Separator) is an environment variable that determines how Bash recognizes word boundaries when it performs word splitting on strings. By default, the IFS variable is set to whitespace characters (space, tab, and newline).

<details><summary style="font-size:18px;color:Orange;text-align:left">Regular Expressions</summary>

A regular expression (regex or regexp) in Bash is a powerful pattern-matching language used for searching, matching, and manipulating text strings. Regular expressions are widely used in programming, scripting, and text processing tasks to perform operations like searching for specific patterns, replacing text, and extracting information from strings. Bash supports regular expressions through various commands and tools, such as grep, sed, and awk.

Here's a detailed breakdown of regular expressions in Bash:

-   `Basic Characters`:

    -   `Literal Characters`: Regular expressions can include literal characters (`alphabets`, `digits`, `symbols`) that match the exact character in the text.
    -   `Metacharacters`: Special characters that have a special meaning in regex, such as `.`, `*`, `+`, `?`, `[`, `]`, `(`, `)`, `{`, `}`, `^`, `$`, `\`.

-   `Anchors`:

    -   `^ (caret)`: Matches the start of a line or string.
    -   `$ (dollar)`: Matches the end of a line or string.

-   `Character Classes`:

    -   `[abc]`: Matches any one of the characters 'a', 'b', or 'c'.
    -   `[a-z]`: Matches any lowercase alphabet character.
    -   `[0-9]`: Matches any digit character.

-   `Quantifiers`:

    -   `*`: Matches zero or more occurrences of the previous element.
    -   `+`: Matches one or more occurrences of the previous element.
    -   `?`: Matches zero or one occurrence of the previous element.
    -   `{n}`: Matches exactly 'n' occurrences of the previous element.
    -   `{n,}`: Matches 'n' or more occurrences of the previous element.
    -   `{n,m}`: Matches between 'n' and 'm' occurrences of the previous element.

-   `Grouping and Alternation`:

    -   `(abc)`: Groups the enclosed characters.
    -   `a|b`: Matches either 'a' or 'b'.

-   `Escaping Special Characters`:

    -   `\.`: Matches a literal period character.
    -   `\\`: Matches a literal backslash character.
    -   `\(, \), \{, \}`: Matches literal parentheses and curly braces.

-   `Special Character Classes`:

    -   `\d`: Matches any digit character (equivalent to [0-9]).
    -   `\w`: Matches any word character (alphabets, digits, underscore).
    -   `\s`: Matches whitespace characters (spaces, tabs, newlines).

-   `Negation`:

    -   `[^abc]`: Matches any character that is not 'a', 'b', or 'c'.

-   `Quantifiers with Lazy Matching`:

    -   `\*?, +?, ??`: Perform quantifiers in a non-greedy or lazy manner.

-   `Backreferences`:

    -   `\(abc\)\1`: Matches 'abcabc'.

-   Common Commands:

    -   `grep`: Searches for a pattern in text.
    -   `sed`: Stream editor for text transformations based on regex.
    -   `awk`: Pattern scanning and text processing language.
    -   `egrep` (or grep -E): Enables extended regular expression syntax.

</details>

### Meta-Characters:

In Bash scripting, meta-characters are special characters that have specific meanings or functions within the shell. These characters are used to control the interpretation or behavior of commands and can be used for tasks such as redirection, expansion, quoting, and more. Here are some commonly used meta-characters in Bash:

-   Redirecting Output:

    -   `0>` → stdin stream director (I never seen this used in any script)
    -   `1>` → stdout stream director (standard output)
    -   `2>` → stderr stream director (standard error output)
    -   `>` → Redirects the standard output of a command to a file or overwrites the contents of the file.
    -   `>>` → stream director append to a file
    -   `<<` → stdin stream director. (`cat > file << EOF` ; anything ; EOF)
    -   `>&` → stream director to stream director, ie. `echo "a" 1>/dev/null 2>&1` this directs `2>` to the same place as `1>`

    -   `>>` → Redirects the standard output of a command and appends it to a file.
    -   `2>` → Redirects the standard error of a command to a file.
    -   `2>&1` → Redirects the standard error to the same location as the standard output.
    -   `&>` or `&>>` → Redirects both the standard output and standard error to a file.

-   Pipes:

    -   `|`: Connects the standard output of one command to the standard input of another command, allowing the output of one command to serve as input to another.
    -   `|&` (Pipe with Ampersand): The pipe with ampersand operator (`|&`) is used to redirect both the standard output (stdout) and the standard error (stderr) of a command as the input to another command. It combines both streams and sends them to the next command.

-   Globbing (Wildcards): Globbing, also known as filename expansion, is a feature provided by shells (such as Bash) and some other command-line interfaces that allows you to match and expand patterns into a list of matching filenames or paths.

    -   [Filename expention and Pattern maching](https://tiswww.case.edu/php/chet/bash/bashref.html#Filename-Expansion)

    -   `*`: Matches any number of characters (zero or more).
    -   `?`: Matches any single character.
    -   `[ ]`: Matches any single character within the specified range or set.
    -   `!(pattern)`: Matches anything except the specified pattern.
    -   `+(pattern)`: Matches one or more occurrences of the pattern.
    -   `@(pattern)`: Matches one of the patterns.
    -   `?(pattern)`: Matches zero or one occurrence of the pattern.
    -   ```txt
        files/
        ├── apple.txt
        ├── banana.txt
        ├── cherry.txt
        ├── orange.jpg
        └── peach.txt
        ```

    -   `*.txt` - Matches any file with the extension ".txt":
        -   Result: apple.txt, banana.txt, cherry.txt, peach.txt
    -   `?r*.txt` - Matches any file with ".txt" extension that starts with the letter 'r' as the second character:
        -   Result: cherry.txt
    -   `fru?*.txt` - Matches any file with ".txt" extension that starts with the letters 'fru' followed by any character:
        -   Result: fruit.txt
    -   `[abc]*.txt` - Matches any file with ".txt" extension that starts with the letters 'a', 'b', or 'c':
        -   Result: apple.txt, banana.txt, cherry.txt
    -   `[a-c]*.[jp]?g` - Matches any file with ".jpg" or ".jpeg" extension that starts with the letters 'a', 'b', or 'c':
        -   Result: orange.jpg
    -   `[a-z]*.[!j]?*` - Matches any file with any extension except ".jpg" or ".jpeg" that starts with any lowercase letter:
        -   Result: apple.txt, banana.txt, cherry.txt, peach.txt

-   Quoting:

    -   `'single quotes'`: Preserves the literal value of all characters within the single quotes. No variable expansion or command substitution occurs within single quotes. (Interpret literally without evaluating any metacharacter.)
    -   `"double quotes"`: Allows variable expansion and command substitution within the double quotes. Certain characters like $, \, and ``` have special meanings within double quotes. (Interpret literally with evaluating metacharacters.)

### Shell command separator/control characters:

| Bash Widgets      | Meaning                                                                            |
| ----------------- | ---------------------------------------------------------------------------------- |
| `$(command)`      | Replace command with its output. Example: `my_var = $(ls -1)`; `ls -l $(which cp)` |
| `$((mth-exprsn))` | Example: ` my_var = $(( 2 + 8))` `echo $(($((5**2)) * 3))`                         |
| `!$`              | last commands last argument                                                        |
| `!!`              | repeat last command                                                                |
| `;`               | will separate 2 commands as if they were written on separate command lines         |
| `;;`              | end of a case function in a case statement. (see `case` further down)              |
| `$!`              | PID of the last child process.                                                     |
| `$$`              | PID of current process (PID == Process ID)                                         |
| `$0`              | Shows program that owns the current process.                                       |
| `$-`              | current option flags (I never ever had to use this one)                            |
| `$_`              | Last argument/Command                                                              |
| `%`               | job character, %1 = fg job 1, %2 = fg job 2, etc.                                  |
| `@`               | `$@` is equivalent to `"$1"` `"$2"` etc. (all arguments)                           |
| `\`               | Escape special character interpretor                                               |
| `{#varname}`      | returns the length of the value of the variable as a character string              |
| `(UNIX command)`  | command substitution: runs the command and returns standard output                 |

### VARIABLES

-   `varname=value` → defines a variable
-   `varname=value command` → defines a variable to be in the environment of a particular subprocess
-   `echo $varname` → checks a variable's value
-   `echo $$` → prints process ID of the current shell
-   `echo $!` → prints process ID of the most recently invoked background job
-   `echo $?` → displays the exit status of the last command
-   `read <varname>` → reads a string from the input and assigns it to a variable
-   `let <varname> = <equation>` → performs mathematical calculation using operators like +, -, \*, /, %
-   `export VARNAME=value` → defines an environment variable (will be available in subprocesses)

-   `array[0]=valA` → how to define an array
-   `array[1]=valB`
-   `array[2]=valC`
-   `array=([2]=valC [0]=valA [1]=valB)` → another way
-   `array=(valA valB valC)` → and another

-   `${array[i]}` → displays array's value for this index. If no index is supplied, array element 0 is assumed
-   `${#array[i]}` → to find out the length of any element in the array
-   `${#array[@]}` → to find out how many values there are in the array

-   `declare -a` → the variables are treated as arrays
-   `declare -f` → uses function names only
-   `declare -F` → displays function names without definitions
-   `declare -i` → the variables are treated as integers
-   `declare -r` → makes the variables read-only
-   `declare -x` → marks the variables for export via the environment

-   [Shell Parameter Expansion](https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Parameter-Expansion)

    -   `${varname:-word}` → if varname exists and isn't null, return its value; otherwise return word
    -   `${varname:=word}` → if varname exists and isn't null, return its value; otherwise set it word and then return its value
    -   `${varname:?message}` → if varname exists and isn't null, return its value; otherwise print varname, followed by message and abort the current command or script
    -   `${varname:+word}` → if varname exists and isn't null, return word; otherwise return null
    -   `${varname:offset:length}` → performs substring expansion. It returns the substring of $varname starting at offset and up to length characters
    -   `${variable#pattern}` → if the pattern matches the beginning of the variable's value, delete the shortest part that matches and return the rest
    -   `${variable##pattern}` → if the pattern matches the beginning of the variable's value, delete the longest part that matches and return the rest
    -   `${variable%pattern}` → if the pattern matches the end of the variable's value, delete the shortest part that matches and return the rest
    -   `${variable%%pattern}` → if the pattern matches the end of the variable's value, delete the longest part that matches and return the rest
    -   `${variable/pattern/string}` → the longest match to pattern in variable is replaced by string. Only the first match is replaced
    -   `${variable//pattern/string}` → the longest match to pattern in variable is replaced by string. All matches are replaced
    -   `${#varname}` → returns the length of the value of the variable as a character string

-   [Filename Expansion & Pattern Matching](https://tiswww.case.edu/php/chet/bash/bashref.html#Filename-Expansion)

    -   `\*(patternlist)` → matches zero or more occurrences of the given patterns
    -   `+(patternlist)` → matches one or more occurrences of the given patterns
    -   `?(patternlist)` → matches zero or one occurrence of the given patterns
    -   `@(patternlist)` → matches exactly one of the given patterns
    -   `!(patternlist)` → matches anything except one of the given patterns

-   `$(UNIX command)` → command substitution: runs the command and returns standard output

---

### STRINGS EXPRESSION:

-   `str1 = str2` → Check if a string is equal to another string
-   `str1 == *"str2"*` → Check if `str1` contains `str2`.
-   `str1 =~ [0-9]+` → Check if `str1` matches a regular expression.
-   `str1 != str2` → str1 does not match str2
-   `str1 < str2` → str1 is less than str2 (alphabetically)
-   `str1 > str2` → str1 is greater than str2 (alphabetically)
-   `str1 \> str2` → str1 is sorted after str2
-   `str1 \< str2` → str1 is sorted before str2
-   `-n str1` → str1 is not null (has length greater than 0)
-   `-z str1` → str1 is null (has length 0)

### STRINGS OPERATIONS:

```sh
#!/bin/bash

# Original string
original_string="ThisIsABashString"

# Extract a substring starting from index 6 to the end
substring="${original_string:6}"

# Print the original and sliced strings
echo "Original String: $original_string"
echo "Sliced String: $substring"

# ============================================

# Print the original and sliced strings
echo "Original String: $original_string"
echo "Sliced String: $substring"

# ============================================

# Transform the string to uppercase
uppercase_string="${original_string^^}"
echo "Transformed String: $substring"
```

### FILES EXPRESSION:

-   `-a File` → file exists or its compilation is successful
-   `-d File` → file exists and is a directory
-   `-e File` → file exists; same -a
-   `-f File` → file exists and is a regular file (i.e., not a directory or other special type of file)
-   `-h File` → True if the File exist and a symbolic link
-   `-r File` → you have read permission
-   `-s File` → file exists and is not empty
-   `-w File` → your have write permission
-   `-x File` → you have execute permission on file, or directory search permission if it is a directory
-   `-N File` → file was modified since it was last read
-   `-O File` → you own file
-   `-G File` → file's group ID matches yours (or one of yours, if you are in multiple groups)
-   `file1 -nt file2File` → file1 is newer than file2
-   `file1 -ot file2File` → file1 is older than file2

-   `-n var` → True is the length of the var is greater than zero
-   `-z var` → True if the var is empty

### NUMBERS EXPRESSION:

-   `-lt` → less than
-   `-le` → less than or equal
-   `-eq` → equal
-   `-ge` → greater than or equal
-   `-gt` → greater than
-   `-ne` → not equal

### FUNCTIONS

```bash
## The function refers to passed arguments by position (as if they were positional parameters), that is, $1, $2, and so forth.
## $@ is equal to "$1" "$2"... "$N", where N is the number of positional parameters. $# holds the number of positional parameters.


# function func_name {
#     echo "Hello World"
# }

# func_name(){
#     echo "Hello World"
# }

# unset -f func_name  # deletes a function definition
# declare -f          # displays all defined functions in your login session
```

### Control Flow in Bash:

-   `statement1 && statement2` → `and` operator
-   `statement1 || statement2` → `or` operator

-   `-a` → `and` operator inside a test conditional expression
-   `-o` → `or` operator inside a test conditional expression

-   **Remarks:**

    -   condition is written in square brackets.
    -   when use mathematical operator in conditions or elsewhere use double parenthesis.

```bash
if [ expr1 ]; then
    statments ...
elif [ expr2 ]; then
    statments ...
elif [ expr3 ]; then
    statments ...
else
    statments ...
fi


if [ ! -f "$2" ]
then
  echo "File \"$2\" does not exist."
  exit $E_NOFILE
fi
```

```bash
#!/bin/bash

# Function to rsync the document folder to a flash drive based on the target value
function sync_to_flash_drive() {
    local target="$1"
    local source_folder="/path/to/document/folder"  # Replace this with the actual path to your document folder

    case "$target" in
        "target1")
            rsync -av "$source_folder" /path/to/flash/drive1/  # Replace /path/to/flash/drive1/ with the actual mount point of the first flash drive
            ;;
        "target2")
            rsync -av "$source_folder" /path/to/flash/drive2/  # Replace /path/to/flash/drive2/ with the actual mount point of the second flash drive
            ;;
        "target3")
            rsync -av "$source_folder" /path/to/flash/drive3/  # Replace /path/to/flash/drive3/ with the actual mount point of the third flash drive
            ;;
        *)
            echo "Invalid target. Please choose one of: target1, target2, target3."
            ;;
    esac
}

# Usage example:
# Call the function with the desired target value as an argument (e.g., "target1")
# sync_to_flash_drive "target1"

```

### Looping in Bash:

-   **Remarks:**

#### for:

##### Operating on a file list contained in a variable

```bash

#!/bin/bash
# fileinfo.sh

FILES="/usr/sbin/accept
/usr/sbin/pwck
/usr/sbin/chroot
/usr/bin/fakefile
/sbin/badblocks
/sbin/ypbind"     # List of files you are curious about.
                  # Threw in a dummy file, /usr/bin/fakefile.

echo

for file in $FILES
do

  if [ ! -e "$file" ]       # Check if file exists.
  then
    echo "$file does not exist."; echo
    continue                # On to next.
   fi

  ls -l $file | awk '{ print $8 "         file size: " $5 }'  # Print 2 fields.
  whatis `basename $file`   # File info.
  # Note that the whatis database needs to have been set up for this to work.
  # To do this, as root run /usr/bin/makewhatis.
  echo
done

exit 0


```

##### Find a particular string in the binaries in a specified directory.

```bash
#!/bin/bash
# findstring.sh:

directory=/usr/bin/
fstring="Free Software Foundation"  # See which files come from the FSF.

for file in $( find $directory -type f -name '*' | sort )
do
  strings -f $file | grep "$fstring" | sed -e "s%$directory%%"
  #  In the "sed" expression,
  #+ it is necessary to substitute for the normal "/" delimiter
  #+ because "/" happens to be one of the characters filtered out.
  #  Failure to do so gives an error message. (Try it.)
done

exit $?

#  Exercise (easy):
#  ---------------
#  Convert this script to take command-line parameters
#+ for $directory and $fstring.
```

##### Symbolic links in a directory, saved to a file

```bash

#!/bin/bash
# symlinks.sh: Lists symbolic links in a directory.

OUTFILE=symlinks.list                         # save-file

directory=${1-`pwd`}
#  Defaults to current working directory,
#+ if not otherwise specified.


echo "symbolic links in directory \"$directory\"" > "$OUTFILE"
echo "---------------------------" >> "$OUTFILE"

for file in "$( find $directory -type l )"    # -type l = symbolic links
do
  echo "$file"
done | sort >> "$OUTFILE"                     # stdout of loop
#           ^^^^^^^^^^^^^                       redirected to save file.

# echo "Output file = $OUTFILE"

exit $?
```

##### Nested Loop

```bash

#!/bin/bash
# nested-loop.sh: Nested "for" loops.

outer=1             # Set outer loop counter.

# Beginning of outer loop.
for a in 1 2 3 4 5
do
  echo "Pass $outer in outer loop."
  echo "---------------------"
  inner=1           # Reset inner loop counter.

  # ===============================================
  # Beginning of inner loop.
  for b in 1 2 3 4 5
  do
    echo "Pass $inner in inner loop."
    let "inner+=1"  # Increment inner loop counter.
  done
  # End of inner loop.
  # ===============================================

  let "outer+=1"    # Increment outer loop counter.
  echo              # Space between output blocks in pass of outer loop.
done
# End of outer loop.

exit 0
```

```bash
# Process each file in directory_1, comparing it to directory_2
missing=0
for filename in "$1"/*; do
    fn=$(basename "$filename")
    if [ -f "$filename" ]; then
        if [ ! -f "$2/$fn" ]; then
            echo "$fn is missing from $2"
            missing=$((missing + 1))
        fi
    fi
done
echo "$missing files missing"
```

##### Various ways of geting list of files's path

```bash
for entry in `ls $search_dir`; do
    echo $entry
done

for entry in "$search_dir"/* "$work_dir"/*
do
  if [ -f "$entry" ];then
    echo "$entry"
  fi
done
```

#### while:

##### While loop with multiple conditions

```bash
var1=unset
previous=$var1

while echo "previous-variable = $previous"
      echo
      previous=$var1
      [ "$var1" != end ] # Keeps track of what $var1 was previously.
      # Four conditions on *while*, but only the final one controls loop.
      # The *last* exit status is the one that counts.
do
echo "Input variable #1 (end to exit) "
  read var1
  echo "variable #1 = $var1"
done

# Try to figure out how this all works.
# It's a wee bit tricky.

exit 0
```

##### Inside its test brackets, a while loop can call a function.

```bash
t=0

condition ()
{
  ((t++))

  if [ $t -lt 5 ]
  then
    return 0  # true
  else
    return 1  # false
  fi
}

while condition
#     ^^^^^^^^^
#     Function call -- four loop iterations.
do
  echo "Still going: t = $t"
done

# Still going: t = 1
# Still going: t = 2
# Still going: t = 3
# Still going: t = 4
```

```bash
number=0
while [ "$number" -lt 10 ]; do
    echo "Number = $number"
    number=$((number + 1))
done
```

### COLORS AND BACKGROUNDS

    # Reset
    Color_Off='\033[0m' # Text Reset

    # Regular Colors
    Black='\033[0;30m'  # Black
    Red='\033[0;31m'    # Red
    Green='\033[0;32m'  # Green
    Yellow='\033[0;33m' # Yellow
    Blue='\033[0;34m'   # Blue
    Purple='\033[0;35m' # Purple
    Cyan='\033[0;36m'   # Cyan
    White='\033[0;97m'  # White

    # Additional colors
    LGrey='\033[0;37m'  # Ligth Gray
    DGrey='\033[0;90m'  # Dark Gray
    LRed='\033[0;91m'   # Ligth Red
    LGreen='\033[0;92m' # Ligth Green
    LYellow='\033[0;93m'# Ligth Yellow
    LBlue='\033[0;94m'  # Ligth Blue
    LPurple='\033[0;95m'# Light Purple
    LCyan='\033[0;96m'  # Ligth Cyan


    # Bold
    BBlack='\033[1;30m' # Black
    BRed='\033[1;31m'   # Red
    BGreen='\033[1;32m' # Green
    BYellow='\033[1;33m'# Yellow
    BBlue='\033[1;34m'  # Blue
    BPurple='\033[1;35m'# Purple
    BCyan='\033[1;36m'  # Cyan
    BWhite='\033[1;37m' # White

    # Underline
    UBlack='\033[4;30m' # Black
    URed='\033[4;31m'   # Red
    UGreen='\033[4;32m' # Green
    UYellow='\033[4;33m'# Yellow
    UBlue='\033[4;34m'  # Blue
    UPurple='\033[4;35m'# Purple
    UCyan='\033[4;36m'  # Cyan
    UWhite='\033[4;37m' # White

    # Background
    On_Black='\033[40m' # Black
    On_Red='\033[41m'   # Red
    On_Green='\033[42m' # Green
    On_Yellow='\033[43m'# Yellow
    On_Blue='\033[44m'  # Blue
    On_Purple='\033[45m'# Purple
    On_Cyan='\033[46m'  # Cyan
    On_White='\033[47m' # White

    # Example of usage
    echo -e "${Green}This is GREEN text${Color_Off} and normal text"
    echo -e "${Red}${On_White}This is Red test on White background${Color_Off}"
    # option -e is mandatory, it enable interpretation of backslash escapes

</details>

## Command Line Interface

### The command line prompt:

```bash
$ echo hello world!
hello world!
$ echo a    b
a b
$ date
Fri 21 Feb 2020 01:04:36 PM EET
$ date  # This is a comment
Fri 21 Feb 2020 01:04:38 PM EET
$
```

### Editing

```bash
$ touch a-file
$ touch a-file-with-a-longer-name
$ ls
a-file  a-file-with-a-longer-name
$
Enter long file names
$ touch really-long-file-name
$ ls
really-long-file-name
$ touch really-long-file-name
$
Interrupt execution
$ sleep 60 # Wait for 60 seconds
^C
$
```

### Command options:

```bash
$ touch a
$ touch b
$ ls
a  b
$ ls -l # Specify option to list files in long format
total 0
-rw-r--r-- 1 dds None 0 Dec  7 10:33 a
-rw-r--r-- 1 dds None 0 Dec  7 10:33 b
$ ls -r # Specify option to list files in reverse order
b  a
$ ls --reverse # Same option in long format
b  a
$ ls -l -r # Specify two short options
total 0
-rw-r--r-- 1 dds None 0 Dec  6 10:33 b
-rw-r--r-- 1 dds None 0 Dec  6 10:33 a
$ ls -lr # Combine two short options
total 0
-rw-r--r-- 1 dds None 0 Dec  6 10:33 b
-rw-r--r-- 1 dds None 0 Dec  6 10:33 a
$ touch -t 200408132045 olympic-opening # Specify short option with argument
$ touch --date=2004-08-13T20:45 olympic-opening # Long option with argument
$ ls -l
-rw-r--r-- 1 dds None 0 Aug 13  2004 olympic-opening
$
```

### Get help:

```bash
$ man ls
LS(1)                            User Commands                           LS(1)

NAME
       ls - list directory contents

SYNOPSIS
       ls [OPTION]... [FILE]...

DESCRIPTION
       List  information  about  the FILEs (the current directory by default).
       Sort entries alphabetically if none of -cftuvSUX nor --sort  is  speci?
       fied.

       Mandatory  arguments  to  long  options are mandatory for short options
       too.

       -a, --all
              do not ignore entries starting with .

       -A, --almost-all
              do not list implied . and ..

       --author
 Manual page ls(1) line 1 (press h for help or q to quit)
$
```

### Built-in help:

```bash
$ sleep --help
Usage: sleep NUMBER[SUFFIX]...
  or:  sleep OPTION
Pause for NUMBER seconds.  SUFFIX may be 's' for seconds (the default),
'm' for minutes, 'h' for hours or 'd' for days.  Unlike most implementations
that require NUMBER be an integer, here NUMBER may be an arbitrary floating
point number.  Given two or more arguments, pause for the amount of time
specified by the sum of their values.

      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/sleep>
or available locally via: info '(coreutils) sleep invocation'
$
```

### Usefull Commands:

- [Utility Conventions](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html) (Unix standard specification)
- date (Unix command specification)
- echo (Unix command specification)
- ls (Unix command specification)
- touch (Unix command specification)
- man (Unix command specification)
- sleep (Unix command specification)

### Output redirection:

```bash
$ echo If you can keep your head when all about you >if-1 # Output redirection
$ cat if-1
If you can keep your head when all about you
$ echo Are losing theirs and blaming it on you, >>if-1 # Append to file
$ cat if-1
If you can keep your head when all about you
Are losing theirs and blaming it on you,
$ echo If you can trust yourself when all men doubt you, >if-2
$ echo But make allowance for their doubting too. >>if-2
$ cat if-2
If you can trust yourself when all men doubt you,
But make allowance for their doubting too.
$ cat if-1 if-2 # Combine two files
If you can keep your head when all about you
Are losing theirs and blaming it on you,
If you can trust yourself when all men doubt you,
But make allowance for their doubting too.
$ cat if-1 if-2 >if # Output redirection
$ cat if
If you can keep your head when all about you
Are losing theirs and blaming it on you,
If you can trust yourself when all men doubt you,
But make allowance for their doubting too.
$
```

### The standard error channel:

```bash
$ touch afile
$ ls xyzzy >output # Display an error message
ls: cannot access xyzzy: No such file or directory
$ cat output # output is created but empty
$ ls xyzzy 2>output # Redirect error
$ cat output
ls: cannot access xyzzy: No such file or directory
$ ls -l afile xyzzy >output 2>error # Redirect output and error
$ cat output
-rw-r--r-- 1 dds dds 0 Dec  7 10:51 afile
$ cat error
ls: cannot access xyzzy: No such file or directory
$
```

### Paging:

```bash
$ less /usr/share/dict/words
A
a
aa
aal
aalii
aam
Aani
aardvark
aardwolf
Aaron
Aaronic
Aaronical
Aaronite
Aaronitic
Aaru
Ab
aba
Ababdeh
Ababua
abac
abaca
abacate
abacay
/usr/share/dict/words 0%
$
```

### Input redirection:

```bash
$ bc
40 + 2
42
scale = 60
sqrt(2)
1.414213562373095048801688724209698078569671875376948073176679

$ echo 2 ^ 64 - 1 >chess-rice
$ bc <chess-rice
18446744073709551615
$ cat -n <if
     1  If you can keep your head when all about you
     2  Are losing theirs and blaming it on you,
     3  If you can trust yourself when all men doubt you,
     4  But make allowance for their doubting too.
$
```

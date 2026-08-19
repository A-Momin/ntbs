#!/bin/bash

beautify_prompt(){
    # colors:
    green="\[\033[0;32m\]"
    blue="\[\033[0;34m\]"
    purple="\[\033[0;35m\]"
    reset="\[\033[0m\]"
    BRed='\033[1;31m'       # Bold Red
    Yellow='\033[0;33m' # Yellow
    Orange='\033[38;5;214m'
    BOrange='\e[1;33m'


    host=$(whoami)
    # host=
    if [ $host = "am" ]; then
        host_color=$BRed
    elif [ $host = "a.momin" ]; then
        host_color=$Orange
    else
        host_color=$BOrange
    fi
    arrow_color=$purple

    # Prompt String
    export PS1="$host_color${host}-$arrow_color =>|$green\$(__git_ps1)$blue\W$arrow_color|\n$ $reset"
    # export PS1="$purple\u =>> |$green\$(__git_ps1)$blue\W$purple|\n$ $reset"

    # Meaning of
        #	\h     ->> the host name
        #	\n     ->> the new line
        #	\s     ->> the name of the shell
        #	\t     ->> the current time in 24-hour format
        #	\u     ->> the user name of current user
        #	\w     ->> the current working directory
        #	\W     ->> the basename of the current working directory
}

create_alias(){
    alias python=python3
    alias pip=pip3
    # alias vim=nvim
    # alias tmux="tmux 2"
}

function settitle () 
{ 
        echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ----------------------------------
# BASIC STUFF
# ----------------------------------

#for i3
export TERMINAL="gnome-terminal"

PATH=/opt/texbin:$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/home/M/Scripts/Customization/
export PATH

export VISUAL=nano
export EDITOR="$VISUAL"

# don't exit terimal on ctrl+D EOF
set -o ignoreeof

# set tab-autocompete to ignore case
set completion-ignore-case On

# make cd ignore case and small typos
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s autocd

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# set length of command history rememebered
# make sure this isn't overrided by the OS (Ubuntu does this)
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=100000
HISTFILESIZE=200000

# -------------------------------
# MISC SETUP
# -------------------------------


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# uncomment for a colored prompt, if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# -------------------------------
# ALIASES
# -------------------------------

# Aliases could also be put in a separate file:
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# ls thing
# --------------
#show full paths
alias path="ls -d $PWD/*"
# show hidden files too
alias la='ls -A'
#show file size, permissions, date, etc.
function ll() 
{
    git -C $1 branch &> /dev/null
    est="$?"
    if [[ $est -ne "128" ]]; then
        echo "git branch structure:"
        git -C $1 branch
    fi
    echo "ls -alvhs:"
    ls -alvhs $1
}

#alias ll="ls -alhvs"
#sort files by size, showing biggest at the bottom
alias sizesort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"
# tree of directories
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
# typo correction
alias l='ls'
alias sl="ls"
alias l="ls"
alias s="ls"

# don't clobber files or ruin the OS
alias cp='cp -i'
alias mv='mv -i'
alias rm="rm -I --preserve-root"
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias mntwin='sudo mount -t ntfs /dev/nvme0n1p3 /mnt/'

# make directory and any parent directories needed
alias mkdir='mkdir -p'

# easier directory jumping
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# typo fix
alias cd..='cd ..'

alias cat="pygmentize -g"

#use to get current directory with spaces escaped
alias qwd='printf "%q\n" "$(pwd)"'

# stop typing so much when package managing
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias update='sudo dnf update'
alias upgrade='sudo dnf update && sudo apt-get upgrade'

# make common commands easier to read for humans
alias diff="colordiff"
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mth"

# easy time and date printing
alias now="date +"%T""
alias dt='date "+%F %T"'

# easy shutdown/reboot
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"

# search command history for a string
alias histg="history | grep"

# custom cmatrix
alias cmatrix="cmatrix -bC yellow"

# search processes (find PID easily)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# show all processes
alias psf="ps auxf"

#given a PID, intercept the stdout and stderr
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p" 

# make wget continue downloads if inturrupted
alias wget="wget -c"

# show current IP address
alias ip="curl http://ipecho.net/plain; echo"

# pop up a small window with the webcam in it, press s to screenshot
alias webcam="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot"

# super convenient HTTP server
# with python 3, it will be "python3 -m http.server"
alias http="python -m SimpleHTTPServer"

alias hw="ssh -X masnes01@homework.cs.tufts.edu"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# Alerts you when the program has finished/errored
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Show active http connections
alias ports='echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;'

# directory bookmarks
# loads bookmarks from file in home directory
alias load='sh .bookmarks'
# aliases to set and go to bookmarks
alias setc='alias c="cd `qwd`"'
alias setc1='alias c1="cd `qwd`"'
alias setc2='alias c2="cd `qwd`"'
alias setc3='alias c3="cd `qwd`"'
alias setc4='alias c4="cd `qwd`"'
alias setc5='alias c5="cd `qwd`"'
alias setc6='alias c6="cd `qwd`"'
alias setc7='alias c7="cd `qwd`"'
alias setc8='alias c8="cd `qwd`"'
alias setc9='alias c9="cd `qwd`"'
# save bookmarks for later sessions
alias savec='alias|grep -e "alias c\([0-9]\|=\)"|grep -v "alias setc" > ~/.bookmarks'
# list all bookmarks
alias lma='alias|grep -e "alias c\([0-9]\|=\)"|grep -v "alias setc"|sed "s/alias //"'
touch ~/.bookmarks
source ~/.bookmarks
# PROMPT APPEARANCE (PS1)
# ---------------------------

# COLORS
# colors work as a pair of brackets
# in each bracket we use \033 or \e, an escape character
# We then follow with more brackets, and an integer
# 38 for the color as a foreground, 48 for background
# a number 30-37 will use a 16-color code as a base, same with 40-47
# 5 sets the sequence to change color based on 256-color codes, not full-color
# and the number followed by m chooses a color from the chart below:
# https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
# also see https://stackoverflow.com/questions/15682537/ansi-color-specific-rgb-sequence-bash

# Default 16 colors
 DRED='\[\033[38;5;01m\]'
DGREEN='\[\033[38;5;02m\]'
DYELLOW='\[\033[38;5;03m\]'
DBLUE='\[\033[38;5;04m\]'
DPURP='\[\033[38;5;05m\]'
DCYAN='\[\033[38;5;06m\]'
DWHITE='\[\033[38;5;07m\]'
GREY='\[\033[38;5;08m\]'
RED='\[\033[38;5;09m\]'
GREEN='\[\033[38;5;10m\]'
YELLOW='\[\033[38;5;11m\]'
BLUE='\[\033[38;5;12m\]'
PURP='\[\033[38;5;13m\]'
CYAN='\[\033[38;5;14m\]'
WHITE='\[\033[38;5;15m\]'
BLACK='\[\033[38;5;16m\]'
# white
DEFAULT='\[\033[00m\]'

# bold and normal text
B='\[\e[1m\]'
N='\[\e[21m\]'

# purple to peach colors (background colors)
PP0='\[\033[48;5;18m\]'
PP1='\[\033[48;5;54m\]'
PP2='\[\033[48;5;90m\]'
PP3='\[\033[48;5;126m\]'
PP4='\[\033[48;5;162m\]'
PP5='\[\033[48;5;198m\]'
# and in gradient form
PP="${PP0} ${PP1} ${PP2} ${PP3} ${PP4} ${PP5} ${DEFAULT}"

#peach to yellow
PY1='\[\033[48;5;198m\]'
PY2='\[\033[48;5;204m\]'
PY3='\[\033[48;5;210m\]'
PY4='\[\033[48;5;216m\]'
PY5='\[\033[48;5;222m\]'
PY6='\[\033[48;5;228m\]'
PY="${PY1} ${PY2} ${PY3} ${PY4} ${PY5} ${PY6} ${DEFAULT}"


#yellowish color used for username
PY5F='\[\033[38;5;222m\]'
#dark purple used for date and $
PP2F='\[\033[38;5;126m\]'
#pinkish color used for commands and paranetheses
PP5F='\[\033[38;5;198m\]'

#echo -ne for some reason doesn't need the \[\] 
ECHOG='\033[38;5;02m'
ECHOR='\033[38;5;09m'


# Gets the exit code of the last command executed.
# Use "printf '%.*s' $? $?" to show only non-zero codes.
# The characters ✓ and ✗ may also be helpful!
function lastexit()
{
        EXITSTATUS="$?"
        if [ $EXITSTATUS -eq 0 ];
        then echo -ne ${ECHOG}$EXITSTATUS; 
        else echo -ne ${ECHOR}$EXITSTATUS; 
        fi;
}

#This refreshes the prompt after every command
setprompt() {
        PS1="${PY}${PP2F} \T ${B}${PP5F}(${PY5F}\u${PP5F}) `lastexit` ${PY5F}\w ${DEFAULT}${N}${PP2F}\$\n${PP}${B}${PP5F} ➜ "
        #trap is necessary because otherwise everything becomes pink
        trap 'echo -ne "\e[0m"' DEBUG
}
PROMPT_COMMAND=setprompt

# -----------------------
# FUNCTIONS
# -----------------------

# flashes the terminal background, q to exit 
function flasher () { while true; do printf \\e[?5h; sleep 0.1; printf \\e[?5l; read -s -n1 -t1 && break; done; }

# swap the names/contents of two files
function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# returns a bunch of information about the current host
# useful when jumping around hosts a lot
function ii()
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; df / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; ip
    echo
}

# print uptime, host name, number of users, and average load
function upinfo () {
echo -ne "$HOSTNAME uptime is ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}

# makes man pages colorful
function man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# kill a given process by name
function pskill() {
    ps ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}

# prints the time every second that passes
function rainbowtime()
{
        while true; do echo "$(date '+%D %T' | toilet -f term -F border --gay)"; sleep 1; done
}

# prints all fonts available to toilet
function toiletfonts()
{
        find /usr/share/figlet -name *.?lf -exec basename {}  \; | sed -e "s/\..lf$//" | xargs -I{} toilet -f {} {}
}

# get total size of current directory
function dirsize()
{
        for filesize in $(ls -l . | grep "^-" | awk '{print $5}')
        do
        let totalsize=$totalsize+$filesize
        done
        echo -n "$totalsize bytes"
        echo ""
}

# prints ANSI 16-colors
function ansicolortest()
{
        T='ABC'   # The test text
        echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
        for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
        do FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
        done
        echo;
        done
        echo
}

# prints xterm 256 colors
function 256colortest()
{
        echo -en "\n   +  "
        for i in {0..35}; do
        printf "%2b " $i
        done
        printf "\n\n %3b  " 0
        for i in {0..15}; do
        echo -en "\033[48;5;${i}m  \033[m "
        done
        #for i in 16 52 88 124 160 196 232; do
        for i in {0..6}; do
        let "i = i*36 +16"
        printf "\n\n %3b  " $i
        for j in {0..35}; do
        let "val = i+j"
        echo -en "\033[48;5;${val}m  \033[m "
        done
        done
        echo -e "\n"
}

# compare the md5 of a file to a know sum
md5check() { md5sum "$1" | grep "$2";}

# check top ten commands executed
topten() { history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -n | tail | sort -nr;}


# Make a permanent history of commands in a file in home
# uses alias "dt" for date things
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo `dt` `pwd` $$ $USER \
               "$(history 1)" >> ~/.bash_eternal_history'


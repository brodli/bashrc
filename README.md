# Matt's .bashrc
My .bashrc files for Linux and Cygwin (Windows). This should be compatible with bash on most common UNIX systems, and I've tested it on my installation of Fedora 25 (using i3 as a window manager) and Cygwin on Windows 10. 

![Example gnome-terminal instance on i3](/img/example.png?raw=true)
![Example gnome-terminal instance on i3 in a working environment](/img/example-full.png?raw=true)

# Features

A list of information provided in the prompt, from left to right, is as follows:

* Username and hostname
* Jobs running in the background
* Command number in bash history and since starting this session
* If applicable, battery charge % and time remaining
* The version of bash
* The current time
* The last command executed, with all aliases expanded
* The runtime of the last command executed
* The exit status of the last command executed
* The current working directory
* The git branch in which work is currently being done
* The user privelege (either $ or #)

# Design Choices
The obvious design choice made is that my preference is to have the prompt provide as much information as possible without regard to space. This runs counter to a lot of what I've seen in the GNU/Linux enthusiast community, but I like it. It has come in handy fairly frequently to have all commands timed by default, to be able to see my full working path, to see the history number of the past few commands for the bash `!` syntax, etc. 

The brightly colored boxes may seem aggressive, but I find it much easier to find my place. When `cat`ing a large file and scrolling back in the history, it can be hard to find your place. Even worse, when debugging the compilation of a program, one can accidentally miss the prompt when scrolling back and attempt to fix errors which have already been fixed! As such I found it useful to add an extremely colorful block as a note that the last command entered was here.

Just before the prompt, I display a random unicode character. This is completely just for fun.

# Environment Variables

### For i3
export TERMINAL="gnome-terminal"

### For git
export VISUAL=nano
export EDITOR="$VISUAL"

In addition, the PATH variable is set in the bashrc, for convenient editing.

# bash Options

set -o ignoreeof
set completion-ignore-case On
shopt -s cdspell
shopt -s checkwinsize
shopt -s autocd

# Complete List of Functions
```
pskill()
flasher()
toiletfonts()
ansicolortest()
256colortest()
topten()
swap()
md5check()
settitle()
ii()
ipf()
upinfo()
cdf()
catf()
```

# Complete List of Aliases

```
alias paths='ls -d $PWD/*'
alias la='ls -A'
alias ll='ls -lvhs'
alias lll='ls -alvhs'
alias l.='ls -d */'
alias sizesort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"
alias l='ls'
alias sl="ls"
alias l="ls"
alias s="ls"
alias cp='cp -i'
alias mv='mv -i'
alias rm="rm -I --preserve-root"
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias mntwin='sudo mount -t ntfs /dev/nvme0n1p3 /mnt/'
alias mkdir='mkdir -p'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd..='cd ..'
alias cd=cdf
alias sb='source ~/.bashrc'
alias cat=catf
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias update='sudo dnf update'
alias upgrade='sudo dnf update && sudo apt-get upgrade'
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mth"
alias now='date +"%T"'
alias dt='date "+%F %T"'
alias cmatrix="cmatrix -bC yellow"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psf="ps auxfww"
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p"
alias wget="wget -c"
alias ip=ipf
alias http="python -m SimpleHTTPServer"
alias ports='echo -e "\n${ECHOR}Open connections :$NC "; netstat -pan --inet;'
alias setc='alias c="\cd $(qwd)"'
alias setc1='alias c1="\cd $(qwd)"'
alias setc2='alias c2="\cd $(qwd)"'
alias setc3='alias c3="\cd $(qwd)"'
alias setc4='alias c4="\cd $(qwd)"'
alias setc5='alias c5="\cd $(qwd)"'
alias setc6='alias c6="\cd $(qwd)"'
alias setc7='alias c7="\cd $(qwd)"'
alias setc8='alias c8="\cd $(qwd)"'
alias setc9='alias c9="\cd $(qwd)"'
alias savec='alias|grep "^alias c[0-9]=" > ~/.bookmarks'
alias lma='alias|grep "^alias c[0-9]="|sed "s/alias //"'
alias checkout='git checkout'
alias branch='git branch'
alias push='git push'
alias pull='git pull'
alias commit='git commit'
alias add='git add'
alias status='git status'
alias stash='git stash'
alias init='git init'
alias clone='git clone'
```


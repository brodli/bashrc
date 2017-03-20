#!/bin/bash
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

PATH="/usr/local/bin:/opt/texbin:/usr/lib64/qt-3.3/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/bin:/usr/sbin:/home/M/.local/bin:/home/M/bin:/home/M/Scripts/Customization/"

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

# append to the history file, don't overwrite it
shopt -s histappend

# set length of command history rememebered
# make sure this isn't overrided by the OS (Ubuntu does this)
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=1000
HISTFILESIZE=1000

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
alias ll='ls -alvhs'
alias l.='ls -d */'
#sort files by size, showing biggest at the bottom
alias sizesort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"
# tree of directories
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
# typo correction
alias ls='ls --color=auto -l'
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

alias sb='source ~/.bashrc'

# easier directory jumping
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# typo fix
alias cd..='cd ..'

alias cat="pygmentize"

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
alias now='date +"%T"'
alias dt='date "+%F %T"'

# easy shutdown/reboot
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"

# custom cmatrix
alias cmatrix="cmatrix -bC yellow"

# search processes (find PID easily)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# show all processes
alias psf="ps auxfww"

#given a PID, intercept the stdout and stderr
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p" 

# make wget continue downloads if inturrupted
alias wget="wget -c"

# show current IP address
alias ip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# super convenient HTTP server
# with python 3, it will be "python3 -m http.server"
alias http="python -m SimpleHTTPServer"

alias hw="ssh -X masnes01@homework.cs.tufts.edu"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# Alerts you when the program has finished/errored
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Show active http connections
alias ports='echo -e "\n${BRED}Open connections :$NC "; netstat -pan --inet;'

# directory bookmarks
# loads bookmarks from file in home directory
alias load='sh .bookmarks'
# aliases to set and go to bookmarks
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
# save bookmarks for later sessions
alias savec='alias|grep -e "alias c\([0-9]\|=\)"|grep -v "alias setc" > ~/.bookmarks'
# list all bookmarks
alias lma='alias|grep -e "alias c\([0-9]\|=\)"|grep -v "alias setc" | sed "s/alias //"'
touch ~/.bookmarks
source ~/.bookmarks

function cdf() {
    \cd "$@"
    ls
}

alias cd=cdf

function checkoutfun() {
    git checkout $1
    ls
}

alias checkout=checkoutfun

alias branch='git branch'
alias push='git push'
alias pull='git pull'
alias commit='git commit'
alias add='git add'
alias status='git status'
alias stash='git stash'
alias init='git init'
alias clone='git clone'

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
BRED='\[\033[38;5;203m\]'
# white
DEFAULT='\[\033[00m\]'

# bold and normal text
B='\[\e[1m\]'
N='\[\e[21m\]'

xc=' '
unicode='×Ø÷±ÿłŊŋƜɨɷɸΔΣΦΨΩαβγδεζηθκλμνξπρστυφχψωᴀᴃᴕᴖ⚗🗺🌀🌁🌂🌃🌄🌅🌆🌇🌈🌉🌊🌋🌌🌍🌎🌏🌐🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜🌝🌞🌟🌠🌡🌢🌣🌤🌥🌦🌧🌨🌩🌪🌫🌬🌭🌮🌯🌰🌱🌲🌳🌴🌵🌶🌷🌸🌹🌺🌻🌼🌽🌾🌿🍀🍁🍂🍃🍄🍅🍆🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓🍔🍕🍖🍗🍘🍙🍚🍛🍜🍝🍞🍟🍠🍡🍢🍣🍤🍥🍦🍧🍨🍩🍪🍫🍬🍭🍮🍯🍰🍱🍲🍳🍴🍵🍶🍷🍸🍹🍺🍻🍼🍽🍾🍿🎀🎁🎂🎃🎄🎅🎆🎇🎈🎉🎊🎋🎌🎍🎎🎏🎐🎑🎒🎓🎔🎕🎖🎗🎘🎙🎚🎛🎜🎝🎞🎟🎠🎡🎢🎣🎤🎥🎦🎧🎨🎩🎪🎫🎬🎭🎮🎯🎰🎱🎲🎳🎴🎵🎶🎷🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿🐀🐁🐂🐃🐄🐅🐆🐇🐈🐉🐊🐋🐌🐍🐎🐏🐐🐑🐒🐓🐔🐕🐖🐗🐘🐙🐚🐛🐜🐝🐞🐟🐠🐡🐢🐣🐤🐥🐦🐧🐨🐩🐪🐫🐬🐭🐮🐯🐰🐱🐲🐳🐴🐵🐶🐷🐸🐹🐺🐻🐼🐽🐾🐿👀👁👂👃👄👅👆👇👈👉👊👋👌👍👎👏👐👑👒👓👔👕👖👗👘👙👚👛👜👝👞👟👠👡👢👣👤👥👦👧👨👩👪👫👬👭👮👯👰👱👲👳👴👵👶👷👸👹👺👻👼👽👾👿💀💁💂💃💄💅💆💇💈💉💊💋💌💍💎💏💐💑💒💓💔💕💖💗💘💙💚💛💜💝💞💟💠💡💢💣💤💥💦💧💨💩💪💫💬💭💮💯💰💱💲💳💴💵💶💷💸💹💺💻💼💽💾💿📀📁📂📃📄📅📆📇📈📉📊📋📌📍📎📏📐📑📒📓📔📕📖📗📘📙📚📛📜📝📞📟📠📡📢📣📤📥📦📧📨📩📪📫📬📭📮📯📰📱📲📳📴📵📶📷📸📹📺📻📼📽📾📿🔀🔁🔂🔃🔄🔅🔆🔇🔈🔉🔊🔋🔌🔍🔎🔏🔐🔑🔒🔓🔔🔕🔖🔗🔘🔙🔚🔛🔜🔝🔞🔟🔠🔡🔢🔣🔤🔥🔦🔧🔨🔩🔪🔫🔬🔭🔮🔯🔰🔱🔲🔳🔴🔵🔶🔷🔸🔹🔺🔻🔼🔽🔾🔿🕀🕁🕂🕃🕄🕅🕆🕇🕈🕉🕊🕋🕌🕍🕎🕏🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚🕛🕜🕝🕞🕟🕠🕡🕢🕣🕤🕥🕦🕧🕨🕩🕪🕫🕬🕭🕮🕯🕰🕱🕲🕳🕴🕵🕶🕷🕸🕹🕺🕻🕼🕽🕾🕿🖀🖁🖂🖃🖄🖅🖆🖇🖈🖉🖊🖋🖌🖍🖎🖏🖐🖑🖒🖓🖔🖕🖖🖗🖘🖙🖚🖛🖜🖝🖞🖟🖠🖡🖢🖣🖤🖥🖦🖧🖨🖩🖪🖫🖬🖭🖮🖯🖰🖱🖲🖳🖴🖵🖶🖷🖸🖹🖺🖻🖼🖽🖾🖿🗀🗁🗂🗃🗄🗅🗆🗇🗈🗉🗊🗋🗌🗍🗎🗏🗐🗑🗒🗓🗔🗕🗖🗗🗘🗙🗚🗛🗜🗝🗞🗟🗠🗡🗢🗣🗤🗥🗦🗧🗨🗩🗪🗫🗬🗭🗮🗯🗰🗱🗲🗳🗴🗵🗶🗷🗸🗹🗺🗻🗼🗽🗾🗿🗡🖱🖲🖼🗂🏵🏷🐿👁📽🕉🕊🕯🕰🕳🕴🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🙐🙑🙒🙓🙔🙕🙖🙗🙘🙙🙚🙛🙜🙝🙞🙟🙠🙡🙢🙣🙤🙥🙦🙧🙨🙩🙪🙫🙬🙭🙮🙯🙰🙱🙲🙳🙴🙵🙶🙷🙸🙹🙺🙻🙼🙽🙾🙿🏳🕵🗃🗄🗑🗒🗓🗜🗝🗞ᴗᴟᴤᴥᴦᴧᴨᴩᴪ•‣…‰‱※D‼‽⁁⁂⁃⁄⁅⁆⁇⁈⁉⁎⁏⁐⁑⁰ⁱ⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿ₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ℂ℃ℇ℉ℊℋℌℍℎℏℐℑℒℓℕ№ℚℛℜℝ℣ℤΩKÅℬℯℰℱℳ⅋ⅎ⅐⅑⅒⅓⅔⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞⅟ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ↔↕↝↠↣↦↬↭↮↯↹↺↻⇎⇏⇒⇛⇝⇢⇶∀∁∂∃∄∅∆∇S∈∉∎∏∐∑−∓∔∕∖∗∘∙√∛∜∝∞∟∠∡∢∣∤∥∦∧∨∩∪∫∬∭∮∯∰∱∲∳∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠⊡⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⌀⌁⌂⌃⌄⌅⌆⌇⌑⌐⌒⌓⌔⌕⌖⌗⌘⌙⌚⌛⌤⌥⌦⌧⌨⌫⌬⏏⏚⏛⏰⏱⏲⏳␣╱╲╳▀▁▂▃▄▅▆▇█▉▊▋▌▍▎▏░▒▓▖▗▘▙▚▛▜▝▞▟■□▢▣▤▥▦▧▨▩▪▫▬▭▮▯▰▱▲△▴▵▶▷▸▹►▻▼▽▾▿◀◁◂◃◄◅◆◇◈◉◊○◌◍◎●◐◑◒◓◔◕◖◗◘◙◚◛◜◝◞◟◠◡◢◣◤◥◦◧◨◩◪◫◬◭◮◯◰◱◲◳◴◵◶◷◸◹◺◻◼◽◾◿☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑☒☓☔☕☖☗☘☙☚☛☜☝☞☟☠☡☢☣☤☥☦☧☨☩☪☫☬☭☮☯☰☱☲☳☴☵☶☷☸☼☽☾☿♀♁♂♃♄♅♆♇♔♕♖♗♘♙♚♛♜♝♞♟♠♡♢♣♤♥♦♧♨♩♪♫♬♭♮♯♲♳♴♵♶♷♸♹♺♻♼♽♾⚀⚁⚂⚃⚄⚅⚐⚑⚒⚓⚔⚕⚖⚗⚘⚙⚚⚛⚜⚝⚞⚟⚠⚡⚢⚣⚤⚥⚦⚧⚨⚩⚪⚫⚬⚭⚮⚯⚰⚱⚲⚳⚴⚵⚶⚷⚸⚹⚺⚻⚼⛀⛁⛂⛃⛢⛤⛥⛦⛧⛨⛩⛪⛫⛬⛭⛮⛯⛰⛱⛲⛴⛵⛶⛷⛸⛹⛺⛻⛼⛽⛾⛿✁✂✃✄✅✆✇✈✉✊✋✌✍✎✏✐✑✒✓✔✕✖✗✘✙✚✛✜✝✞✟✠✡✢✣✤✥✦✧✨✩✪✫✬✭✮✯✰✱✲✳✴✵✶✷✸✹✺✻✼✽✾✿❀❁❂❃❄❅❆❇❈❉❊❋❌❍❎❏❐❑❒❓❔❕❖❗❟❠❡❢❣❤❥❦❧⟴⟿⤀⤁⤐⤑⤔⤕⤖⤗⤘⤨⤩⤪⤫⤬⤭⤮⤯⤰⤱⤲⤼⤽⤾⤿⥀⥁⥂⥃⥄⥅⥆⥇⥈⥉⥊⥋⥌⥍⥎⥏⥐⥑⬒⬓⬔⬕⬖⬗⬘⬙⬚⸮〃〄﴾﴿︽︾﹁﹂﹃﹄﹅﹆｟｠⌬⌬⌬⌬◉∰⁂⛃⛁◉∰⁂⛃⛁◉∰⁂⛃⛁◉∰⁂⛃⛁⛇⛓⚛⛇⛓⚛⛇⛓⚛⛇⛓⚛'
unicodelen=${#unicode}
function getunicodec() {
    r="$RANDOM"
    from=$(($r % $unicodelen))
    echo "${unicode:from:1}"
}

# purple to peach colors (background colors)
PP0='\[\033[48;5;18m\]'
PP1='\[\033[48;5;54m\]'
PP2='\[\033[48;5;90m\]'
PP3='\[\033[48;5;126m\]'
PP4='\[\033[48;5;162m\]'
PP5='\[\033[48;5;198m\]'

#peach to yellow
PY1='\[\033[48;5;198m\]'
PY2='\[\033[48;5;204m\]'
PY3='\[\033[48;5;210m\]'
PY4='\[\033[48;5;216m\]'
PY5='\[\033[48;5;222m\]'
PY6='\[\033[48;5;228m\]'
PY="${PY1}${xc}${PY2}${xc}${PY3}${xc}${PY4}${xc}${PY5}${xc}${PY6}${xc}${DEFAULT}"

PM0='\[\033[48;5;18m\]'
PM1='\[\033[48;5;54m\]'
PM2='\[\033[48;5;90m\]'
PM3='\[\033[48;5;126m\]'
PM4='\[\033[48;5;162m\]'
PM5='\[\033[48;5;198m\]'
PM="${PM0}${xc}${PM1}${xc}${PM2}${xc}${PM3}${xc}${PM4}${xc}${PM5}${xc}${DEFAULT}"

PY1F='\[\033[38;5;198m\]'
PY2F='\[\033[38;5;204m\]'
PY3F='\[\033[38;5;210m\]'
PY4F='\[\033[38;5;216m\]'
PY5F='\[\033[38;5;222m\]'
PY6F='\[\033[38;5;228m\]'
PP0F='\[\033[38;5;18m\]'
#dark purple used for date and $
PP2F='\[\033[38;5;126m\]'
#pinkish color used for commands and paranetheses
PP5F='\[\033[38;5;198m\]'

ESG='\[\033[38;5;119m\]'
ESR='\[\033[38;5;203m\]'
#echo -ne doesn't need the \[\], as they are PS1 escapes 
ECHOG='\033[38;5;119m'
ECHOR='\033[38;5;203m'
NC='\033[00m'

# Gets the exit code of the last command executed.
# Use "printf '%.*s' $? $?" to show only non-zero codes.
# The characters ✓ and ✗ may also be helpful!
function lastexit()
{
        EXITSTATUS="$1"
        if [ $EXITSTATUS -eq 0 ]; 
        then echo "${ESG}${EXITSTATUS}"; 
        else echo "${ESR}${EXITSTATUS}"; 
        fi;
}
function lastexitcolor()
{
        EXITSTATUS="$1"
        if [ $EXITSTATUS -eq 0 ]; 
        then echo "${ESG}";
        else echo "${ESR}"; 
        fi;
}

function gitbranch()
{
        git rev-parse --abbrev-ref HEAD 2> /dev/null 1> /dev/null
        if [[ "$?" -eq "0" ]]; then
            str="⎇ $(git rev-parse --abbrev-ref HEAD | tr -d '$' | tr -d '`')"
        echo " ${str}"
        fi;
}

function timer_now() {
    date +%s%N
}

function timer_start() {
    start_time="${start_time:-$(timer_now)}"
}

function timer_stop() {
    if [[ $NUM_CALLS -lt 2 ]]; then
        timer_show="␣"
        NUM_CALLS=0
        unset start_time
        return
    fi
    local delta_us=$((($(timer_now)-start_time)/1000))
    local us=$((delta_us%1000))
    local ms=$(((delta_us/1000)%1000))
    local s=$(((delta_us/1000000)%60))
    local m=$(((delta_us/60000000)%60))
    local h=$((delta_us/3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h>0)); then timer_show=${h}h${m}m
    elif ((m>0)); then timer_show=${m}m${s}s
    elif ((s>=10)); then timer_show=${s}.$((ms/100))s
    elif ((s>0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms>=100)); then timer_show=${ms}ms
    elif ((ms>0)); then timer_show=${ms}.$((us/100))ms
    else timer_show=${us}us
    fi
    unset start_time
    NUM_CALLS=0
}


#preexec > timer_start > if SETTING_PROMPT unset, start timer_start
#> else unset SETTING_PROMPT
#setprompt > 
ac='↣'
function preexec() {
    if [[ -z "$this" ]]; then
        this=$BASH_COMMAND
        this="$(echo "$this" | sed 's/this=//g')"
    elif [[ "$BASH_COMMAND" != "setprompt" ]]; then
        this+=" ${ac} "$BASH_COMMAND
        this="$(echo "$this" | sed 's/this+=" ${ac} "//g')"
    fi

    NUM_CALLS=$((NUM_CALLS + 1))
    echo -ne "\e[0m"
    timer_start
}

LS_COLORS=$LS_COLORS:'di=0;95:ln=0;35:ex=0;93'
trap 'preexec' DEBUG

function bat() {
    f=$(\cat /sys/class/power_supply/BAT0/charge_full)
    c=$(\cat /sys/class/power_supply/BAT0/charge_now)
    echo "$(bc -l <<< "$c/$f * 100")" | cut -c1-5
}

#This refreshes the prompt after every command
function setprompt() {
    out="$?"
    le=$(lastexit $out)
    lc=$(lastexitcolor $out)
    timer_stop
    runt=$timer_show
    uc="$PY6F"
    hc=$uc
    fir="$PY"
    sec="$PM"
    if [[ "$(id -u)" == "0" ]]; then
        uc="$ESR"
        hc="$PY6F"
        sec="$PM"
    elif [[ "$(hostname)" != "matt" ]]; then
        uc="$PY6F$PP0"
    fi;

     PS1="${lc}╭─${fir} ${uc}\u${DEFAULT}${PP2F}@${uc}${hc}\H${DEFAULT} ${PY5F}\j${PP2F}j !${PY4F}\!${PP2F}/${PY4F}\# ${PY3F}$(bat)${PP2F}% ${PY2F}\s ${PP2F}v${PY2F}\V ${PY1F}\@ \n"
    PS1+="${lc}⎬─${sec} ${PY4F}${this} ${PY5F}runtime: \[${runt}\] ${PY6F}exit: ${le}\n"
    PS1+="${lc}⎬─${fir} ${PY6F}\w${PY2F}\[$(gitbranch)\] ${PP2F}\\$\n"
    PS1+="  \r${lc}╰┄┈◽${uc}\[$(getunicodec)\011\]${DEFAULT}${PP5F}◈▷ "
    unset this
    echo "$(dt) $(pwd) $$ $USER $(history 1)" >> ~/.bash_eternal_history

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
    echo -e "\nYou are logged on to ${ECHOG}$(hostname)$NC"
    echo -e "\n${ECHOG}Additionnal information:$NC " ; uname -a
    echo -e "\n${ECHOG}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${ECHOG}Current date :$NC " ; date
    echo -e "\n${ECHOG}Machine stats :$NC " ; uptime
    echo -e "\n${ECHOG}Memory stats :$NC " ; free
    echo -e "\n${ECHOG}Diskspace :$NC " ; df / $HOME
    echo -e "\n${ECHOG}Local IP Address :$NC" ; ip
    echo ''
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

function toiletfonts()
{
        find /usr/share/figlet -name *.?lf -exec basename {}  \; | sed -e "s/\..lf$//" | xargs -I{} toilet -f {} {}
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



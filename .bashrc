#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ═══════════════════════════════════════
# LOCALE
# ═══════════════════════════════════════
#localectl set-locale LANG=en_US.UTF-8

# ═══════════════════════════════════════
# ENVIRONMENT VARIABLES
# ═══════════════════════════════════════
#for i3
export TERMINAL="gnome-terminal"

# Modify path here:
PATH="/usr/local/bin:/opt/texbin:/usr/lib64/qt-3.3/bin:/usr/lib64/ccache"
PATH+=":/usr/local/sbin:/usr/bin:/usr/sbin:/home/M/.local/bin:/home/M/bin"
PATH+=":/home/M/Scripts/Customization/"
export PATH

# Editor for git and other commands
export VISUAL=nano
export EDITOR="$VISUAL"

# ═══════════════════════════════════════
# CONFIG SETUP
# ═══════════════════════════════════════
# Load x settings in xterm, urxvt, etc.
if [[ -f ~/.Xresources ]];then xrdb -merge ~/.Xresources; fi

# ═══════════════════════════════════════
# BASH FLAGS
# ═══════════════════════════════════════
# don't exit terimal on ctrl+D EOF
set -o ignoreeof
# set tab-autocompete to ignore case
set completion-ignore-case On
# make cd ignore case and small typos
shopt -s cdspell
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# go to a directory when it is typed alone on a line (cd automatically)
shopt -s autocd

# ═══════════════════════════════════════
# HISTORY MANAGEMENT
# ═══════════════════════════════════════
# append to the history file, don't overwrite it
shopt -s histappend
# set length of command history rememebered
# make sure this isn't overrided by the OS (Ubuntu does this)
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=1000
HISTFILESIZE=1000

# ═══════════════════════════════════════
# COLORS FOR COMMON COMMANDS
# ═══════════════════════════════════════

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

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias diff="colordiff"

PY0F='\[\033[38;5;198m\]'
PY1F='\[\033[38;5;204m\]'
PY2F='\[\033[38;5;210m\]'
PY3F='\[\033[38;5;216m\]'
PY4F='\[\033[38;5;222m\]'
PY5F='\[\033[38;5;228m\]'
# Less and man color codes
export LESS_TERMCAP_mb=$'\033[38;5;198m'     # begin blink
export LESS_TERMCAP_md=$'\033[38;5;228m'     # begin bold
export LESS_TERMCAP_so=$'\033[38;5;222m'     # begin reverse video
export LESS_TERMCAP_us=$'\033[38;5;204m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

# Give less options to man
export MANPAGER='less -s -M +Gg'

# ═══════════════════════════════════════
# LS ALIASES
# ═══════════════════════════════════════
# Show full paths of files in current directory
alias paths='ls -d $PWD/*'
# Show hidden files too
alias la='ls -A'
# Show file size, permissions, date, etc.
alias ll='ls -lvhs'
alias lll='ls -alvhs'
# Show only directories 
alias l.='ls -d */'
# sort files by size, showing biggest at the bottom
alias sizesort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"
# typo correction
alias l='ls'
alias sl="ls"
alias l="ls"
alias s="ls"

# Custom colors for ls
LS_COLORS=$LS_COLORS:'di=0;95:ln=0;35:ex=0;93'

# ═══════════════════════════════════════
# FILE MANAGEMENT ALIASES
# ═══════════════════════════════════════
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

function cdf() {
    \cd "$@"
    ls -l
}
alias cd=cdf

# ═══════════════════════════════════════
# RELOAD .BASHRC
# ═══════════════════════════════════════
alias sb='source ~/.bashrc'

# ═══════════════════════════════════════
# FILE READ/WRITE
# ═══════════════════════════════════════
# try to use python pygmentize; if it doesn't know what to do,
# just use regular cat
catf() {
    args=$@
    pygmentize $args 2>/dev/null
    if [[ "$?" != "0" ]]; then
        \cat $args
    fi
}
alias cat=catf

# ═══════════════════════════════════════
# PACKAGE MANAGEMENT
# ═══════════════════════════════════════
# stop typing so much when package managing
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias update='sudo dnf update'
alias upgrade='sudo dnf update && sudo apt-get upgrade'

# ═══════════════════════════════════════
# OS POWER MANAGEMENT
# ═══════════════════════════════════════
# easy shutdown/reboot
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"

# ═══════════════════════════════════════
# DISK UTILS
# ═══════════════════════════════════════
# make common commands easier to read for humans
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mth"

# ═══════════════════════════════════════
# TIME AND DATE
# ═══════════════════════════════════════
# easy time and date printing
alias now='date +"%T"'
alias dt='date "+%F %T"'

# ═══════════════════════════════════════
# PRETTY THINGS
# ═══════════════════════════════════════
# custom cmatrix
alias cmatrix="cmatrix -bC yellow"

# ═══════════════════════════════════════
# PROCESS MANAGEMENT
# ═══════════════════════════════════════
# search processes (find PID easily)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# show all processes
alias psf="ps auxfww"
#given a PID, intercept the stdout and stderr
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p" 
# kill a given process by name
function pskill() {
    ps ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}

# ═══════════════════════════════════════
# NETWORKS AND FILES
# ═══════════════════════════════════════
# make wget continue downloads if inturrupted
alias wget="wget -c"

# show current IP address
ipf() {
    pip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v ^$)
    echo "$pip" | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'

}
alias ip=ipf

# super convenient HTTP server
# with python 3, it will be "python3 -m http.server"
alias http="python -m SimpleHTTPServer"

# Show active http connections
alias ports='echo -e "\n${ECHOR}Open connections :$NC "; netstat -pan --inet;'

# ═══════════════════════════════════════
# SSH ALIASES
# ═══════════════════════════════════════
# So as to not expose my ip addresses of interest on GitHub
if [[ -f ~/.ssh_aliases ]]; then source ~/.ssh_aliases; fi

# ═══════════════════════════════════════
# BOOKMARKING SYSTEM
# ═══════════════════════════════════════
#use to get current directory with spaces escaped
alias qwd='printf "%q\n" "$(pwd)"'

# loads bookmarks from file in home directory
alias load='bash ~/.bookmarks'
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
alias savec='alias|grep "^alias c[0-9]=" > ~/.bookmarks'
# list all bookmarks
alias lma='alias|grep "^alias c[0-9]="|sed "s/alias //"'
touch ~/.bookmarks
if [[ -f ~/.bookmarks ]]; then source ~/.bookmarks; fi

# ═══════════════════════════════════════
# GIT & GITHUB
# ═══════════════════════════════════════
# checkout a branch and display the files we see
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

# ═══════════════════════════════════════
# UNICODE BLOCK
# ═══════════════════════════════════════
# For fun selection of random unicode chars
unicode='×Ø÷±ÿłŊŋƜɨɷɸΔΣΦΨΩαβγδεζηθκλμνξπρστυφχψωᴀᴃᴕᴖ⚗🗺🌀🌁🌂🌃🌄🌅🌆🌇🌈🌉🌊🌋'
unicode+='🌌🌍🌎🌏🌐🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜🌝🌞🌟🌠🌡🌢🌣🌤🌥🌦🌧🌨🌩🌪🌫🌬🌭🌮🌯🌰🌱🌲🌳🌴🌵🌶'
unicode+='🌷🌸🌹🌺🌻🌼🌽🌾🌿🍀🍁🍂🍃🍄🍅🍆🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓🍔🍕🍖🍗🍘🍙🍚🍛🍜🍝🍞🍟🍠'
unicode+='🍡🍢🍣🍤🍥🍦🍧🍨🍩🍪🍫🍬🍭🍮🍯🍰🍱🍲🍳🍴🍵🍶🍷🍸🍹🍺🍻🍼🍽🍾🍿🎀🎁🎂🎃🎄🎅🎆🎇🎈🎉🎊'
unicode+='🎋🎌🎍🎎🎏🎐🎑🎒🎓🎔🎕🎖🎗🎘🎙🎚🎛🎜🎝🎞🎟🎠🎡🎢🎣🎤🎥🎦🎧🎨🎩🎪🎫🎬🎭🎮🎯🎰🎱🎲🎳🎴'
unicode+='🎵🎶🎷🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟'
unicode+='🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿🐀🐁🐂🐃🐄🐅🐆🐇🐈🐉'
unicode+='🐊🐋🐌🐍🐎🐏🐐🐑🐒🐓🐔🐕🐖🐗🐘🐙🐚🐛🐜🐝🐞🐟🐠🐡🐢🐣🐤🐥🐦🐧🐨🐩🐪🐫🐬🐭🐮🐯🐰🐱🐲'
unicode+='🐳🐴🐵🐶🐷🐸🐹🐺🐻🐼🐽🐾🐿👀👁👂👃👄👅👆👇👈👉👊👋👌👍👎👏👐👑👒👓👔👕👖👗👘👙👚👛'
unicode+='👜👝👞👟👠👡👢👣👤👥👦👧👨👩👪👫👬👭👮👯👰👱👲👳👴👵👶👷👸👹👺👻👼👽👾👿💀💁💂💃💄💅'
unicode+='💆💇💈💉💊💋💌💍💎💏💐💑💒💓💔💕💖💗💘💙💚💛💜💝💞💟💠💡💢💣💤💥💦💧💨💩💪💫💬💭💮'
unicode+='💯💰💱💲💳💴💵💶💷💸💹💺💻💼💽💾💿📀📁📂📃📄📅📆📇📈📉📊📋📌📍📎📏📐📑📒📓📔📕📖📗'
unicode+='📘📙📚📛📜📝📞📟📠📡📢📣📤📥📦📧📨📩📪📫📬📭📮📯📰📱📲📳📴📵📶📷📸📹📺📻📼📽📾📿🔀🔁'
unicode+='🔂🔃🔄🔅🔆🔇🔈🔉🔊🔋🔌🔍🔎🔏🔐🔑🔒🔓🔔🔕🔖🔗🔘🔙🔚🔛🔜🔝🔞🔟🔠🔡🔢🔣🔤🔥🔦🔧🔨🔩🔪🔫'
unicode+='🔬🔭🔮🔯🔰🔱🔲🔳🔴🔵🔶🔷🔸🔹🔺🔻🔼🔽🔾🔿🕀🕁🕂🕃🕄🕅🕆🕇🕈🕉🕊🕋🕌🕍🕎🕏🕐🕑🕒🕓🕔🕕🕖🕗'
unicode+='🕘🕙🕚🕛🕜🕝🕞🕟🕠🕡🕢🕣🕤🕥🕦🕧🕨🕩🕪🕫🕬🕭🕮🕯🕰🕱🕲🕳🕴🕵🕶🕷🕸🕹🕺🕻🕼🕽🕾🕿🖀🖁🖂🖃'
unicode+='🖄🖅🖆🖇🖈🖉🖊🖋🖌🖍🖎🖏🖐🖑🖒🖓🖔🖕🖖🖗🖘🖙🖚🖛🖜🖝🖞🖟🖠🖡🖢🖣🖤🖥🖦🖧🖨🖩🖪🖫🖬🖭🖮🖯🖰🖱🖲'
unicode+='🖳🖴🖵🖶🖷🖸🖹🖺🖻🖼🖽🖾🖿🗀🗁🗂🗃🗄🗅🗆🗇🗈🗉🗊🗋🗌🗍🗎🗏🗐🗑🗒🗓🗔🗕🗖🗗🗘🗙🗚🗛🗜🗝🗞🗟'
unicode+='🗠🗡🗢🗣🗤🗥🗦🗧🗨🗩🗪🗫🗬🗭🗮🗯🗰🗱🗲🗳🗴🗵🗶🗷🗸🗹🗺🗻🗼🗽🗾🗿🗡🖱🖲🖼🗂🏵🏷🐿👁'
unicode+='📽🕉🕊🕯🕰🕳🕴🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🙐🙑🙒🙓🙔🙕🙖🙗🙘🙙🙚🙛🙜🙝🙞🙟🙠🙡🙢🙣🙤🙥🙦🙧'
unicode+='🙨🙩🙪🙫🙬🙭🙮🙯🙰🙱🙲🙳🙴🙵🙶🙷🙸🙹🙺🙻🙼🙽🙾🙿🏳🕵🗃🗄🗑🗒🗓🗜🗝🗞ᴗᴟᴤᴥᴦᴧᴨᴩᴪ•‣…‰‱※D‼‽⁁'
unicode+='⁂⁃⁄⁅⁆⁇⁈⁉⁎⁏⁐⁑⁰ⁱ⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿ₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ℂ℃ℇ℉ℊℋℌℍℎℏℐℑℒℓℕ№ℚℛℜℝ℣ℤΩKÅℬℯℰℱ'
unicode+='ℳ⅋ⅎ⅐⅑⅒⅓⅔⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞⅟ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ↔↕↝↠↣↦↬↭↮↯'
unicode+='↹↺↻⇎⇏⇒⇛⇝⇢⇶∀∁∂∃∄∅∆∇S∈∉∎∏∐∑−∓∔∕∖∗∘∙√∛∜∝∞∟∠∡∢∣∤∥∦∧∨∩∪∫∬∭∮∯∰∱'
unicode+='∲∳∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦'
unicode+='≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘'
unicode+='⊙⊚⊛⊜⊝⊞⊟⊠⊡⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚'
unicode+='⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⌀⌁⌂⌃⌄⌅⌆⌇⌑⌐⌒⌓⌔⌕⌖⌗⌘⌙⌚⌛⌤⌥⌦⌧⌨'
unicode+='⌫⌬⏏⏚⏛⏰⏱⏲⏳␣╱╲╳▀▁▂▃▄▅▆▇█▉▊▋▌▍▎▏░▒▓▖▗▘▙▚▛▜▝▞▟■□▢▣▤▥▦▧▨'
unicode+='▩▪▫▬▭▮▯▰▱▲△▴▵▶▷▸▹►▻▼▽▾▿◀◁◂◃◄◅◆◇◈◉◊○◌◍◎●◐◑◒◓◔◕◖◗◘◙◚◛◜◝◞◟◠◡'
unicode+='◢◣◤◥◦◧◨◩◪◫◬◭◮◯◰◱◲◳◴◵◶◷◸◹◺◻◼◽◾◿☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑'
unicode+='☒☓☔☕☖☗☘☙☚☛☜☝☞☟☠☡☢☣☤☥☦☧☨☩☪☫☬☭☮☯☰☱☲☳☴☵☶☷☸☼☽☾☿♀♁♂♃♄♅'
unicode+='♆♇♔♕♖♗♘♙♚♛♜♝♞♟♠♡♢♣♤♥♦♧♨♩♪♫♬♭♮♯♲♳♴♵♶♷♸♹♺♻♼♽♾⚀⚁⚂⚃⚄⚅'
unicode+='⚐⚑⚒⚓⚔⚕⚖⚗⚘⚙⚚⚛⚜⚝⚞⚟⚠⚡⚢⚣⚤⚥⚦⚧⚨⚩⚪⚫⚬⚭⚮⚯⚰⚱⚲⚳⚴⚵⚶⚷⚸⚹⚺⚻⚼⛀⛁⛂'
unicode+='⛃⛢⛤⛥⛦⛧⛨⛩⛪⛫⛬⛭⛮⛯⛰⛱⛲⛴⛵⛶⛷⛸⛹⛺⛻⛼⛽⛾⛿✁✂✃✄✅✆✇✈✉✊✋✌✍✎✏'
unicode+='✐✑✒✓✔✕✖✗✘✙✚✛✜✝✞✟✠✡✢✣✤✥✦✧✨✩✪✫✬✭✮✯✰✱✲✳✴✵✶✷✸✹✺✻✼✽✾✿❀'
unicode+='❁❂❃❄❅❆❇❈❉❊❋❌❍❎❏❐❑❒❓❔❕❖❗❟❠❡❢❣❤❥❦❧⟴⟿⤀⤁⤐⤑⤔⤕⤖⤗⤘⤨⤩⤪⤫⤬'
unicode+='⤭⤮⤯⤰⤱⤲⤼⤽⤾⤿⥀⥁⥂⥃⥄⥅⥆⥇⥈⥉⥊⥋⥌⥍⥎⥏⥐⥑⬒⬓⬔⬕⬖⬗⬘⬙⬚⸮〃〄﴾﴿︽︾﹁﹂﹃﹄﹅'
unicode+='﹆｟｠⌬⌬⌬⌬◉∰⁂⛃⛁◉∰⁂⛃⛁◉∰⁂⛃⛁◉∰⁂⛃⛁⛇⛓⚛⛇⛓⚛⛇⛓⚛⛇⛓⚛'

# Length of the previous string
unicodelen=${#unicode}

# Get a random character from the previous string
function getunicodec() {
    r="$RANDOM"
    from=$((r%unicodelen))
    echo "${unicode:from:1}"
}

# ═══════════════════════════════════════
# BASIC COLOR CODES
# ═══════════════════════════════════════
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
# default white
D='\[\033[00m\]'
# bold and normal text
B='\[\e[1m\]'
N='\[\e[21m\]'

# ═══════════════════════════════════════
# COLOR CODES FOR ECHO STATEMENTS
# ═══════════════════════════════════════

# echo -ne doesn't need the \[\], as they are PS1 escapes
# Same colors as ESG and ESR below
ECHOG='\033[38;5;119m'
ECHOR='\033[38;5;203m'
# A darker red, to stand out more
ECHOR2='\033[38;5;09m'

# No color. Same as $D but for echo
NC='\033[00m'

# ═══════════════════════════════════════
# PS1 COLOR SCHEME CODES & FORMATTING
# ═══════════════════════════════════════

BRED='\[\033[38;5;203m\]'
# character to use in spacing out 6-character color blocks. Space for now
# as I'm only using a backgrouund color.
xc=' '

# Peach to yellow
PY0='\[\033[48;5;198m\]'
PY1='\[\033[48;5;204m\]'
PY2='\[\033[48;5;210m\]'
PY3='\[\033[48;5;216m\]'
PY4='\[\033[48;5;222m\]'
PY5='\[\033[48;5;228m\]'
PY="${PY0}${xc}${PY1}${xc}${PY2}${xc}${PY3}${xc}${PY4}${xc}${PY5}${xc}${D}"

# Indigo to peach
IP0='\[\033[48;5;18m\]'
IP1='\[\033[48;5;54m\]'
IP2='\[\033[48;5;90m\]'
IP3='\[\033[48;5;126m\]'
IP4='\[\033[48;5;162m\]'
IP5='\[\033[48;5;198m\]'
IP="${IP0}${xc}${IP1}${xc}${IP2}${xc}${IP3}${xc}${IP4}${xc}${IP5}${xc}${D}"

# Same as PY sequence, but for foreground colors
PY0F='\[\033[38;5;198m\]'
PY1F='\[\033[38;5;204m\]'
PY2F='\[\033[38;5;210m\]'
PY3F='\[\033[38;5;216m\]'
PY4F='\[\033[38;5;222m\]'
PY5F='\[\033[38;5;228m\]'

# Dark purple used for highlights
IP3F='\[\033[38;5;126m\]'

# A bright green and red, for highlights on exit status components
# (exit status red and exit status green)
ESG='\[\033[38;5;119m\]'
ESR='\[\033[38;5;203m\]'

# ═══════════════════════════════════════
# EXIT STATUS MANAGEMENT
# ═══════════════════════════════════════
# Gets the exit code of the last command executed.
# Use "printf '%.*s' $? $?" to show only non-zero codes.
# The characters ✓ and ✗ may also be helpful!
function lastexit()
{
        EXITSTATUS="$1"
        if [ $EXITSTATUS -eq 0 ]; 
        then echo -e "${ESG}${EXITSTATUS}"; 
        else echo -e "${RED}${EXITSTATUS}"; 
        fi;
}

# Returns only a red or green color, depending on exit status
function lastexitcolor()
{
        EXITSTATUS="$1"
        if [ $EXITSTATUS -eq 0 ]; 
        then echo -e "${ESG}";
        else echo -e "${ESR}"; 
        fi;
}

# ═══════════════════════════════════════
# GIT BRANCH MANAGEMENT
# ═══════════════════════════════════════
# Return a pretty-formatted string of the current git branch, if it exists
function gitbranch()
{
        git rev-parse --abbrev-ref HEAD 2> /dev/null 1> /dev/null
        if [[ "$?" -eq "0" ]]; then
            str=" $(git rev-parse --abbrev-ref HEAD | tr -d '$' | tr -d '`')"
        echo " ${str}"
        fi;
}

# ═══════════════════════════════════════
# BATTERY DIAGNOSTICS FOR PS1
# ═══════════════════════════════════════
# Check if the expected battery files exist
function bat_c() {
    [[ -f /sys/class/power_supply/BAT0/charge_full_design ]] && \
    [[ -f /sys/class/power_supply/BAT0/charge_now ]] && \
    [[ -f /sys/class/power_supply/BAT0/current_now ]] && \
    [[ -f /sys/class/power_supply/BAT0/status ]];
}
# Get current battery percentage, color it red if < 15%
function bat_p() {
    f=$(\cat /sys/class/power_supply/BAT0/charge_full_design 2>/dev/null)
    c=$(\cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)
    echo "$(bc -l <<< "$c/$f * 100")" | cut -c1-5
    #echo 10
}

# Get projected battery life time remaining
function bat_t() {
    c=$(\cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)
    i=$(\cat /sys/class/power_supply/BAT0/current_now 2>/dev/null)
    s=$(\cat /sys/class/power_supply/BAT0/status)
    if [[ "$s" == "Full" ]]; then
        echo '🔌'
    else
        echo "$(bc -l <<< "$c/$i")" | cut -c1-5
    fi
}

# Get the current battery status: discharging, charging, or full
function bat_s() {
    s=$(\cat /sys/class/power_supply/BAT0/status)
    if [[ "$s" == "Discharging" ]]; then
        echo -e "${ECHOR2}▾"
    elif [[ "$s" == "Charging" ]]; then
        echo -e "${ECHOG}▴"
    elif [[ "$s" == "Full" ]]; then
        echo -e "${ECHOG}▫"
    fi
}

# ═══════════════════════════════════════
# COMMAND EXECUTION TIMER
# ═══════════════════════════════════════
# Returns epoch nanosecond time
function timer_now() {
    date +%s%N
}

# Start a timer for the next command, or leave it at its current
# value if it exists
function timer_start() {
    start_time="${start_time:-$(timer_now)}"
}

# Stop a timer if running, and set the timer_show variable to 
# the final value in a human-readable format.
function timer_stop() {
    # If no command was run, ignore any elapsed time.
    if [[ $NUM_CALLS -lt 2 ]]; then
        timer_show="␣"
        NUM_CALLS=0
        unset start_time
        return
    fi
    # Unit conversion
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

# ═══════════════════════════════════════
# PRE-COMMAND EXECUTION HOOK
# ═══════════════════════════════════════
function preexec() {
    # Character for showing commands executed this cycle
    ac='↣'
    # Before anything, print out a color code to make output default color
    echo -ne "\e[0m"
    # Concatenate expanded function calls into $this variable
    # So we can display it in PS1
    if [[ -z "$this" ]] && [[ "$BASH_COMMAND" != 'setprompt' ]] \
        && [[ "$BASH_COMMAND" != 'PROMPT_COMMAND=setprompt' ]]; then
        this=$BASH_COMMAND
        this="$(echo "$this" | sed 's/this=//g')"
    elif [[ "$BASH_COMMAND" != 'setprompt' ]] \
        && [[ "$BASH_COMMAND" != 'PROMPT_COMMAND=setprompt' ]]; then
        this+=" ${ac} "$BASH_COMMAND
        this="$(echo "$this" | sed 's/this+=" ${ac} "//g')"
    fi
    # Increment our counter for the number of simple commands executed
    # in this prompt cycle
    NUM_CALLS=$((NUM_CALLS + 1))
    # Begin a timer
    timer_start
}
# Ensure this runs before every command.
trap 'preexec' DEBUG

# ═══════════════════════════════════════
# PS1 DEFINITION (PROMPT_COMMAND)
# ═══════════════════════════════════════
#This refreshes the prompt after every command
function setprompt() {
    # Grab last exit status (must be first line)
    out="$?"
    # Stop the timer
    timer_stop
    runt=$timer_show
    # Append the last command to our history
    history -a
    # Get the color and status we will use for the exit status
    le=$(lastexit $out)
    lc=$(lastexitcolor $out)
    # Set our username color and host color. If username is root,
    # we want it to be red. If the hostname is not the name of
    # my laptop, we want that to be red also as we are ssh'd somewhere.
    uc="$PY5F"
    hc=$uc
    if [[ "$(id -u)" == "0" ]]; then
        uc="$ESR"
        hc="$PY5F"
    elif [[ "$(hostname)" != "matt" ]]; then
        uc="$PY5F$PP0"
        hc="$RED"
    fi;

    # If we have something in the $this variable, i.e. if some
    # command was run, then we want to display it, and it needs to
    # be followed by a space. If it is empty, then we will display
    # it anyway, but it will be an empty string.
    if [[ ! -z "$this" ]]; then
        this+=' '
    fi

    # In case the order needs to be changed conditionally.
    fir="$PY"
    sec="$IP"

    if bat_c; then 
        batstr="$(bat_s)${bc}$(bat_p)${IP3F}% ${bc}$(bat_t)${IP3F}h "
        # Get battery status
        bc="${PY2F}"
        if [[ $(bat_p | sed 's/\..*//') -lt 15 ]]; then
            bc="${RED}"
        fi;
    fi

    # Anatomy of PS1 Variable:

    # LINE 1:
    # Color of exit status   Number of jobs running
    # ┃   Rainbow colors     ┃   command # in history      12 hour AM/PM time
    # ┃   ┃                  ┃   ┃    command # since starting shell  ┃
    # ┃   ┃                  ┃   ┃    ┃  battery status               ┃
    # ┃   ┃                  ┃   ┃    ┃  ┃        battery time left   ┃ 
    # ┃   ┃ self-explanatory ┃   ┃    ┃  ┃ % left ┃     shell version ┃
    # ┃   ┃        ┃         ┃   ┃    ┃  ┃ ┃      ┃     ┃     ┃       ┃
    # ▼   ▼       ▼         ▼   ▼   ▼  ▼ ▼      ▼    ▼     ▼       ▼   
    # ╭─████ user@hostname 2j !1000/123 ▾50.00% 3.000h bash v4.3.43 12:00PM

    # LINE 2:
    #                                               Last command exit status
    #   Human readable runtime for last command           ┃
    # Last command w/ all aliases expanded    ┃           ┃
    #              ┃                          ┃           ┃
    #              ▼                          ▼          ▼
    # ⎬─████ ls --color-auto -lvhs runtime: 5.0ms exit: 0

    # LINE 3:
    #                                 User privelege ($ if normal, # if root)
    #                Current git branch   ┃
    #     Current working directory   ┃   ┃
    #                  ┃              ┃   ┃
    #                  ▼             ▼   ▼
    # ⎬─████ ~/Documents/Project ⎇ dev $ 

    # LINE 4:
    #      Random unicode character from block above
    #      ┃   Indicator for beginning of field to type command
    #      ┃   ┃
    #      ▼   ▼
    # ╰┄┈◽ ◇  ◈▷

    # All together, we have:
    # ╭─████ user@hostname 2j !1000/123 ▾50.00% 3.000h bash v4.3.43 12:00PM
    # ⎬─████ ls --color-auto -lvhs runtime: 5.0ms exit: 0
    # ⎬─████ ~/Documents/Project ⎇ dev $ 
    # ╰┄┈◽ ◇  ◈▷

     PS1="${lc}╭─${fir} ${uc}\u${D}${IP3F}@${uc}${hc}\H${D} ${PY4F}\j${IP3F}j"
    PS1+=" !${PY3F}\!${IP3F}/${PY3F}\# ${batstr}${PY1F}\s"
    PS1+=" ${IP3F}v${PY1F}\V ${PY0F}\@ \n"
    PS1+="${lc}⎬─${sec} ${PY3F}${this}${D}${PY4F}runtime: \[${runt}\]"
    PS1+=" ${PY5F}exit: ${le}\n"
    PS1+="${lc}⎬─${fir} ${PY4F}\w${PY1F}\[$(gitbranch)\] ${IP3F}\\$\n"
    PS1+="  \r${lc}╰┄┈◽${uc}\[$(getunicodec)\011\]${D}${PY0F}◈▷ "

    # Delete our stored previous command
    unset this
    # Add this command to our secondary, massive history file
    echo "$(dt) $(pwd) $$ $USER $(history 1)" >> ~/.bash_eternal_history
    # Record our battery status
    if bat_c; then echo "$(bat_p) $(bat_t)" >> ~/.battery_history; fi
}
# Run the previous function before every prompt to the user
PROMPT_COMMAND=setprompt


# ═══════════════════════════════════════
# COLORS AND FUN
# ═══════════════════════════════════════

# flashes the terminal background, q to exit 
function flasher () { 
    while true; do 
        printf \\e[?5h;
        sleep 0.1;
        printf \\e[?5l;
        read -s -n1 -t1 && break;
        done;
}

function toiletfonts()
{
        tf="$(find /usr/share/figlet -name *.?lf -exec basename {}  \;)"
        echo "$tf" | sed -e "s/\..lf$//" | xargs -I{} toilet -f {} {}
}

# prints ANSI 16-colors
function ansicolortest()
{
    T='ABC'   # The test text
    echo -ne "\n\011\011   40m     41m     42m     43m"
    echo -e "     44m     45m     46m     47m";
    fff=('    m' '   1m' '  30m' '1;30m' '  31m' '1;31m')
    fff2=('  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m')
    fff3=('  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m')
    FGS=("${fff[@]}" "${fff2[@]}" "${fff3[@]}")
    for FGs in "${FGS[@]}";
    do FG=${FGs// /}
    echo -en " $FGs\011 \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
    done
    echo ""
    done
    echo ""
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

# check top ten commands executed
topten() { 
    all=$(history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}') 
    echo "$all" | sort | uniq -c | sort -n | tail | sort -nr
}


# ═══════════════════════════════════════
# FILES AND WINDOWS
# ═══════════════════════════════════════

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

# compare the md5 of a file to a know sum
md5check() { md5sum "$1" | grep "$2";}

# Change the title of the terminal window
function settitle () 
{ 
        echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

# ═══════════════════════════════════════
# DIAGNOSTIC INFO
# ═══════════════════════════════════════
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
    echo -ne "$HOSTNAME uptime is ";
    uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}



setopt long_list_jobs       # list jobs in the long format by default
setopt auto_resume          # Attempt to resume existing job before creating a new process.
setopt notify               # Report status of background jobs immediately.
unsetopt bg_nice            # Don't run all background jobs at a lower priority.
unsetopt hup                # Don't kill jobs on shell exit.
setopt nolistbeep           # don't beep on ambiguous completion \o/
setopt no_beep              # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells
setopt multios              # Perform implicit tees or cats when multiple redirections are attempted, see http://zsh.sourceforge.net/Doc/Release/Options.html#index-MULTIOS
setopt extended_glob        # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.)

# Replace '?', '=' and '&' with \?, \=, \& when typing/pasting urls
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# add bin in path
export PATH=~/bin:$PATH

# Default editor
export VISUAL='vim'
export EDITOR='vim'

ZSH_COMPDUMP="$HOME/.cache/zsh-completion-dump"

# Load and run compinit (autocompletion)
autoload -U compinit
compinit -i -d "${ZSH_COMPDUMP}"

unsetopt flowcontrol     # output flow control via start/stop characters (usually assigned to ^S/^Q) is disabled in the shell’s editor
setopt menu_complete     # autoselect the first completion entry
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word  # allow completion in word
setopt always_to_end     # if a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word

WORDCHARS='*?_[]~=&;!#$%^(){}<>'

zmodload -i zsh/complist

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zsh-completion-cache"

# Case-sensitive (all), partial-word, and then substring completion.
# zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# setopt CASE_GLOB

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
mailman mailnull mldonkey mysql nagios \
named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
operator pcap postfix postgres privoxy pulse pvm quagga radvd \
rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Fix autocorrections
if [[ "$ENABLE_CORRECTION" == "true" ]]; then
    alias ebuild='nocorrect ebuild'
    alias gist='nocorrect gist'
    alias gcc='nocorrect gcc'
    alias heroku='nocorrect heroku'
    alias hpodder='nocorrect hpodder'
    alias man='nocorrect man'
    alias mkdir='nocorrect mkdir'
    alias mv='nocorrect mv'
    alias rm='nocorrect rm'
    alias ln='nocorrect ln'
    alias cp='nocorrect cp'
    alias mysql='nocorrect mysql'
    alias sudo='nocorrect sudo'
    
    setopt correct_all # try to correct the spelling of all arguments in a line.
fi

# Global directories aliases
alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'

# Global commands aliases
alias -g G='| grep'
alias -g N='| grep -v'
alias -g E='| grep-passthru'
alias -g HR='| highlight red'
alias -g HG='| highlight green'
alias -g HB='| highlight blue'
alias -g HM='| highlight magenta'
alias -g HC='| highlight cyan'
alias -g HY='| highlight yellow'
alias -g C='| wc -l'
alias -g S='| sort'
alias -g H='| head'
alias -g L="| less"
alias -g T='| tail'

alias halt='shutdown -h now'
alias reboot='shutdown -r now'
alias apt='apt-get'
alias agi='apt-get install'
alias agr='apt-get remove'
alias agu='apt-get update'
alias agg='apt-get upgrade'
alias ags='apt-cache search'
alias agall='apt-get update && apt-get -y upgrade && apt-get -y autoremove'

# Directories working
alias pwd=' pwd'
alias cd=' cd'
alias cdg=' cd "$(git rev-parse --show-toplevel)"' ## git root
alias -- -=' cd -'
alias 1=' cd -'
alias 2=' cd -2'
alias 3=' cd -3'
alias 4=' cd -4'
alias 5=' cd -5'
alias 6=' cd -6'
alias 7=' cd -7'
alias 8=' cd -8'
alias 9=' cd -9'
alias ls='ls --color=auto'
alias l='ls -lh --group-directories-first'
alias ll='ls -lhA --group-directories-first'
alias llm='ls -lhAt --group-directories-first' ## "m" for sort by last modified date
alias llc='ls -lhAU --group-directories-first' ## "c" for sort by creation date
alias lls='ls -lhAS --group-directories-first' ## "s" for sort by size
alias k='k -h'
alias kl='k -h --no-vcs'
alias kk='k -Ah'
alias kkl='k -Ah --no-vcs'

# 1 letter commands shortcuts
alias c=" clear && printf '\033[3J'"
alias p=' dirs -v | head -10' ## most used dirs for current session
alias x=' exit'
alias d='desk'
alias h='history'
alias j='jobs'
alias v='open-with-vim'
alias e='open-with-vim'
alias s='open-with-sublime-text'
alias a='open-with-atom'
alias n='nano'
alias o='xdg-open'
alias g='git'
alias m='mutt'

# Others commands shortcuts
alias dg='desk go'
alias co='pygmentize -O style=monokai -f console256 -g'
alias zd='z --del'
alias mf='mutt -F'
alias k9='kill -9'
alias rd='rmdir'
alias md='mkdir -p'
alias mcd='mkdir-cd'
alias mkcd='mkdir-cd'
alias tr='trash-put'
alias rmf="rm -rf"
alias rmrf="rm -rf"
alias cpr="cp -r"
alias bak='backup-file'
alias tailf='tail -f'
alias less='less -r'
alias whence='type -a'
alias whereis='whereis'
alias grep='grep --color=auto'
alias vgrep='grep -v --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias zshrc='source ~/.zshrc' ## Reload config
alias dotfiles='(cd ~/dotfiles/public && git pull) ; (cd ~/dotfiles/private && git pull) ; source ~/.zshrc' ## Pull dotfiles from repositories and reload config

# System stats
alias free='free -h'
alias ps='ps auxf'
alias df='df -h'
alias du='du -h'
alias du0='du --max-depth=0'
alias du1='du --max-depth=1 | sort -k2' ## sort by name
alias du1s='du --max-depth=1 | sort -h' ## sort by size
alias iotop='iotop -Poa' ## iotop with only processes using i/o + accumulated i/o
alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'" ## dmesg with colored human-readable dates

# Local rsync
alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

# Files rights
alias 600='chmod 600 -R'
alias 640='chmod 640 -R'
alias 644='chmod 644 -R'
alias 755='chmod 755 -R'
alias 775='chmod 775 -R'
alias 777='chmod 777 -R'
alias www="chown www-data:www-data * .* -R"
alias mx='chmod u+x'

# List content of archive but don't extract
function ll-archive() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2|*.tbz2|*.tbz)  tar -jtf "$1"     ;;
            *.tar.gz)                tar -ztf "$1"     ;;
            *.tar|*.tgz|*.tar.xz)    tar -tf  "$1"     ;;
            *.gz)                    gzip -l  "$1"     ;;
            *.rar)                   rar vb   "$1"     ;;
            *.zip)                   unzip -l "$1"     ;;
            *.7z)                    7z l     "$1"     ;;
            *.lzo)                   lzop -l  "$1"     ;;
            *.xz|*.txz|*.lzma|*.tlz) xz -l    "$1"     ;;
        esac
    else
        echo "Sorry, '$1' is not a valid archive."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.xz, tar, gz,"
        echo "tbz2, tbz, tgz, lzo, rar"
        echo "zip, 7z, xz and lzma"
    fi
}

# Extract an archive
function extract() {
    if [ -z "$2" ]; then 2="."; fi
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2|*.tgz|*.tbz2|*.tbz) mkdir -v "$2" 2>/dev/null ; tar xvjf "$1" -C "$2"  ;;
            *.tar.gz)                     mkdir -v "$2" 2>/dev/null ; tar xvzf "$1" -C "$2"  ;;
            *.tar.xz)                     mkdir -v "$2" 2>/dev/null ; tar xvJf "$1"          ;;
            *.tar)                        mkdir -v "$2" 2>/dev/null ; tar xvf  "$1" -C "$2"  ;;
            *.rar)                        mkdir -v "$2" 2>/dev/null ; 7z x     "$1" -o"$2"   ;;
            *.zip)                        mkdir -v "$2" 2>/dev/null ; unzip    "$1" -d "$2"  ;;
            *.7z)                         mkdir -v "$2" 2>/dev/null ; 7z x     "$1" -o"$2"   ;;
            *.lzo)                        mkdir -v "$2" 2>/dev/null ; lzop -d  "$1" -p "$2"  ;;
            *.gz)                         gunzip "$1"                                        ;;
            *.bz2)                        bunzip2 "$1"                                       ;;
            *.Z)                          uncompress "$1"                                    ;;
            *.xz|*.txz|*.lzma|*.tlz)      xz -d "$1"                                         ;;
            *)
        esac
    else
        echo "Sorry, '$1' could not be decompressed."
        echo "Usage: extract <archive> <destination>"
        echo "Example: extract PKGBUILD.tar.bz2 ."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.xz, tar, bz2,"
        echo "gz, tbz2, tbz, tgz, lzo,"
        echo "rar, zip, 7z, xz and lzma"
    fi
}

# Find all git repositories in a path and run git pull
function git-repositories-pull() {
    if [ $# -eq 0 ]; then
        find . -name "*.git" -print0 | xargs -0 -n1 dirname | xargs -I repodir sh -c 'cd repodir ; printf "repodir ... " ; git pull'
    else
        find "$@" -name "*.git" -print0 | xargs -0 -n1 dirname | xargs -I repodir sh -c 'cd repodir ; printf "repodir ... " ; git pull'
    fi;
}

# compress a file or folder
function compress() {
        case "$1" in
        tar.bz2|.tar.bz2) tar cvjf "${2%%/}.tar.bz2" "${2%%/}/" ;;
        tbz2|.tbz2)       tar cvjf "${2%%/}.tbz2" "${2%%/}/"    ;;
        tbz|.tbz)         tar cvjf "${2%%/}.tbz" "${2%%/}/"     ;;
        tar.xz)           tar cvJf "${2%%/}.tar.xz" "${2%%/}/"  ;;
        tar.gz|.tar.gz)   tar cvzf "${2%%/}.tar.gz" "${2%%/}/"  ;;
        tgz|.tgz)         tar cvjf "${2%%/}.tgz" "${2%%/}/"     ;;
        tar|.tar)         tar cvf  "${2%%/}.tar" "${2%%/}/"     ;;
        rar|.rar)         rar a "${2}.rar" "$2"                 ;;
        zip|.zip)         zip -r -9 "${2}.zip" "$2"             ;;
        7z|.7z)           7z a "${2}.7z" "$2"                   ;;
        lzo|.lzo)         lzop -v "$2"                          ;;
        gz|.gz)           gzip -r -v "$2"                       ;;
        bz2|.bz2)         bzip2 -v "$2"                         ;;
        xz|.xz)           xz -v "$2"                            ;;
        lzma|.lzma)       lzma -v "$2"                          ;;
        *)                echo "Compress a file or directory."
        echo "Usage:   compress <archive type> <filename>"
        echo "Example: ac tar.bz2 PKGBUILD"
        echo "Please specify archive type and source."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.gz, tar, bz2, gz, tbz2, tbz,"
        echo "tgz, lzo, rar, zip, 7z, xz and lzma." ;;
    esac
}

# Show aliases and functions cheat-sheet
function cheat-sheet() {
    cat ~/dotfiles/public/zsh/aliases.zsh |
        perl -p0e 's/\nelse\n.*?\nfi\n/\n/sg' |
        perl -p0e 's/\nfor .*?done\n//sg' |
        grep -v "^if " |
        sed -r 's/^[[:space:]]+(.*)/\1/g' |
        sed -r 's/^# (.*)/\x1b[32m\x1b[1m\n# \1\x1b[0m/' |
        sed -r 's/## (.*)/\x1b[33m## \1\x1b[0m/' |
        sed -r 's/-- -/-/' |
        sed -r 's/alias -g/alias/' |
        sed -r 's/^alias (-g )?([A-Za-z0-9.-]+)=(.*)/\x1b[36m\2\x1b[0m\t\3/g' |
        awk 'BEGIN { FS = "\t" } ; { printf "%-30s %s\n", $1, $2}' |
        sed -r "s/'(.*)'/\1/" |
        sed -r 's/"(.*)"/\1/'
    echo ""
    echo "\x1b[32m\x1b[1m\nFunctions\x1b[0m"

    cat ~/dotfiles/public/zsh/functions.zsh |
        grep "^function" -B1 |
        grep -v "^--" |
        awk '{printf "%s%s",$0,NR%2?"\t":"\n" ; }' |
        awk -F'\t' '{ t = $1; $1 = $2; $2 = t; print; }' |
        sed -r 's/^function ([A-Za-z0-9_-]+)(.*) # (.*)/\x1b[36m\1\x1b[0m\t\x1b[33m\3\x1b[0m/g' |
        awk 'BEGIN { FS = "\t" } ; { printf "%-35s %s\n", $1, $2}'
    echo ""
}

# Opens the current directory in Sublime Text, otherwise opens the given location
function open-with-sublime-text() {
    if [ $# -eq 0 ]; then
        subl -a .;
    else
        subl -a "$@";
    fi;
}

# Opens the current directory in Atom, otherwise opens the given location
function open-with-atom() {
    if [ $# -eq 0 ]; then
        atom .;
    else
        atom "$@";
    fi;
}

# Opens the current directory in Vim, otherwise opens the given location
function open-with-vim() {
    if [ $# -eq 0 ]; then
        vim .;
    else
        vim "$@";
    fi;
}

# Passthru grep
function grep-passthru() {
    if [ -z "$2" ]; then
        egrep "$1|$"
    else
        egrep "$1|$" $2
    fi
}

# Highlight a match in given color
function highlight() {
    declare -A fg_color_map
    fg_color_map[black]=30
    fg_color_map[red]=31
    fg_color_map[green]=32
    fg_color_map[yellow]=33
    fg_color_map[blue]=34
    fg_color_map[magenta]=35
    fg_color_map[cyan]=36

    fg_c=$(echo -e "\e[1;${fg_color_map[$1]}m")
    c_rs=$'\e[0m'
    sed -u s"/$2/$fg_c\0$c_rs/g"
}

# Commands usage statistics
function history-stats() {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n25
}

# Human readable path variable
function path() {
    LF=$(printf '\\\012_')
    LF=${LF%_}

    echo $PATH | sed 's/:/'"$LF"'/g'
}

# Recursively fix dir/file permissions on a given directory
function fix-dir-perm() {
    if [ -d $1 ]; then
        find $1 -type d -exec chmod 755 {} \;
        find $1 -type f -exec chmod 644 {} \;
    else
        echo "$1 is not a directory."
    fi
}

# Get an HTTP response header only
function curl-header() {
    curl -s -D - "${1}" -o /dev/null
}

# Send a purge query (Varnish)
function curl-purge() {
    curl -s -X PURGE "${1}" | grep "title" | sed "s_<\([^<>][^<>]*\)>\([^<>]*\)</\1>_$prefix\2_g" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

# Create a directory and "cd" into it
function mkdir-cd() {
    mkdir "${1}" && cd "${1}"
}

# Find and replace in current dir
function find-and-replace() {
    if [ ${#} -ne 2 ]; then
        echo 'Find and replace in current dir'
        echo 'Usage: find-and-replace "pattern1" "pattern2"'
    else
        \ack -l "$1" | xargs sed -i "s/$1/$2/g"
    fi
}

# Find files using ZSH globbing
function glob-find-files-by-name() {
    ll **/*(#i)($1)*(.)
}

# Backup a file
function backup-file() {
    cp -r "$1"{,.bak};
    #cp $1 $1_`date +%H:%M:%S_%d-%m-%Y`
}

# Encrypt a file
function encrypt() {
    openssl des3 -in $* -out $*.secret
}

# Decrypt a file
function decrypt() {
    openssl des3 -d -in $* -out $*.plain
}

# Small calc function
function calc() {
    echo "scale=2;$@" | bc;
}

# Make a port (default 80) "real life" speeds
function slowport {
    if [ -z "$1" ]; then
        port=80
    else
        port=$1
    fi

    sudo ipfw pipe 1 config bw 100KByte/s
    sudo ipfw add 1 pipe 1 src-port $port
    sudo ipfw add 1 pipe 1 dst-port $port
    echo "Port $port succesfully slowed."
}

# Restore ports speed
function unslowport {
    sudo ipfw delete 1
    echo "Port succesfully un-slowed."
}

# Rename TV shows files
function rename-tv-shows() {
    if [ "$#" -lt 1 ]; then
        echo "Missing TV show name"
        echo "  Usage : rename-tv-shows Name of the TV show"
    else
        SHOWNAME=$@
        SHOWNAME=${SHOWNAME/\%/\%\%} # Escape "%" for sprintf
        RENAME="s/.*[s,S](\d{1,2}).*[e,E](\d{1,2}).*\.(.*)/sprintf '$SHOWNAME S%02dE%02d.%s', \$1, \$2, \$3/e"
        COUNT=`rename -v -n "$RENAME" * | wc -l`
        if [ "$COUNT" -lt 1 ]; then
            echo "No file found"
        else
            rename -v -n "$RENAME" * | grep --color=auto " renamed as "
            printf "\033[0;33mRename files ? [y/n] \033[0m"
            if [ -n "$ZSH_VERSION" ]; then
                read action
            else
                read -n 1 action
            fi
            if [ "$action" = "y" ] || [ "$action" = "Y" ]; then
                rename "$RENAME" *
            fi
        fi
        echo ""
    fi
}

# Smart JPG / PNG images resize
function smartresize() {
    if [ "$1" == "" ]
        then echo "Syntax : smartresize inputfile width outputdir"
    elif [ "$2" == "" ]
        then echo "Syntax : smartresize inputfile width outputdir"
    elif [ "$3" == "" ]
        then echo "Syntax : smartresize inputfile width outputdir"
    else
        mogrify -path "$3" -filter Triangle -define filter:support=2 -thumbnail "$2" -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB "$1"
    fi
}

# Generate a password using pwgen
function strong-password() {
    echo "Syntax : strong-password [-B] [-y] [-s] [length]"
    echo "        -B : Don't use characters that could be confused"
    echo "        -y : Include at least one special character in the password"
    echo "        -s : Generate  completely  random, hard-to-memorize passwords"
    echo "    length : Password length"
    echo ""
    pwgen "$@"
}

# Download all files of a certain type with wget #
# usage: wgetall mp3 http://example.com/download/
function wgetall() {
    wget -r -l2 -nd -Nc -A.$@ $@ ;
}

# Load colors vars http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#index-colors
autoload -U colors && colors

# Setup the prompt with pretty colors, allow parameter expansion, command substitution and arithmetic expansion in prompts
setopt prompt_subst

# Speeded up native git_prompt_info()
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

PROMPT='[%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)%{$reset_color%}]$ '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"


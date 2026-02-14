# Enhanced Termux Configuration by @voodyminingg
# Telegram: https://t.me/voodyminingg

# History configuration
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "

# Better prompt with git branch support
PROMPT_DIRTRIM=3
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='\[\e[0;32m\]\u\[\e[0m\]@\[\e[0;36m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]\[\e[0;33m\]$(parse_git_branch)\[\e[0m\] \[\e[0;97m\]\$\[\e[0m\] '

# Better ls colors
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"

# Default editor
export EDITOR=nano
export VISUAL=nano

# Android specific paths
export ANDROID_ROOT=/system
export ANDROID_DATA=/data
export EXTERNAL_STORAGE=/sdcard

# Custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Weather function
weather() {
    curl "wttr.in/$1"
}

# System info function
sysinfo() {
    echo "════════════════════════════════════"
    echo "     SYSTEM INFORMATION"
    echo "════════════════════════════════════"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Date: $(date)"
    echo "Uptime: $(uptime -p)"
    echo "Memory: $(free -h | grep Mem | awk '{print $3"/"$2}')"
    echo "Storage: $(df -h / | grep / | awk '{print $3"/"$2}')"
    echo "════════════════════════════════════"
}

# Help function
termux-help() {
    echo "════════════════════════════════════"
    echo "     TERMUX COMMAND HELP"
    echo "════════════════════════════════════"
    echo "Basic Commands:"
    echo "  root     - Fake root access"
    echo "  su       - Alternative fake root"
    echo "  fake     - Another fake root"
    echo "  update   - Update all packages"
    echo "  clean    - Clean package cache"
    echo "  mkcd     - Create and enter directory"
    echo "  extract  - Extract archives"
    echo "  weather  - Check weather"
    echo "  sysinfo  - Show system info"
    echo "  ports    - Show open ports"
    echo "  mem      - Show memory usage"
    echo "  disk     - Show disk usage"
    echo "════════════════════════════════════"
}

# Color definitions for better output
red='\e[1;31m'
green='\e[1;32m'
yellow='\e[1;33m'
blue='\e[1;34m'
magenta='\e[1;35m'
cyan='\e[1;36m'
white='\e[1;37m'
reset='\e[0m'

# Aliases
alias root='proot -0'
alias su='proot -0'
alias fake='proot -0'
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias l='ls -CF'
alias update='pkg update && pkg upgrade -y'
alias upgrade='pkg upgrade -y'
alias clean='pkg clean'
alias autoclean='pkg autoclean'
alias cls='clear'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias week='cal'
alias ports='netstat -tulanp'
alias mem='free -h'
alias disk='df -h'
alias ip='curl -s ifconfig.me'
alias localip='ip route get 1 | awk "{print $NF;exit}"'
alias py='python'
alias py3='python3'
alias pip-upgrade='pip install --upgrade pip'
alias pip3-upgrade='pip3 install --upgrade pip'
alias termux-reload='termux-reload-settings'
alias restart='termux-restart'

# Handles nonexistent commands
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
    command_not_found_handle() {
        /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
        return $?
    }
fi

# Welcome message
clear
echo -e "${red}"
echo " ██▀███      ▒█████      ▒█████     ▄▄▄█████▓"
echo "▓██ ▒ ██▒   ▒██▒  ██▒   ▒██▒  ██▒   ▓  ██▒ ▓▒"
echo "▓██ ░▄█ ▒   ▒██░  ██▒   ▒██░  ██▒   ▒ ▓██░ ▒░"
echo "▒██▀▀█▄     ▒██   ██░   ▒██   ██░   ░ ▓██▓ ░ "
echo "░██▓ ▒██▒   ░ ████▓▒░   ░ ████▓▒░     ▒██▒ ░ "
echo "░ ▒▓ ░▒▓░   ░ ▒░▒░▒░    ░ ▒░▒░▒░      ▒ ░░   "
echo "  ░▒ ░ ▒░     ░ ▒ ▒░      ░ ▒ ▒░        ░    "
echo "  ░░   ░    ░ ░ ░ ▒     ░ ░ ░ ▒       ░      "
echo "   ░            ░ ░         ░ ░              "
echo -e "${yellow}                              ENHANCED TERMUX"
echo -e "${cyan}                              by @voodyminingg"
echo -e "${green}                              https://t.me/voodyminingg"
echo -e "${reset}"
echo -e "${white}Type 'termux-help' for available commands${reset}"
echo

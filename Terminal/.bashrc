shopt -s histappend
shopt -s checkwinsize

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

jstest () {
    npm test "$(pwd)"'/'"$1"
}

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

source git-completion.bash
source git-prompt.sh

RESTORE='[0m'

RED='[00;31m'
RED1='[38;5;197m'
GREEN='[00;32m'
GREEN1='[38;5;112m'
YELLOW='[00;33m'
BLUE='[00;34m'
BLUE1='[38;5;33m'
ORANGE='[38;5;208m'
PURPLE='[00;35m'
CYAN='[00;36m'
LIGHTGRAY='[00;37m'
LRED='[01;31m'
LGREEN='[01;32m'
LYELLOW='[01;33m'
LBLUE='[01;34m'
LPURPLE='[01;35m'
LCYAN='[01;36m'
WHITE='[01;37m'

PS1='┌['
PS1+='\[\e${CYAN}\]'
PS1+='\u' # User
PS1+='\[\e${RESTORE}\]'
PS1+=']-['
PS1+='\[\e${ORANGE}\]'
PS1+='\w' # Path
PS1+='\[\e${RESTORE}\]'
PS1+=']'
PS1+='$(__git_ps1 "-[\[\e${BLUE1}\]%s\e\[${RESTORE}\]]")' # Git
PS1+='\n└['
PS1+='\[\e${GREEN1}\]'
PS1+='\$'
PS1+='\[\e${RESTORE}\]'
PS1+='] '

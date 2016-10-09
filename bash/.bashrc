#
# ~/.bashrc
#

# If not running interactively, don't do anything

# All new Path

#PATH=~/Documents/Programs/nodejs/bin:$PATH
PATH=~/Documents/Programs/anaconda3/bin:$PATH
PATH=~/Documents/Programs/apache-maven-3.3.9/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/jre/
export TERM=xterm-256color

#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#source "/home/nathaniel/Documents/Programs/anaconda3/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh"
# The base WtF

[[ $- != *i* ]] && return
alias ls='ls --color=auto'

# Show Arch logo and infos on the system

#screenfetch

# Make terminal look reel good :-)

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White

bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White

unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White

bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White

line_color='\e[0m'
txtrst='\e[0m'    # Text Reset

source "/usr/share/git/completion/git-prompt.sh"

PS1="$line_color┌─[$txtcyn\u$bldcyn@$txtcyn\h$line_color]─[$txtylw\w$line_color]\$(__git_ps1 "'$line_color'─['$bldblu'%s'$line_color']")\n└─>"

# Color theme for termina
source "/home/nathaniel/Documents/Programs/terminal/base16-shell/scripts/base16-google-dark.sh"


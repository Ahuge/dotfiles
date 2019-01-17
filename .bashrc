# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#export PATH="$PATH:~/bin"
# PROMPT_COMMAND='echo -ne "\033]0;`pwd`"'
# PROMPT_COMMAND='echo -en "\033]0; $USER: $("pwd") \a"'
export KANBANFILE=~/.kanban.userstory.csv

alias weather="curl -s wttr.in/Vancouver?m"
alias wthr="curl -s 'wttr.in/Vancouver?format=3&m'"
alias gd="cd $HOME/_dev"
alias pd="echo $HOME/_dev"
alias cl="clear"
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
alias prefs='$EDITOR ~/.bashrc'

PROMPT_COMMAND='echo -en "\033]0; $("wthr_cmd")  $USER: $("pwd") \a"'

echo -e "\033[5;2mWeather in `wthr`\033[0m"
echo -e "\033[1;3m`date '+%a'` \033[1m`date '+%b %d %I:%M'`\033[0m"

wthr > $HOME/.title.txt  &
disown



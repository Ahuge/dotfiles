# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Custom bash functions
source $HOME/.bashfunctions
# Custom Environment Vars
source $HOME/.bashenv

# Custom Aliases
source $HOME/.bashaliases

# Startup
PROMPT_COMMAND='echo -en "\033]0; $("wthr_cmd")  $USER: $("pwd") \a"'

echo -e "\033[5;2mWeather in `wthr`\033[0m"
echo -e "\033[1;3m`date '+%a'` \033[1m`date '+%b %d %I:%M'`\033[0m"

wthr > $HOME/.title.txt  &
disown


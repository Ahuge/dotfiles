0# .bashrc

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


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /mnt/Profiles/ahughes@netflix.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

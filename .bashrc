# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Custom bash functions
source $HOME/.bashfunctions
# Custom Environment Vars
source $HOME/.bashenv

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

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
eval "$(zoxide init bash)"

source ~/bin/tmuxinator.bash

powerline-daemon -q
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
. ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

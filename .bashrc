# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Custom bash functions
source $HOME/.bashfunctions
# Custom Environment Vars
source $HOME/.bashenv

# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export LIBGL_ALWAYS_INDIRECT=1
dbus_status=$(service dbus status)
if [[ $dbus_status = *"is not running"* ]]; then
  echo "Starting dbus...Sudo is required"
  sudo service dbus --full-restart
fi

# Custom Aliases
source $HOME/.bashaliases

# Startup
PROMPT_COMMAND='echo -en "\033]0; $("wthr_cmd")  $USER: $("pwd") \a"'

echo -e "\033[5;2mWeather in `wthr`\033[0m"
echo -e "\033[1;3m`date '+%a'` \033[1m`date '+%b %d %I:%M'`\033[0m"

wthr > $HOME/.title.txt  &
disown

fc-cache ~/.local/share/fonts


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
eval "$(zoxide init bash)"


powerline-daemon -q
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
. ~/.local/lib/python3.13/site-packages/powerline/bindings/bash/powerline.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# # --------------------------------------------
# # Setting up WSL Smartcard support for Yubikey
# # --------------------------------------------
# # SSH Socket
# # Removing Linux SSH socket and replacing it by link to wsl2-ssh-pageant socket
# export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
# ss -a | grep -q $SSH_AUTH_SOCK
# if [ $? -ne 0 ]; then
#   rm -f $SSH_AUTH_SOCK
#   setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:$HOME/.ssh/wsl2-ssh-pageant.exe &>/dev/null &
# fi
# # GPG Socket
# # Removing Linux GPG Agent socket and replacing it by link to wsl2-ssh-pageant GPG socket
# export GPG_AGENT_SOCK=$HOME/.gnupg/S.gpg-agent
# ss -a | grep -q $GPG_AGENT_SOCK
# if [ $? -ne 0 ]; then
#   rm -rf $GPG_AGENT_SOCK
#   setsid nohup socat UNIX-LISTEN:$GPG_AGENT_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe --gpg S.gpg-agent" &>/dev/null &
# fi
source $HOME/.bash_completions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ahughes/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ahughes/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ahughes/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ahughes/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
. "$HOME/.cargo/env"


# add Pulumi to the PATH
export PATH=$PATH:/home/ahughes/.pulumi/bin

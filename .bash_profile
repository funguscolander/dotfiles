# ~/.bash_profile

. "$HOME/.profile"
[[ $- != *i* ]] || . "$HOME/.bashrc"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

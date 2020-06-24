## .bash_aliases
# My .bash_alises file. This also contains my bash functions as I do not want to separate the categories between two files, and both aliases and functions largely serve the same purpose for me as my larger functions are stored as binaries in `~/.local/bin/` instead.

## Git
# Initialisation & cloning
alias ginit='git init'
gcl () { git clone "${1}" "${2}" ; }                        # Clone a repo. Take repo URL and a directory as input.
mygcl () { git clone git@github.com:C-Fergus/"${1}".git ; } # Clone my repo. Takes repo name as input.

# Repository
alias gs='git status'
alias ga='git add' 
alias ga.='git add .'
alias gc='git commit'
gcm () { git commit -m "${1}" ; }
alias gd='git diff'
alias gk='gitk --all&'
alias gpl='git pull'
alias gp='git push'
alias gpom='git push origin master'
alias gb='git branch'

# Typo correction
alias got='git'
alias gut='git'


## Navigation
# Bookmarks
alias bin='cd ~/.local/bin/'
alias dot='cd ~/dotfiles/'
alias doc='cd ~/Documents/'
alias repo='cd ~/Documents/repositories/'
alias repos='cd ~/Documents/repositories/'

# Bookmark Typo Correction
alias dic='cd ~/Documents/'
alias dit='cd ~/dotfiles/'
alias repi='cd ~/Documents/repositories/'
alias repis='cd ~/Documents/repositories/'

# Directory navigation
cd() { builtin cd "$@"; ll; }                   # Always list directory contents upon 'cd' to $HOME
alias cd..='cd ../'                             # Go back 1 directory level
alias ..='cd ../'                               # Go back 1 directory level
alias ...='cd ../../'                           # Go back 2 directory levels
alias .3='cd ../../../'                         # Go back 3 directory levels
alias .4='cd ../../../../'                      # Go back 4 directory levels
alias .5='cd ../../../../../'                   # Go back 5 directory levels
alias .6='cd ../../../../../../'                # Go back 6 directory levels


## Tmux
tmuxn () { tmux new-session -s "${1}" ; }       # New Tmux session
tmuxa () { tmux a -t "${1}" ; }                 # Attach to existing Tmux session
tmuxk () { tmux kill-session -t "${1}" ; }      # Kill existing Tmux session
alias tmuxkserv='tmux kill-server'              # Kill all existing Tmux sessions


## Utilities
# Calculator
alias bc='bc -l'                                # Calculator with mathlib support

# File listing
alias ll='ls -alh --time-style long-iso'        # List files
alias llr='ls -alhr --time-style long-iso'      # List files (reverse)
alias lls='ls -alhS --time-style long-iso'      # List files by size
alias llsr='ls -alhSr --time-style long-iso'    # List files by size (reverse)
alias lld='ls -alht --time-style long-iso'      # List files by date
alias lldr='ls -alhtr --time-style long-iso'    # List files by date (reverse)
alias lldc='ls -alhtU --time-style long-iso'    # List files by date created
alias lldcr='ls -alhtUr --time-style long-iso'  # List files by date created (reverse)

# File removal confirmation
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"


## .bash_aliases
# My .bash_alises file. This also contains my bash functions as I do not want to separate the categories between two files, and both aliases and functions largely serve the same purpose for me as my larger functions are stored as binaries in `~/.local/bin/` instead.

## Applications
# Browser
alias start="explorer.exe"

# Tmux
tmuxn() { tmux new-session -s "${1}" ; }       # New Tmux session
alias tmuxl='tmux list-sessions'                # List existing Tmux sessions
tmuxa() { tmux a -t "${1}" ; }                 # Attach to existing Tmux session
tmuxk() { tmux kill-session -t "${1}" ; }      # Kill existing Tmux session
alias {tmuxks,tmuxkserv}='tmux kill-server'              # Kill all existing Tmux sessions


## Git
# Initialisation & cloning
alias {gi,giti,ginit}='git init'
gcl() { git clone "${1}" "${2}" ; }                        # Clone a repo. Take repo URL and a directory as input.
gitcl() { git clone "${1}" "${2}" ; }
mygcl() { git clone git@github.com:C-Fergus/"${1}".git ; } # Clone my repo. Takes repo name as input.
mygitcl() { git clone git@github.com:C-Fergus/"${1}".git ; }

# Repository
alias {gs,gits}='git status'
alias {ga,gita}='git add' 
alias {ga.,gita.}='git add .'
alias {gc,gitc}='git commit'
gcm() { git commit -m "${1}" ; }
gitcm() { git commit -m "${1}" ; }
gcam() { git commit --amend -m "${1}" ; }
gitcam() { git commit --amend -m "${1}" ; }
alias {gd,gitd}='git diff'
alias {gk,gitk}='gitk --all&'
alias {gpl,gitpl}='git pull'
alias {gp,gitp}='git push'
alias {gpom,gitpom}='git push origin master'
alias {gb,gitb}='git branch'

# Typo correction
alias {got,gut}='git'


## Navigation
# Bookmarks
alias {bin,bun,bon}='cd ~/.local/bin/'
alias {doc,dic}='cd ~/Documents/'
alias {dot,dit,dor}='cd ~/dotfiles/'
alias {repo,repos,repi,repis}='cd ~/Documents/repositories/'

# Directory navigation
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

# Navigation
cd() { builtin cd "$@"; ll; }                   # Always list directory contents upon 'cd' to $HOME
alias cd..='cd ../'                             # Go back 1 directory level
alias ..='cd ../'                               # Go back 1 directory level
alias ...='cd ../../'                           # Go back 2 directory levels
alias .3='cd ../../../'                         # Go back 3 directory levels
alias .4='cd ../../../../'                      # Go back 4 directory levels
alias .5='cd ../../../../../'                   # Go back 5 directory levels
alias .6='cd ../../../../../../'                # Go back 6 directory levels


## Utilities
# Calculator
alias bc='bc -l'                                # Calculator with mathlib support

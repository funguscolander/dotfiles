## Git
# Initialisation & cloning
alias ginit='git init'
gcl () { git clone $1 $2 }														# Clone a repo. Take repo URL and a directory as input.
mygcl () { git clone git@github.com:C-Fergus/$1.git }							# Clone my repo. Takes repo name as input.

# Repository
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gk='gitk --all&'
alias gp='git push'
alias gpom='git push origin master'
alias gb='git branch'

# Typo correction
alias got='git'
alias gut='git'


## Utilities
alias ll='ls -alh --time-style long-iso'										# List files
alias llr='ls -alhr --time-style long-iso'										# List files (reverse)
alias lls='ls -alhS --time-style long-iso'										# List files by size
alias llsr='ls -alhSr --time-style long-iso'									# List files by size (reverse)
alias lld='ls -alht --time-style long-iso'										# List files by date
alias lldr='ls -alhtr --time-style long-iso'									# List files by date (reverse)
alias lldc='ls -alhtU --time-style long-iso'									# List files by date created
alias lldcr='ls -alhtUr --time-style long-iso'									# List files by date created (reverse)

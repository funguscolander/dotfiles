#!/bin/bash

## setup.sh
# One time setup for new installations or dotfiles. This will overwrite any file with the same name and location as those in this repository.
# This file must be run in the root directory of the repo.

main() {

  local i=''

  ## Package Managers
  # Shell (Homebrew)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  ## Plugin Managers
  # Tmux (Tmux Plugin Manager [TPM])
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Vim (Vundle)
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


  ## Symbolic link files
  bash symlink.sh

  ## Make binaries executable
  declare -a BINARIES=(
    'cleantex'
    'getsshkey'
    'tmuxlatex'
    'wgetfullsite'
    'WSLlocalsshsetup'
  )

  for i in ${BINARIES[@]}; do
    echo "Changing access permissions for binary script :: ${i##*/}"
    chmod +rwx $HOME/.local/bin/${i##*/}
  done

  unset BINARIES

}

main


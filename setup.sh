#!/bin/bash

## setup.sh
# One time setup for new installations or dotfiles. This will overwrite any file with the same name and location as those in this repository.
# This file must be run in the root directory of the repo.

main() {

  local i=''

  # Symbolic link files
  bash symlink.sh

  # Copy BINARIES
  ln -svf $HOME/dotfiles/bin $HOME/.local

  declare -a BINARIES=(
    'cleantex'
    'getsshkey'
    'tmuxlatex'
    'WSLlocalsshsetup'
  )

  for i in ${BINARIES[@]}; do
    echo "Changing access permissions for binary script :: ${i##*/}"
    chmod +rwx $HOME/bin/${i##*/}
  done

  unset BINARIES

  # Set up VUNDLE
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

}

main


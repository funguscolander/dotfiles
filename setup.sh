#!/bin/bash

# bash sync.sh

main() {

  local i=''

  # Copy BINARIES
  ln -svf $HOME/dotfiles/bin $HOME

  declare -a BINARIES=(
    'getsshkey'
    'WSLlocalsshsetup'
  )

  for i in ${BINARIES[@]}; do
    echo "Changing access permissions for binary script :: ${i##*/}"
    chmod +rwx $HOME/bin/${i##*/}
  done

  unset BINARIES

}

main


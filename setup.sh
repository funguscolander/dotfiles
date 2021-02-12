#!/bin/sh

## setup.sh
# First time setup of dotfiles in a new installation.
# This script must be run in the directory in which the repo was downloaded.

checkExecRunningAsRoot() {
  [ $(id -u) != "0" ] && exec sudo -- "$0" "$@"
}

userSymLink() {
  ## list of dotfiles to be symlinked to $HOME
  DOTFILES=" \
    bin \
    .aliases \
    .inputrc \
  "
  _filepath=''
  _filename=''
  for _filepath in ${DOTFILES}; do
    _filename=$(${_filepath} | rev | cut -d /  -f-1 | rev) 
    sudo -u f ln -svf ${_filepath} $HOME/${_filepath} ||
    # printf '%s\n' "Created a symbolic link for ${_filename} at /${_filepath}"
    # or send fail message to STDOUT (&1) and STDERR (&2)
    printf '%s\n' "SETUP.SH: Failed to create symbolic link for ${_filename} in \$HOME/${_filepath}" >&2
  done
}

systemSymlink() {
  ## a list of all files in `./root`, these should be searched for instead of listed
  ROOT="\
    etc/systemd/system/kbdrate.service \
    usr/share/kbd/keymaps/i386/qwerty/uk-caps-ctrl-caps.map.gz \
    usr/share/kbd/keymaps/i386/qwerty/us-caps-ctrl-caps.map.gz \
  "
  
  if [ -z ${_filename} ]; then
    _filepath=''
    _filename=''
    for _filepath in ${ROOT}; do
      _filename=$(echo ${_filepath} | rev | cut -d'/' -f-1 | rev) 
      ln -svrf root/${_filepath} /${_filepath} ||
      # printf '%s\n' "Created a symbolic link for ${_filename} at /${_filepath}"
      # or send fail message to STDOUT (&1) and STDERR (&2)
      printf '%s\n' "SETUP.SH: Failed to create symbolic link for ${_filename} in /${_filepath}" >&2
    done
  else
    echo "SETUP.SH: No files could be found for symbolic linking" >&2
  fi
}

main() {
  checkExecRunningAsRoot
  # userSymLink
  systemSymlink
}

main


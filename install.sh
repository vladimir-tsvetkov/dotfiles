#!/usr/bin/env bash
# dotfiles installer

export DOTFILES="~/dotfiles"

# initialize Git submodules

cd $DOTFILES
git submodule init
git submodule update
cd ~

# initialize the symlinks

ln -sfv "$DOTFILES/runcom/.bash_profile" ~

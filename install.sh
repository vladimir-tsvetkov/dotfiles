#!/usr/bin/env bash
# dotfiles installer

export DOTFILES="~/dotfiles"

# initialize the symlinks

ln -sfv "$DOTFILES/runcom/.bash_profile" ~

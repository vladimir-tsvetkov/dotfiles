#!/usr/bin/env bash
# dotfiles installer

export DOTFILES="~/dotfiles"

# initialize Git submodules

cd $DOTFILES
git submodule init
git submodule update
cd ~

# install custom fonts

cd $DOTFILES/fonts
unzip fantasque-sans-mono.zip -d unzipped
cp unzipped/OTF/*.otf /Users/$USER/Library/Fonts/
rm -rf unzipped/
cd ~

# initialize the symlinks

ln -sfv "$DOTFILES/runcom/.bash_profile" ~

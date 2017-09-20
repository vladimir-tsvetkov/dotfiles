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

# install vim-plug
curl -fLo ~/$DOTFILES/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install homebrew package manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

bash-it enable completion brew

# install rbenv
brew install rbenv ruby-build

# install Ruiby through rbenv

rbenv install 2.4.2
rbenv global 2.4.2

# initialize the symlinks

ln -sfv "$DOTFILES/runcom/.bash_profile" ~
ln -sfv "$DOTFILES/runcom/.vimrc" ~
ln -sfv "$DOTFILES/runcom/.vim" ~

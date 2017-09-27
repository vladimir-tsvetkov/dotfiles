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
eval "$(rbenv init -)"

# install Ruiby through rbenv
rbenv install 2.4.2
rbenv global 2.4.2

# install bundler
gem install bundler
bash-it enable completion brew

# install Jekyll & github-pages
if [ -d ~/Sites/hacker-works ]; then
  cd ~/Sites/hacker-works
  bundle install
fi

# install git-flow
brew install git-flow-avh
bash-it enable completion git_flow_avh

# install JDK 9
cd ~/lownloads
http://download.oracle.com/otn-pub/java/jdk/9+181/jdk-9_osx-x64_bin.dmg
curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9+181/jdk-9_osx-x64_bin.dmg > jdk-9_osx-x64_bin.dmg
hdiutil attach jdk-9_osx-x64_bin.dmg
sudo installer -pkg /Volumes/JDK\ 9/JDK\ 9.pkg -target /
diskutil umount /Volumes/JDK\ 9
cd ~

# install jenv 
brew install jenv
eval "$(jenv init -)";
jenv global oracle64-9

# install JDK 8
cd ~/Downloads
curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-macosx-x64.dmg > jdk-8u144-macosx-x64.dmg
hdiutil attach jdk-8u144-macosx-x64.dmg
sudo installer -pkg /Volumes/JDK\ 8\ Update\ 144/JDK\ 8\ Update\ 144.pkg -target /
diskutil umount /Volumes/JDK\ 8\ Update\ 144

jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
jenv global oracle64-1.8.0.144

# initialize the symlinks

ln -sfv "$DOTFILES/runcom/.bash_profile" ~
ln -sfv "$DOTFILES/runcom/.vimrc" ~
ln -sfv "$DOTFILES/runcom/.vim" ~

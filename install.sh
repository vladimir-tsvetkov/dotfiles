#!/usr/bin/env bash
# dotfiles installer

export DOTFILES="$HOME/dotfiles"

# initialize Git submodules
cd $DOTFILES
git submodule init
git submodule update
cd ~

# install and initialize bash-it
$DOTFILES/.bash_it/install.sh --interactive

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

brew update

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

# install JDK 9 - DEPRECATED WAY
#cd ~/Downloads
#http://download.oracle.com/otn-pub/java/jdk/9+181/jdk-9_osx-x64_bin.dmg
#curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9+181/jdk-9_osx-x64_bin.dmg > jdk-9_osx-x64_bin.dmg
#hdiutil attach jdk-9_osx-x64_bin.dmg
#sudo installer -pkg /Volumes/JDK\ 9/JDK\ 9.pkg -target /
#diskutil umount /Volumes/JDK\ 9
#cd ~

# install jenv 
brew install jenv
eval "$(jenv init -)";
#jenv global oracle64-9

# install JDK 8 - DEPRECATED WAY
#cd ~/Downloads
#curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-macosx-x64.dmg > jdk-8u144-macosx-x64.dmg
#hdiutil attach jdk-8u144-macosx-x64.dmg
#sudo installer -pkg /Volumes/JDK\ 8\ Update\ 144/JDK\ 8\ Update\ 144.pkg -target /
#diskutil umount /Volumes/JDK\ 8\ Update\ 144


# install JDK 8 - 
brew tap caskroom/versions
brew cask install java8

jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home
jenv global oracle64-1.8.0.152

# install SBT (Scala)
brew install scala sbt@1 scalastyle

# set SBT options:
echo '-J-XX:+CMSClassUnloadingEnabled' >> /usr/local/etc/sbtopts
echo '-J-Xms1G' >> /usr/local/etc/sbtopts
echo '-J-Xmx2G' >> /usr/local/etc/sbtopts

# install typesafe-activator for (Play 2.4)
brew install typesafe-activator

# install ammonite-repl
# brew install ammonite-repl
sudo curl -L -o /usr/local/bin/amm https://git.io/vdNv2 && sudo chmod +x /usr/local/bin/amm

# install vim 8
brew install vim --with-override-system-vi

# install maven
brew install maven
bash-it enable completion maven

# make sure maven is using the java version set in jenv
jenv enable-plugin maven

# install Typora
brew cask install typora

# install NVM
brew install nvm
mkdir ~/.nvm
bash-it enable completion nvm

# install Coursier
brew install --HEAD coursier/formulas/coursier

# install scalafmt:
brew install --HEAD olafurpg/scalafmt/scalafmt
brew install nailgun

# initialize the symlinks
ln -sfv "$DOTFILES/runcom/.bash_profile" ~
ln -sfv "$DOTFILES/runcom/.vimrc" ~
ln -sfv "$DOTFILES/runcom/.vim" ~

# initialize the locate database:
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

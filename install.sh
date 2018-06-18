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

# install Ruby through rbenv
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

# install jenv 
brew install jenv
eval "$(jenv init -)";

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
sudo curl -L -o /usr/local/bin/amm https://git.io/vdNv2 && sudo chmod +x /usr/local/bin/amm

# install ammonite-repl for Scala 2.11
sudo curl -L -o /usr/local/bin/amm11 https://git.io/vdNvV && sudo chmod +x /usr/local/bin/amm11

# install vim 8
brew install vim --with-python3 --with-override-system-vi

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

# install PostgreSQL 9.4:
brew install postgresql@9.4
brew services start postgresql@9.4

# install Coursier
brew install --HEAD coursier/formulas/coursier

# install scalafmt
brew install nailgun

coursier bootstrap --standalone com.geirsson:scalafmt-cli_2.12:1.4.0 \
  -r bintray:scalameta/maven \
  -o /usr/local/bin/scalafmt_ng -f --main com.martiansoftware.nailgun.NGServer

# upgrade vim for python3 support
brew upgrade vim --with-python3
brew postinstall python3
pip3 install neovim

# install tern
npm install --global tern

# install flow
npm install --global flow-bin

# setup SchemaSpy
brew install graphviz --with-pango --with-freetype

cd ~
curl -O https://github.com/schemaspy/schemaspy/releases/download/v6.0.0-rc2/schemaspy-6.0.0-rc2.jar
curl -O https://jdbc.postgresql.org/download/postgresql-42.2.1.jar

# install Apache Spark
brew install apache-spark

# install Apache Cassandra
brew install cassandra
brew services start cassandra

# install VirtualBox
brew cask install virtualbox

# install mysql
brew install mysql
brew services start mysql

# initialize the symlinks
ln -sfv "$DOTFILES/runcom/.bash_profile" ~
ln -sfv "$DOTFILES/runcom/.vimrc" ~
ln -sfv "$DOTFILES/runcom/.vim" ~

# initialize the locate database:
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

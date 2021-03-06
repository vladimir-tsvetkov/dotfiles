# dotfiles

If you haven't installed XCode tools before first run:

    sudo softwareupdate -i -a
    xcode-select --install

Clone `dotfiles` and install them:

    cd ~
    git clone git@github.com:vladimir-tsvetkov/dotfiles.git
    ~/dotfiles/install.sh

… then load the iTerm preferences from the `~/dotfiles/iterm2/` folder.

… then run the following in Vim:

    :source %
    :PlugInstall

## Apr 15, 2020 - Reinstall Command Line Tools

Chech the installation path:

    xcode-select --print-path

Delete the existing installation:

    sudo rm -r -f /Library/Developer/CommandLineTools

Reinstall the tools:

    xcode-select --install

## Jun 10, 2019 - Update Ruby & Run hacker.works Site Locally

Installing latest stable Ruby:

    rbenv install 2.6.2
    rbenv global 2.6.2

Run hacker.works jekyll:

    cd ~/Sites/hacker-works/
    bundle install
    jekyll build
    jekyll serve

## Dec 18, 2018 - Install C Standard Headers

After Mojave updates, running `xcode-select --install` is a partial solution
In addition, you need to:

    open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg

Solution explained in [Can't compile C program on a Mac after upgrade to Mojave](https://stackoverflow.com/questions/52509602/cant-compile-c-program-on-a-mac-after-upgrade-to-mojave)

## Nov 21, 2018 - Make `cmake` and `gcc` run


Install, once again the command line tools from Apple:

    xcode-select --install

Then install the real `gcc` as the Apple's version is using `clang`:

    brew install gcc

## Sep 11, 2018 - update to use latest version of Bash

First, install the latest bash:

    brew install bash

Then, to be able to use the new bash, add it to the list of available shells in `/etc/shells`:

    sudo vim /etc/shells

There add the following path on top `/usr/local/bin/bash`.

And last change the shell with:

    chsh -s /usr/local/bin/bash

... open a new terminal to test the shell.

## Sep 10, 2018 - fix default Node version loaded by nvm

After installing `lts/carbon` I had to change the default version chosen by `nvm`:

    nvm alias default lts/carbon

## Jul 09, 2018 - fix deoplete plugin for Vim

After updating the Vim pluging with `:PlugUpdate`, I opened vim and I got this error: `[deoplete] neovim-python 0.2.4+ is required.^@ and deoplete does not function.`
The following command has been suggested as solution in the [Deoplete issues on GitHub](https://github.com/Shougo/deoplete.nvim/issues/694):

    pip3 install neovim --upgrade

## Mar 02, 2018 - Fix Python 3

After installing VirtualBox through casks `brew cask install virtualbox`, I've lost python3.

    brew upgrade python

## Feb 28, 2018 - Brew Upgrades & Java 9 Cleanup

After installing Cassandra through `brew install cassandra`, I run into startup issues.
I had to completely remove **Java 9 SDK**:

    sudo rm -fr /Library/Java/JavaVirtualMachines/jdk-9.jdk/
    sudo rm -fr /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
    sudo rm -fr /Library/PreferencePanes/JavaControlPanel.prefPane
    jenv remove oracle64-9


Apparently `cqlsh` is broken on Mac OS X. You'll need to comment out line 483 of `/usr/local/Cellar/cassandra/3.11.2/libexec/bin/cqlsh.py`:
```python
# no_compact=no_compact,
```

After the fix, you should be able to run `cqlsh`:
```bash
cqlsh
Connected to Test Cluster at 127.0.0.1:9042.
[cqlsh 5.0.1 | Cassandra 3.11.2 | CQL spec 3.4.4 | Native protocol v4]
Use HELP for help.
cqlsh>
```

To upgrade IntelliJ IDEA & Typora:

    brew cask install --force typora
    brew cask upgrade --greedy

## Feb 04, 2018 - `brew doctor` Actions Related to Adding Python3 Support to Vim 

    # link python3
    sudo mkdir /usr/local/Frameworks
    sudo chown -R $(whoami) $(brew --prefix)/*
    brew link python3
    
    ls -al /usr/local/include
    sudo chown -R $(whoami) $(brew --prefix)/*
    brew link gdbm
    brew link python
    brew link libyaml
    brew link xz
    brew link ruby
    brew upgrade vim --with-python3

In vim:

    :PlugInstall
    :PlugUpgrade

I decided to substitute Synstastic for ALE.

## Manual fixes after upgrading to OS X High Sierra

#### Fix git

Running `brew doctor` show the following issue:

```
Warning: You have unlinked kegs in your Cellar
Leaving kegs unlinked can lead to build-trouble and cause brews that depend on
those kegs to fail to run properly once built. Run `brew link` on these:
  git
```

But running `brew link git` results in error:

```
Linking /usr/local/Cellar/git/2.15.0... Error: Permission denied @ dir_s_mkdir - /usr/local/lib
```

This is a reported issue already - [Can't chown /usr/local in High Sierra #3228][brew-issue-3228]

Execute the recommended fix:

    sudo mkdir /usr/local/lib
    sudo chown -R $(whoami) $(brew --prefix)/*

And then:

    brew link git

#### Fix perl locale warning

Now when using git, e.g. `git pull origin master` results in the following `perl: warnings`:

```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
  LANGUAGE = (unset),
  LC_ALL = (unset),
  LC_CTYPE = "UTF-8",
  LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```

To fix this add the following to your `.bash_profile`:

    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8

[brew-issue-3228]: https://github.com/Homebrew/brew/issues/3228

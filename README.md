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

#!/bin/sh

#-------------------------------------------------------------------------------
# Thanks Maxime Fabre! https://speakerdeck.com/anahkiasen/a-storm-homebrewin
# Thanks Mathias Bynens! https://mths.be/osx
#-------------------------------------------------------------------------------

export DOTFILES=$HOME/dotfiles
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
#-------------------------------------------------------------------------------
# Update dotfiles itself
#-------------------------------------------------------------------------------

if [ -d "$DOTFILES/.git" ]; then
  git --work-tree="$DOTFILES" --git-dir="$DOTFILES/.git" pull origin master
fi

#-------------------------------------------------------------------------------
# Check for Homebrew and install if we don't have it
#-------------------------------------------------------------------------------

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#-------------------------------------------------------------------------------
# Install executables and libraries
#-------------------------------------------------------------------------------

brew install bash
brew install zsh
brew install zsh-completions
brew install coreutils
brew install findutils
brew install gnu-sed
brew install awscli
brew install aws-elasticbeanstalk
brew install git
brew install htop
brew install httpie
brew install jq
brew install kubectl
brew install openssl
brew install tcpdump
brew install tree
brew install watch
brew install wget
brew install yarn
brew install youtube-dl
brew install openapi-generator
brew install aws-iam-authenticator
brew install speedtest-cli
brew install colordiff

brew install composer
brew install phpunit

brew install ruby
brew install rbenv

brew install gradle
brew install maven
brew install sbt
brew install jenv

brew cask install adoptopenjdk/openjdk/adoptopenjdk
brew cask install adoptopenjdk11
brew cask install docker
brew cask install firefox
brew cask install google-chrome
brew cask install google-backup-and-sync
brew cask install intellij-idea
brew cask install iterm2
brew cask install postman
brew cask install obs
brew cask install slack
brew cask install sublime-text
brew cask install wireshark
brew cask install tableplus
brew cask install font-source-code-pro

#-------------------------------------------------------------------------------
# Install global Git configuration
#-------------------------------------------------------------------------------

ln -nfs $DOTFILES/.gitconfig $HOME/.gitconfig
git config --global core.excludesfile $DOTFILES/.gitignore_global
git config --global user.name "appkr"
git config --global user.email "juwonkim@me.com"

#-------------------------------------------------------------------------------
# Make ZSH the default shell environment
#-------------------------------------------------------------------------------

chsh -s $(which zsh)

#-------------------------------------------------------------------------------
# Install Oh-my-zsh
#-------------------------------------------------------------------------------

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Powerline theme
# Neet to set font in iterm2 preferences
wget https://raw.githubusercontent.com/jeremyFreeAgent/oh-my-zsh-powerline-theme/master/powerline.zsh-theme -O $HOME/.oh-my-zsh/themes/powerline.zsh-theme
git clone git@github.com:powerline/fonts.git && bash fonts/install.sh
sleep 3
rm -rf fonts

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

#-------------------------------------------------------------------------------
# Vim setting
#-------------------------------------------------------------------------------

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -nfs $DOTFILES/.vimrc $HOME/.vimrc
vim +PluginInstall +qall

mkdir $HOME/.vim/colors
wget https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim -O $HOME/.vim/colors/atom-dark-256.vim

#-------------------------------------------------------------------------------
# Install global PHP tools
#-------------------------------------------------------------------------------

composer global require \
    laravel/installer \
    psy/psysh:@stable \
    guzzlehttp/guzzle \
    illuminate/support \
    nesbot/carbon \
    ramsey/uuid

mkdir $HOME/.config/psysh
ln -nfs $DOTFILES/psysh/config.php $HOME/.config/psysh/config.php

#-------------------------------------------------------------------------------
# Install global JavaScript tools
#-------------------------------------------------------------------------------

npm config set prefix $HOME/npm
yarn global add redoc

#-------------------------------------------------------------------------------
# Install Rails & Jekyll
#-------------------------------------------------------------------------------

gem install pry rails jekyll bundler

#-------------------------------------------------------------------------------
# Install jshell
#-------------------------------------------------------------------------------

git clone git@github.com:appkr/jsh.git $HOME/jsh

#-------------------------------------------------------------------------------
# Source profile
#-------------------------------------------------------------------------------

ln -nfs $DOTFILES/.zshrc $HOME/.zshrc
source $HOME/.zshrc

#-------------------------------------------------------------------------------
# Enable jenv and rbenv
#-------------------------------------------------------------------------------

jenv add $(javahome 1.8)
jenv add $(javahome 11)
# `rbenv install -l` list installed versions
# `rbenv install <version>` to install a specific version
# `rbenv shell <version>` to specify ruby version used in shedll
# `rbenv global <version>` to set global version

#-------------------------------------------------------------------------------
# Set OS X preferences
# We will run this last because this will reload the shell
# Fix backtick(`) issue @see https://ani2life.com/wp/?p=1753
#-------------------------------------------------------------------------------

if [[ ! -d $HOME/Library/KeyBindings ]]; then
    mkdir -p $HOME/Library/KeyBindings
fi
cp $DOTFILES/mac/DefaultkeyBinding.dict $HOME/Library/KeyBindings/

source $DOTFILES/.osx

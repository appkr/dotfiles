#!/bin/sh

#-------------------------------------------------------------------------------
# Thanks Maxime Fabre! https://speakerdeck.com/anahkiasen/a-storm-homebrewin
# Thanks Mathias Bynens! https://mths.be/osx
#-------------------------------------------------------------------------------

export DOTFILES=$HOME/dotfiles

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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#-------------------------------------------------------------------------------
# Install executables and libraries
#-------------------------------------------------------------------------------

arch -arm64 brew install bash
arch -arm64 brew install zsh
arch -arm64 brew install zsh-completions
arch -arm64 brew install coreutils
arch -arm64 brew install findutils
arch -arm64 brew install gnu-sed
arch -arm64 brew install awscli
arch -arm64 brew install git
arch -arm64 brew install ghz
arch -arm64 brew install htop
arch -arm64 brew install httpie
arch -arm64 brew install jq
arch -arm64 brew install kubectl
arch -arm64 brew install k9s
arch -arm64 brew install openssl
arch -arm64 brew install tcpdump
arch -arm64 brew install tree
arch -arm64 brew install watch
arch -arm64 brew install wget
arch -arm64 brew install yarn
arch -arm64 brew install youtube-dl
arch -arm64 brew install openapi-generator
arch -arm64 brew install aws-iam-authenticator
arch -arm64 brew install speedtest-cli
arch -arm64 brew install colordiff
arch -arm64 brew install telnet
arch -arm64 brew install git-crypt
arch -arm64 brew install gnupg
arch -arm64 brew install graphviz
arch -arm64 brew install ffmpeg
arch -arm64 brew install dive
arch -arm64 brew install protobuf
arch -arm64 brew install grpcurl
# workaround for jshell console error, @see https://github.com/mrsarm/jshell-plugin#tab-completion-and-arrow-keys-not-working
arch -arm64 brew install rlwrap

arch -arm64 brew install composer
arch -arm64 brew install php
arch -arm64 brew install phpunit
arch -arm64 brew install brew-php-switcher

arch -arm64 brew install ruby
arch -arm64 brew install rbenv
arch -arm64 brew install python
arch -arm64 brew install pyenv

arch -arm64 brew install gradle
arch -arm64 brew install maven
arch -arm64 brew install sbt
arch -arm64 brew install jenv

arch -arm64 brew install mysql-client

arch -arm64 brew install corretto8
arch -arm64 brew install corretto11
arch -arm64 brew install corretto17
arch -arm64 brew install docker --cask
arch -arm64 brew install docker-credential-helper
arch -arm64 brew install firefox
arch -arm64 brew install google-chrome
arch -arm64 brew install intellij-idea
arch -arm64 brew install iterm2
arch -arm64 brew install jmc
arch -arm64 brew install postman
arch -arm64 brew install obs
arch -arm64 brew install slack
arch -arm64 brew install sublime-text
arch -arm64 brew install visual-studio-code
arch -arm64 brew install visualvm
arch -arm64 brew install wireshark
arch -arm64 brew install tableplus
arch -arm64 brew install homebrew/cask-fonts/font-source-code-pro

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

# `pyenv install -l` list installed versions
# `pyenv install <version>` to install a specific version
# `pyenv shell <version>` to specify ruby version used in shedll
# `pyenv global <version>` to set global version

#-------------------------------------------------------------------------------
# Install kubectl plugin: node-shell
# see https://github.com/kvaps/kubectl-node-shell
#-------------------------------------------------------------------------------

curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

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

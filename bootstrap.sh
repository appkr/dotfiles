#!/bin/sh

#-------------------------------------------------------------------------------
# Thanks Maxime Fabre! https://speakerdeck.com/anahkiasen/a-storm-homebrewin
# Thanks Mathias Bynens! https://mths.be/osx
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Set temporary variable
#-------------------------------------------------------------------------------

DOTFILES=$HOME/dotfiles

#-------------------------------------------------------------------------------
# Update dotfiles itself first
#-------------------------------------------------------------------------------

[ -d "$DOTFILES/.git" ] && git --work-tree="$DOTFILES" --git-dir="$DOTFILES/.git" pull origin master

#-------------------------------------------------------------------------------
# Check for Homebrew and install if we don't have it
#-------------------------------------------------------------------------------

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#-------------------------------------------------------------------------------
# Update Homebrew recipes
#-------------------------------------------------------------------------------

brew update

#-------------------------------------------------------------------------------
# Install all our dependencies with bundle (See Brewfile)
#-------------------------------------------------------------------------------

brew tap homebrew/bundle
brew bundle --file=$DOTFILES/Brewfile # Install binary & applications
brew cleanup
brew cask cleanup

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

git clone https://github.com/jhipster/jhipster-oh-my-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/jhipster

#-------------------------------------------------------------------------------
# Install & execute profile
#-------------------------------------------------------------------------------

# Always prefer dotfiles' .zshrc
ln -nfs $DOTFILES/.zshrc $HOME/.zshrc

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

ln -nfs $DOTFILES/psysh/config.php $HOME/.config/psysh/config.php

#-------------------------------------------------------------------------------
# Install global JavaScript tools
#-------------------------------------------------------------------------------
yarn global add redoc
# npm install gitbook-cli --global --save
npm config set prefix ~/npm

#-------------------------------------------------------------------------------
# Install Rails & Jekyll
#-------------------------------------------------------------------------------

gem install pry rails jekyll bundler

#-------------------------------------------------------------------------------
# Source profile
#-------------------------------------------------------------------------------

source $HOME/.zshrc

#-------------------------------------------------------------------------------
# Set OS X preferences
# We will run this last because this will reload the shell
# Fix backtick(`) issue @see https://ani2life.com/wp/?p=1753
#-------------------------------------------------------------------------------

if [[ ! -d $HOME/Library/KeyBindings ]]; then
    mkdir -p $HOME/Library/KeyBindings
fi
cp $DOTFILES/mac/DefaultkeyBinding.dict

source $DOTFILES/.osx

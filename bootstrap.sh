#!/bin/sh

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file=$HOME/dotfiles/Brewfile
brew cleanup
brew cask cleanup

# Install global Git configuration
[ ! -f $HOME/.gitconfig ] && ln -nfs $HOME/dotfiles/.gitconfig $HOME/.gitconfig
[ ! -f $HOME/.gitignore_global ] && ln -nfs $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install Oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install & execute profile
[ ! -f $HOME/.zshrc ] && ln -nfs $HOME/dotfiles/.zshrc $HOME/.zshrc
source $HOME/.zshrc

# Install Mackup cofnig
[ ! -f $HOME/.mackup.cfg ] && ln -nfs $HOME/dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/envoy laravel/valet tightenco/jigsaw

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Install Homestead Repo
git clone git@github.com:laravel/homestead.git $HOME/Homestead
[[ $(basename $(pwd)) == "Homestead" ]] && cd $HOME/Homestead
vagrant box add laravel/homestead

# Install global Node packages
npm install gitbook-cli gulp-cli gulp yo http-server --global --save

# Install Rails & Jekyll
gem install rails
gem install jekyll

# Set OS X preferences
# We will run this last because this will reload the shell
source $HOME/dotfiles/.osx

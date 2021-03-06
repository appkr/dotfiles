#-------------------------------------------------------------------------------
# Local bin directories before anything else
#-------------------------------------------------------------------------------

PATH="/usr/local/sbin:$PATH"

#-------------------------------------------------------------------------------
# Use project specific binaries before global ones
#-------------------------------------------------------------------------------

PATH="$HOME/npm/bin:$PATH"
export NODE_PATH="$HOME/npm/lib/node_modules"

#-------------------------------------------------------------------------------
# Make sure Homebrew PHP/Ruby is loaded
# note. To install old version of PHP, Java
#       @see https://gist.github.com/appkr/e90ddf378a28745fcd75c56a1fa9ba72
#-------------------------------------------------------------------------------

# For old version of PHP @see https://tecadmin.net/install-php-macos/
# $ curl -s http://php-osx.liip.ch/install.sh | bash -s 7.{y}
# Note the install location is /usr/local/php5/bin
#export PATH=/usr/local/php5/bin:$PATH

# For old version of PHP @see https://gist.github.com/appkr/e90ddf378a28745fcd75c56a1fa9ba72
# But following line is not required when brew-php-switcher is installed
#export PATH="$(brew --prefix php)/bin:$PATH"

PATH="$(brew --prefix ruby)/bin:$PATH"
mkdir -p $HOME/gems
export GEM_HOME=$HOME/gems
export GEM_PATH=$HOME/gems
PATH=$GEM_HOME/bin:$PATH

#-------------------------------------------------------------------------------
# Make sure coreutils are loaded before system commands
#-------------------------------------------------------------------------------

PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

#-------------------------------------------------------------------------------
# Composer
#-------------------------------------------------------------------------------

# PATH="$PATH:$HOME/.composer/vendor/bin"

#-------------------------------------------------------------------------------
# Load custom commands
#-------------------------------------------------------------------------------

PATH="/usr/local/opt/icu4c/bin:$PATH"
PATH="/usr/local/opt/icu4c/sbin:$PATH"

export PATH="$DOTFILES/bin:$PATH"

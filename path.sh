PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

#-------------------------------------------------------------------------------
# Use project specific binaries before global ones
#-------------------------------------------------------------------------------

PATH="$(/opt/homebrew/bin/brew --prefix node@18)/bin:$HOME/npm/bin:$PATH"
export NODE_PATH="$HOME/npm/lib/node_modules"

#-------------------------------------------------------------------------------
# Make sure Homebrew PHP/Ruby is loaded
# note. To install old version of PHP, Java
#       @see https://gist.github.com/appkr/e90ddf378a28745fcd75c56a1fa9ba72
#-------------------------------------------------------------------------------

mkdir -p $HOME/gems
export GEM_HOME=$HOME/gems
export GEM_PATH=$HOME/gems

PATH="$(/opt/homebrew/bin/brew --prefix php)/bin:$(/opt/homebrew/bin/brew --prefix ruby)/bin:$GEM_HOME/bin:$PATH"

#-------------------------------------------------------------------------------
# Make sure coreutils are loaded before system commands
#-------------------------------------------------------------------------------

PATH="$(/opt/homebrew/bin/brew --prefix coreutils)/libexec/gnubin:$PATH"

#-------------------------------------------------------------------------------
# Go
#-------------------------------------------------------------------------------

PATH="$(/opt/homebrew/bin/brew --prefix go)/bin:$GOPATH:$PATH"

#-------------------------------------------------------------------------------
# CLang
#-------------------------------------------------------------------------------

PATH="$(/opt/homebrew/bin/brew --prefix llvm)/bin:$PATH"

#-------------------------------------------------------------------------------
# Return
#-------------------------------------------------------------------------------

export PATH="$DOTFILES/bin:$PATH"


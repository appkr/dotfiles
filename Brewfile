#-------------------------------------------------------------------------------
# Taps
#-------------------------------------------------------------------------------

tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'caskroom/versions'
tap 'homebrew/services'
tap 'pivotal/tap'
tap 'AdoptOpenJDK/openjdk'

#-------------------------------------------------------------------------------
# Make sure apps get installed in system Applications dir
#-------------------------------------------------------------------------------

cask_args appdir: '/Applications'

#-------------------------------------------------------------------------------
# Install ZSH
#-------------------------------------------------------------------------------

brew 'zsh'
brew 'zsh-completions'

#-------------------------------------------------------------------------------
# Install GNU core utilities (those that come with OS X are outdated)
#-------------------------------------------------------------------------------

brew 'coreutils'

#-------------------------------------------------------------------------------
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
#-------------------------------------------------------------------------------

brew 'findutils'

#-------------------------------------------------------------------------------
# Install Bash 4
#-------------------------------------------------------------------------------

brew 'bash'

#-------------------------------------------------------------------------------
# Install more recent versions of some OS X tools
#-------------------------------------------------------------------------------

#brew 'homebrew/dupes/grep'

#-------------------------------------------------------------------------------
# Install Binaries
#-------------------------------------------------------------------------------

brew 'asciinema'
brew 'awscli'
brew 'aws-elasticbeanstalk'
# brew 'autoconf'
brew 'ctags'
# brew 'ffmpeg'
brew 'git'
# brew 'git-flow'
# brew 'git-stree' # deprecated
brew 'highlight'
brew 'htop'
brew 'httpie'
brew 'hub'
brew 'jmeter'
brew 'jq'
brew 'kubectl'
# brew 'latex2html'
# brew 'libav'
brew 'mackup'
brew 'nano'
#brew 'node'
brew 'openssl'
brew 'pandoc'
brew 'tcpdump'
#brew 'thrift'
# brew 'tmux'
brew 'tree'
# brew 'trash'
# brew 'valgrind' # as of 181013, Required: macOS <= 10.12
brew 'watch'
brew 'wget'
brew 'yarn'
brew 'youtube-dl'

#-------------------------------------------------------------------------------
# Development-PHP
# @see $ brew info php71, which reads...
# With the release of macOS Sierra the Apache module is now not built by default.
# If you want to build it on your system you have to install php with the
# --with-httpd24 option. See  brew options php71  for more details.
#-------------------------------------------------------------------------------

#brew 'php70' #, args: ['without-apache']
brew 'brew-php-switcher'
# brew 'php71-intl'
# brew 'php71-mecab'
# brew 'php71-redis'
# brew 'php71-xdebug'
# brew 'phpdocumentor'
brew 'composer'
brew 'phpunit'
brew 'php-cs-fixer'

#-------------------------------------------------------------------------------
# Development-Ruby
#-------------------------------------------------------------------------------

brew 'ruby'
brew 'rbenv'

#-------------------------------------------------------------------------------
# Development-Python (includes pip, easy_install)
#-------------------------------------------------------------------------------

#brew 'python', args:['with-sphinx-doc']
#brew 'python3', args:['with-sphinx-doc']
#brew 'pyenv-virtualenv'

#-------------------------------------------------------------------------------
# Development-Go
#-------------------------------------------------------------------------------

#brew 'golang'

#-------------------------------------------------------------------------------
# Development-Java
#-------------------------------------------------------------------------------

cask 'java'
brew 'gradle'
brew 'maven'
brew 'springboot'
brew 'tomcat'
brew 'jhipster'

#-------------------------------------------------------------------------------
# Development-Database
#-------------------------------------------------------------------------------

# brew 'mysql'
# brew 'sqlite'

#-------------------------------------------------------------------------------
## Tools
#-------------------------------------------------------------------------------

brew 'swagger-codegen'

#-------------------------------------------------------------------------------
# Apps
#-------------------------------------------------------------------------------

# cask 'adapter'
# cask 'calibre'
cask 'docker'
#cask 'evernote'
cask 'firefox'
# cask 'github-desktop'
cask 'google-chrome'
cask 'google-backup-and-sync'
cask 'intellij-idea'
cask 'iterm2'
cask 'keycastr'
# cask 'mactex'
#cask 'moom'
# cask 'phpstorm'
cask 'postman'
cask 'obs'
# cask 'rdm' # Installing rdm has failed!
#cask 'screenflow'
cask 'sequel-pro'
cask 'slack'
cask 'sublime-text'
#cask 'visualvm'
cask 'wireshark'

#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------

cask 'font-source-code-pro'

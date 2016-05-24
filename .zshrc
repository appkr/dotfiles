#-------------------------------------------------------------------------------
# Path to your dotfiles installation.
#-------------------------------------------------------------------------------

export DOTFILES=$HOME/dotfiles

#-------------------------------------------------------------------------------
# Path to your oh-my-zsh installation.
#-------------------------------------------------------------------------------

export ZSH=$HOME/.oh-my-zsh

#-------------------------------------------------------------------------------
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#-------------------------------------------------------------------------------

#export POWERLINE_RIGHT_B="none"
#export POWERLINE_HIDE_USER_NAME="true"
#export POWERLINE_HIDE_HOST_NAME="true"
#export POWERLINE_DISABLE_RPROMPT="true"
#POWERLINE_PATH="short"
#POWERLINE_DETECT_SSH="true"

# see https://github.com/bhilburn/powerlevel9k
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

#export ZSH_THEME="powerline"
#export ZSH_THEME="agnoster"

#------------------------------------------------------------------------------
# Uncomment the following line to use case-sensitive completion.
#-------------------------------------------------------------------------------

CASE_SENSITIVE="true"

#-------------------------------------------------------------------------------
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
#-------------------------------------------------------------------------------

# HYPHEN_INSENSITIVE="true"

#-------------------------------------------------------------------------------
# Uncomment the following line to disable bi-weekly auto-update checks.
#-------------------------------------------------------------------------------

# DISABLE_AUTO_UPDATE="true"

#-------------------------------------------------------------------------------
# Uncomment the following line to change how often to auto-update (in days).
#-------------------------------------------------------------------------------

export UPDATE_ZSH_DAYS=7

#-------------------------------------------------------------------------------
# Uncomment the following line to disable colors in ls.
#-------------------------------------------------------------------------------

# DISABLE_LS_COLORS="true"

#-------------------------------------------------------------------------------
# Uncomment the following line to disable auto-setting terminal title.
#-------------------------------------------------------------------------------

# DISABLE_AUTO_TITLE="true"

#-------------------------------------------------------------------------------
# Uncomment the following line to enable command auto-correction.
#-------------------------------------------------------------------------------

# ENABLE_CORRECTION="true"

#-------------------------------------------------------------------------------
# Uncomment the following line to display red dots whilst waiting for completion.
#-------------------------------------------------------------------------------

COMPLETION_WAITING_DOTS="true"

#-------------------------------------------------------------------------------
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#-------------------------------------------------------------------------------

# DISABLE_UNTRACKED_FILES_DIRTY="true"

#-------------------------------------------------------------------------------
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
#-------------------------------------------------------------------------------

HIST_STAMPS="yyyy-mm-dd"

#-------------------------------------------------------------------------------
# Would you like to use another custom folder than $ZSH/custom?
#-------------------------------------------------------------------------------

# ZSH_CUSTOM=$DOTFILES

#-------------------------------------------------------------------------------
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#-------------------------------------------------------------------------------

plugins=(git git-extras npm composer docker docker-compose)

#-------------------------------------------------------------------------------
# Activate Oh-My-Zsh
#-------------------------------------------------------------------------------

source $ZSH/oh-my-zsh.sh

#-------------------------------------------------------------------------------
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
#-------------------------------------------------------------------------------

files=("$DOTFILES/.export" "$DOTFILES/.path" "$DOTFILES/.aliases" "$DOTFILES/.functions" "$DOTFILES/.extra");

for file in "${files[@]}"; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

unset files file;

# eval "$(hub alias -s)"

#-------------------------------------------------------------------------------
# Activate K8S Auto Completion
#-------------------------------------------------------------------------------

source <(kubectl completion zsh)

#-------------------------------------------------------------------------------
# Activate jenv
#-------------------------------------------------------------------------------

if which jenv > /dev/null; then eval "$(jenv init -)"; fi



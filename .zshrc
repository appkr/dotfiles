export EDITOR=vim
export DOTFILES=$HOME/dotfiles
export ZSH=$HOME/.oh-my-zsh
export NODE_PATH=$HOME/npm/lib/node_modules

export FLEX_USER_EMAIL=juwon@flex.team
export OKTA_API_KEY=FILL_ME

# theme
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

CASE_SENSITIVE="true"

plugins=(git kubectl)

# custom export, path, alias, functions
files=("$DOTFILES/path.sh" "$DOTFILES/aliases.sh" "$DOTFILES/functions.sh");
for file in "${files[@]}"; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset files file;

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)
source $HOME/.sdkman/bin/sdkman-init.sh

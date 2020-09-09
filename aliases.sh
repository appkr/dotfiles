#-------------------------------------------------------------------------------
# CLI shortcut
#-------------------------------------------------------------------------------

# List current directory
alias ll="$(brew --prefix coreutils)/libexec/gnubin/ls -ahlF --color --group-directories-first"

#-------------------------------------------------------------------------------
# Homebrew
# e.g., $ service list
#-------------------------------------------------------------------------------

alias service="brew services"

#-------------------------------------------------------------------------------
# Some more alias to avoid making mistakes:
#-------------------------------------------------------------------------------

# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

#-------------------------------------------------------------------------------
# Docker
#-------------------------------------------------------------------------------

alias dc="docker-compose"

#-------------------------------------------------------------------------------
# Git
#-------------------------------------------------------------------------------

alias nah="git reset --hard HEAD"

#-------------------------------------------------------------------------------
# Laravel
#-------------------------------------------------------------------------------

alias art="php artisan"
alias artisan="php artisan"
alias tinker="php artisan tinker"
alias serve="php artisan serve"

# for reference
alias ebtinker='sudo -E -u webapp bash -c "HOME=/tmp; php /var/app/current/artisan tinker"'

#-------------------------------------------------------------------------------
# Symfony
#-------------------------------------------------------------------------------

alias console="php bin/console"
alias con="php bin/console"

#-------------------------------------------------------------------------------
# PHP Development
#-------------------------------------------------------------------------------

alias pt="vendor/bin/phpunit -d memory_limit=1G"
alias psh="psysh"
alias pshell="psysh"

#-------------------------------------------------------------------------------
# MeshDev
# e.g. $ primeenv dev1
#-------------------------------------------------------------------------------

# TODO NEED TO FIX
alias primeenv="bastion-switcher"

#-------------------------------------------------------------------------------
# AWS CW Logs
#-------------------------------------------------------------------------------

# list all log groups
# aws logs describe-log-groups --query "logGroups[].[logGroupName]" --output text --profile eb-cli --region ap-northeast-2

# list all log streams
# LOG_GROUP_OF_INTEREST=/aws/rds/instance/prime-production/slowquery
# aws logs describe-log-streams --log-group-name "${LOG_GROUP_OF_INTEREST}" --query "logStreams[].[logStreamName]" --output text  --profile eb-cli --region ap-northeast-2

#-------------------------------------------------------------------------------
# K8S
# @see https://kubernetes.io/ko/docs/reference/kubectl/cheatsheet/
#-------------------------------------------------------------------------------

alias k=kubectl

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
# kubectl, kafkactl
# @see https://kubernetes.io/ko/docs/reference/kubectl/cheatsheet/
# @see https://github.com/deviceinsight/kafkactl
#   kafkactl consume test-topic --from-beginning --print-keys --print-timestamps -o yaml --tail=5 --exit --key-encoding=hex --value-encoding=base64
#   echo "key1@value1" | kafkactl produce test-topic --separator=@ --partition=1
#   kafkactl alter topic test-topic --partitions 2 -c retention.ms=3600000 # NOT WORKING "Could not create partitions for topic 'test-topic': EOF"
#   kafkactl create topic test-topic
#   kafkactl get topics
#   kafkactl delete topic test-topic
#   kafkactl get consumer-groups --topic test-topic
#   kafkactl reset offset my-group --topic test-topic --oldest
#   kafkactl reset offset my-group --topic test-topic --partition 0 --offset 0
#-------------------------------------------------------------------------------

alias k=kubectl
alias ctx=kubectx
# for config file @see $HOME/.config/kafkactl/config.yml
alias kf=kafkactl

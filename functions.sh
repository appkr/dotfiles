GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

ensure_dependency() {
  if ! which "$1" &>/dev/null ; then
    echo "$1 not found"
    exit 1
  fi
}

confirm() {
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
   [yY])
     true
     ;;
   *)
     false
     ;;
  esac
}

print_bold() {
  if [ ! -z "$1" ]; then
    echo -e "${BOLD}${1}${NC}"
  fi
}

print_red() {
  if [ ! -z "$1" ]; then
    echo -e "${RED}${1}${NC}"
  fi
}

print_green() {
  if [ ! -z "$1" ]; then
    echo -e "${GREEN}${1}${NC}"
  fi
}

print_yellow() {
  if [ ! -z "$1" ]; then
    echo -e "${YELLOW}${1}${NC}"
  fi
}

#-------------------------------------------------------------------------------
# Shell chestsheet
#-------------------------------------------------------------------------------
# $* : all args
# $# : number of args
# shift <n> : shift n args to the left. given 6 args, "shift 2" makes 4 args
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Create a new directory and enter it
#-------------------------------------------------------------------------------

mkd() {
  mkdir -p "$@" && cd "$_";
}

#-------------------------------------------------------------------------------
# Open man page as PDF
#-------------------------------------------------------------------------------

manpdf() {
  man -t "${1}" | open -f -a /Applications/Preview.app/
}

#-------------------------------------------------------------------------------
# Extract many types of compressed packages
# Credit: http://nparikh.org/notes/zshrc.txt
#-------------------------------------------------------------------------------

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar -jxvf "$1"                        ;;
      *.tar.gz)   tar -zxvf "$1"                        ;;
      *.bz2)      bunzip2 "$1"                          ;;
      *.dmg)      hdiutil mount "$1"                    ;;
      *.gz)       gunzip "$1"                           ;;
      *.tar)      tar -xvf "$1"                         ;;
      *.tbz2)     tar -jxvf "$1"                        ;;
      *.tgz)      tar -zxvf "$1"                        ;;
      *.zip)      unzip "$1"                            ;;
      *.ZIP)      unzip "$1"                            ;;
      *.pax)      cat "$1" | pax -r                     ;;
      *.pax.Z)    uncompress "$1" --stdout | pax -r     ;;
      *.Z)        uncompress "$1"                       ;;
      *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
     echo "'$1' is not a valid file to extract"
  fi
}

#-------------------------------------------------------------------------------
# Determine size of a file or total size of a directory
#-------------------------------------------------------------------------------

fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi

  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* ./*;
  fi;
}

#-------------------------------------------------------------------------------
# Create a data URL from a file
#-------------------------------------------------------------------------------

dataurl() {
  local mimeType=$(file -b --mime-type "$1");
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8";
  fi

  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

#-------------------------------------------------------------------------------
# Start a PHP local server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
#-------------------------------------------------------------------------------

phpserver() {
  echo -e "\033[32mSwitching PHP runtime version\033[0m"
  echo ""
  echo "Usage:"
  echo "  phpserver <port>"
  echo ""

  local port="${1:-8000}";
  local ip=$(ipconfig getifaddr en0);
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}";
}

#-------------------------------------------------------------------------------
# Convert EUC-KR to UTF-8
#-------------------------------------------------------------------------------

enc() {
  iconv -c -f EUC-KR -t UTF-8 $1 > utf8_"$1"
}

#-------------------------------------------------------------------------------
# UTF-8-encode a string of Unicode symbols
#-------------------------------------------------------------------------------

escape() {
  printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi;
}

#-------------------------------------------------------------------------------
# Decode \x{ABCD}-style Unicode escape sequences
#-------------------------------------------------------------------------------

unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi;
}

#-------------------------------------------------------------------------------
# Get a character’s Unicode code point
#-------------------------------------------------------------------------------

codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi;
}

#-------------------------------------------------------------------------------
# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
#-------------------------------------------------------------------------------

s() {
  if [ $# -eq 0 ]; then
    subl .;
  else
    subl "$@";
  fi;
}

#-------------------------------------------------------------------------------
# `o` with no arguments opens the current directory, otherwise opens the given
# location
#-------------------------------------------------------------------------------

o() {
  if [ $# -eq 0 ]; then
    open .;
  else
    open "$@";
  fi;
}

#-------------------------------------------------------------------------------
# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
#-------------------------------------------------------------------------------

tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

#-------------------------------------------------------------------------------
# Highlight
#-------------------------------------------------------------------------------

#hl() {
#  if [[ "$1" && "$2" ]]
#    then
#      if [[ -z "$3" ]] then; FONTSIZE=24; else; FONTSIZE=$3; fi;
#      highlight -O rtf $1 --syntax $2 --font D2Coding --style solarized-dark \
#          --font-size $FONTSIZE | pbcopy
#    else
#      echo "\033[31mError: missing required arguments.\033[0m"
#      echo "Usage: "
#      echo "  hl filename syntax [fontsize]"
#    fi
#}

#-------------------------------------------------------------------------------
# Docker
#-------------------------------------------------------------------------------

dip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

dsm() {
	docker container stop $1 && docker container rm $1
}

# drm() {
# 	docker container ls -a -q | xargs docker container rm
# }

drmi() {
	docker image ls -a | grep '<none>' | awk '{ print $3 }' | xargs docker image rm
}

drun() {
	docker container run --rm -it $@
}

dbash() {
	if [ $# -lt 1 ] ; then
	  echo "Please provide a container id or name. Usage: dbash <containerIdOrName>"
	else
		docker container exec -it $1 bash
	fi;
}

dlogs() {
  if [ "$1" = "" ]; then
    echo "view docker container logs"
    echo ""
    echo "Usage:"
    echo '  dlogs <CONTAINER_ID>'
    return 0;
  fi;

  docker container logs -f "$1" | jq -R '. as $line | try (fromjson) catch $line'
}

#-------------------------------------------------------------------------------
# IP check
#-------------------------------------------------------------------------------

myip() {
  curl -s "ifconfig.me"
}

#-------------------------------------------------------------------------------
# Release Versions
#-------------------------------------------------------------------------------

version() {
  local BRANCH=`git rev-parse --abbrev-ref HEAD`
  local HASH=`git show --pretty='format:%h' | head -1`
  echo $BRANCH~$HASH
}

#-------------------------------------------------------------------------------
# Find dev1 DNS
#-------------------------------------------------------------------------------

# dev1dns() {
#   local RES=`cd $HOME/meshkorea/prime-dev1-server && eb health dev1-EBPrimeBackend | grep -E 'i-[a-z0-9]{17}' | awk '{ print $1 }' | xargs aws ec2 describe-instances --profile meshdev --instance-ids | grep PrivateDnsName | head -n 1 | tr -d '[:space:]'`
#   echo $RES
# }

#-------------------------------------------------------------------------------
# Homebrew PHP Version Switcher
# e.g., $ p 7.1
#-------------------------------------------------------------------------------

phpenv() {
  echo -e "\033[32mSwitching PHP runtime version\033[0m"
  if [ "$1" = "" ]; then
    echo ""
    echo "Usage:"
    echo "  phpenv <php_version>"
    echo "  e.g. p 7.2"
    echo ""
    echo "Available versions:"
    ls -al /usr/local/Cellar | grep php@
    return 0;
  fi;

  local VERSION="$1"
  echo "Switching PHP runtime to ${VERSION}"
  brew-php-switcher $VERSION && sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
  echo "Switched PHP runtime to ${VERSION}"
}

#-------------------------------------------------------------------------------
# Log Tailing
#-------------------------------------------------------------------------------

ct() {
  echo -e "\033[32mTailing log after truncating content\033[0m"
  if [ "$1" = "" ]; then
    echo ""
    echo "Usage:"
    echo "  ct <path_to_log>"
    return 0;
  fi;

  local LOG_FILE="$1"
  cat /dev/null > $LOG_FILE
  tail -f $LOG_FILE
}

#-------------------------------------------------------------------------------
# Echo with yellow color
#-------------------------------------------------------------------------------

e() {
  if [ "$1" = "" ]; then
    echo "Print text in \033[0;33mYellow\033[0m color"
    echo ""
    echo "Usage:"
    echo '  e "<text>"'
    return 0;
  fi;

  local TEXT="$1"
  echo -e "\033[0;33m${TEXT}\033[0m"
}

#-------------------------------------------------------------------------------
# Toggle Xdebug
#-------------------------------------------------------------------------------

# xd() {
#   local PHPINIPATH=$(php --ini | head -1 | cut -d ":" -f 2 | xargs echo)
#   local XDEBUGPATH=$(find "$PHPINIPATH" | grep xdebug)

#   if [ $XDEBUGPATH = "" ]; then
#       echo "Xdebug not found"
#       return 0;
#   fi;

#   local SUFFIX=".disabled"
#   local NEWPATH=""
#   local MESSAGE1=""
#   local MESSAGE3=""

#   if [[ "$XDEBUGPATH" =~ .*disabled$ ]]; then
#       NEWPATH=$(echo "${XDEBUGPATH%$SUFFIX}")
#       MESSAGE1="Changing state from \033[32mON\033[0m to \033[31mOFF\033[0m"
#       MESSAGE3="\033[32mXdebug is now ON\033[0m"
#   else
#       NEWPATH="${XDEBUGPATH}${SUFFIX}"
#       MESSAGE1="Changing state from \033[31mOFF\033[0m to \033[32mON\033[0m"
#       MESSAGE3="\033[31mXdebug is now OFF\033[0m"
#   fi;

#   echo -e $MESSAGE1
#   sudo mv $XDEBUGPATH $NEWPATH
#   echo -e $MESSAGE3
# }

#-------------------------------------------------------------------------------
# Kill Port
#-------------------------------------------------------------------------------

killport() {
  if [ "$1" = "" ]; then
    echo "Print text in \033[0;33mYellow\033[0m color"
    echo ""
    echo "Usage:"
    echo '  killport "<port>"'
    return 0;
  fi;

  local PORT="$1"
  kill $(lsof -t -i :$PORT)
  echo -e "\033[0;33m${PORT} port has been closed\033[0m"
}

#-------------------------------------------------------------------------------
# yaml to json
#-------------------------------------------------------------------------------

yq() {
    ruby -r yaml -r json -e 'puts YAML.load($stdin.read).to_json' | jq
}

merge_yaml() {
    ruby -r 'yaml' -e "c = YAML.load(File.open('${1}')); d = YAML.load(File.open('${2}')); c.merge!(d); p c.to_yaml(:indentation => 2);"
}

#-------------------------------------------------------------------------------
# Reload zsh
#-------------------------------------------------------------------------------

rr() {
  source $HOME/.zshrc
}

#-------------------------------------------------------------------------------
# Refresh DNS Cache
#-------------------------------------------------------------------------------

reloaddns() {
  echo -e "\033[32mRefresh DNS Cache\033[0m"
  dscacheutil -flushcache && sudo killall -HUP mDNSResponder
}

#-------------------------------------------------------------------------------
# Recursively remove .DS_Store files
#-------------------------------------------------------------------------------

cds() {
  echo -e "\033[32mRecursively remove .DS_Store files\033[0m"
  find . -type f -name '*.DS_Store' -ls -delete
}

#-------------------------------------------------------------------------------
# Stop apache
#-------------------------------------------------------------------------------

stopapache() {
  echo -e "\033[32mStop apache\033[0m"
  sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
}

#-------------------------------------------------------------------------------
# Extract mp3 from the given path
#-------------------------------------------------------------------------------

mp3() {
  echo -e "\033[32mExtract mp3 from the given path\033[0m"
  if [ "$1" = "" ]; then
    echo ""
    echo "Usage:"
    echo "  mp3 <url>"
  fi;

  youtube-dl --extract-audio --audio-format mp3 $1
}

#-------------------------------------------------------------------------------
# Kibana log
#-------------------------------------------------------------------------------

# kibana() {
#   if [ "$1" = "" ]; then
#     echo "Kibana log viewer"
#     echo ""
#     echo "Usage:"
#     echo "  kibana <context>"
#     echo "  e.g. kibana q"
#     echo "  e.g. kibana p"
#     echo ""
#     echo "Avaliable contexts:"
#     echo "  'q' for vroong-qa, 'p' for vroong-prod, 'tms-dev', 'tms-qa', 'tms-prod'"
#     return 0;
#   fi;

#   local CONTEXT="$1"
#   echo -e "\033[32mSwitching context to ${CONTEXT}\033[0m"

#   case "${CONTEXT}" in
#       [qQ])
#           open https://localhost:9500/_plugin/kibana
#           ssh vroong.elk.qa -N -v
#           ;;
#       [pP])
#           open https://localhost:9600/_plugin/kibana
#           ssh vroong.elk.prod -N -v
#           ;;
#       tms-dev)
#           open "https://localhost:9200/_plugin/kibana/app/kibana#/discover?_g=(refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(columns:!(agent.hostname,message,traceId),index:d6781ae0-a727-11ea-833e-d1d011d9d56a,interval:auto,query:(language:kuery,query:''),sort:!(!('@timestamp',desc)))"
#           ssh tms.elk.dev -N -v
#           ;;
#       tms-qa)
#           open "https://localhost:9200/_plugin/kibana/app/kibana#/discover?_g=(refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(columns:!(agent.hostname,message,traceId),index:cad582d0-b76d-11ea-833e-d1d011d9d56a,interval:auto,query:(language:kuery,query:''),sort:!(!('@timestamp',desc)))"
#           ssh tms.elk.dev -N -v
#           ;;
#       tms-prod)
#           open "https://kibana.meshtools.io/s/tms/app/kibana#/discover?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(columns:!(level,message,traceId),filters:!(),index:c5bd0410-eb63-11ea-b2f5-3f2fe4fd70f4,interval:auto,query:(language:kuery,query:''),sort:!())"
#           ;;
#       *)
#           echo -e "\033[0;33m${CONTEXT} is not acceptable\033[0m"
#           ;;
#   esac
# }

#-------------------------------------------------------------------------------
# tunnel to kubernetes cluster
#-------------------------------------------------------------------------------

# tunnel() {
#   if [ "$1" = "" ]; then
#     echo "Create SSH tunnel to kubernetes cluster"
#     echo ""
#     echo "Usage:"
#     echo "  tunnel <context>"
#     echo "  e.g. tunnel d1"
#     echo "  e.g. tunnel q1"
#     echo "  e.g. tunnel q2"
#     echo "  e.g. tunnel q3"
#     echo "  e.g. tunnel p"
#     echo ""
#     echo "Avaliable contexts:"
#     echo "  d1 for dev1"
#     echo "  q1 for qa1"
#     echo "  q2 for qa2"
#     echo "  q3 for qa3"
#     echo "  p for prod"
#     return 0;
#   fi;

#   local CONTEXT="$1"
#   echo -e "\033[32mSwitching context to ${CONTEXT}\033[0m"

#   case "${CONTEXT}" in
#       [dD]1)
#           ssh eks.dev -v -N -S none -o ControlMaster=no
#           ;;
#       [qQ][1])
#           ssh k8s.qa1 -v -N -S none -o ControlMaster=no
#           ;;
#       [qQ][2])
#           ssh k8s.qa2 -v -N -S none -o ControlMaster=no
#           ;;
#       [qQ][3])
#           ssh k8s.qa3 -v -N -S none -o ControlMaster=no
#           ;;
#       [pP])
#           ssh k8s.prod -v -N -S none -o ControlMaster=no
#           ;;
#       *)
#           echo -e "\033[0;33m${CONTEXT} is not acceptable\033[0m"
#           ;;
#   esac
# }

#-------------------------------------------------------------------------------
# K8S
#-------------------------------------------------------------------------------

# ctx() {
#   if [ "$1" = "" ]; then
#     echo "Switch kubernetes context"
#     echo ""
#     echo "Usage:"
#     echo "  ctx <context>"
#     echo "  e.g. ctx vroong-dev1"
#     echo ""
#     echo "Avaliable contexts:"
#     kubectl config get-contexts
#     return 0;
#   fi;

#   local CONTEXT="$1"
#   echo -e "\033[32mSwitching context to ${CONTEXT}\033[0m"
#   kubectl config use-context $CONTEXT
# }

# klogs() {
#   if [ "$1" = "" ]; then
#     echo "Tail pods logs"
#     echo ""
#     echo "Usage:"
#     echo "  klogs <app>"
#     echo "  e.g. klogs uaa"
#     echo ""
#     return 0;
#   fi;

#   local APP="$1"
#   {
#     # local POD=$(kubectl get pods -l app=pointcharger -o jsonpath={.items..metadata.name})
#     kubectl logs -f -l app=$APP --all-containers
#   } || {
#     # kubectl get pods -o jsonpath='{.items[*].metadata.labels.app}' | grep $APP
#     kubectl get pods | { head -n 1; grep $APP }
#   }
# }

#-------------------------------------------------------------------------------
# Java shell
#-------------------------------------------------------------------------------

jsh() {
  cd $HOME/jsh && rlwrap ./gradlew --no-daemon --console plain jshell
  cd -
}

javahome() {
  if [ "$1" = "" ]; then
    echo "Find java home"
    echo ""
    echo "Usage:"
    echo '  javahome <version>'
    echo "  e.g. javahome 1.8"
    return 0;
  fi;

  /usr/libexec/java_home -v $1
}

#-------------------------------------------------------------------------------
# git move tag and push
#-------------------------------------------------------------------------------

mt() {
  if [ "$1" = "" ]; then
    echo "change git tag and push"
    echo ""
    echo "Usage:"
    echo '  mt <tag_name>'
    echo "  e.g. mt jenkins"
    return 0;
  fi;

  local found=$(git tag | grep "$1")
  if [ "found" = "" ]; then
    echo "tag \"$1\" does not exist!"
    return 0;
  else
    git tag -d $1
    git tag $1
    git push origin :$1
    git push origin $1
  fi;
}

#-------------------------------------------------------------------------------
# boot accountsbff
#-------------------------------------------------------------------------------

# accountsbff() {
#   echo "http://localhost:9800/login?client_id=563f32dc-2c32-4178-9134-64ed523c8391"
#   cd $HOME/msa/vroong-accountsbff && export APPLICATION_UAAENDPOINT=http://localhost:9999 && ./gradlew clean bootRun
#   cd -
# }

#-------------------------------------------------------------------------------
# sync neogeorefiner
#-------------------------------------------------------------------------------

sync_refiner() {
  if [ "$1" = "" ]; then
    echo "neogeorefiner 이미지를 최신화합니다"
    echo ""
    echo "Usage:"
    echo "  $0 <tag_name>"
    echo "  e.g. $0 etpost-20220915030019"
    return 0;
  fi;

  container=$(docker inspect neogeorefiner --format "{{json .State.Status}}" 2> /dev/null | xargs)
  if [ "running" = "$container" ]; then
    print_red "neogeorefiner docker container is running"
    echo ""
    print_bold "  cd vroong-neogeo && ./gradlew composeDown"
    echo ""
    return 0;
  fi

  print_red "기존 이미지를 지울까요? [y/N]} "
  read -r response
  case "$response" in
   [yY])
     candidate1=$(docker image ls --filter=reference="neogeorefiner" --quiet)
     candidate2=$(docker image ls --filter=reference="200327251464.dkr.ecr.ap-northeast-2.amazonaws.com/vroong/neogeorefiner" --quiet)
     docker image rm $candidate1 $candidate2 --force
     ;;
  esac

  print_green "ECR에 로그인합니다"
  aws ecr get-login-password --region ap-northeast-2 --profile meshtools | docker login --username AWS --password-stdin 200327251464.dkr.ecr.ap-northeast-2.amazonaws.com

  echo ""

  print_green "이미지를 내려받습니다"
  docker pull 200327251464.dkr.ecr.ap-northeast-2.amazonaws.com/vroong/neogeorefiner:$1

  echo ""

  print_green "neogeorefiner:latest 태그를 부여합니다"
  docker tag 200327251464.dkr.ecr.ap-northeast-2.amazonaws.com/vroong/neogeorefiner:$1 neogeorefiner:latest

  echo ""

  print_green "성공"
}

#-------------------------------------------------------------------------------
# k8s pod log
#-------------------------------------------------------------------------------

klogs() {
  if [ "$1" = "" ]; then
    echo "view k8s pod logs"
    echo ""
    echo "Usage:"
    echo '  klogs <POD_ID>'
    return 0;
  fi;

  kubectl logs -f "$1" | jq -R '. as $line | try (fromjson) catch $line'
}

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
# Convert EUC-KR to UTF-8
#-------------------------------------------------------------------------------

enc() {
  iconv -c -f EUC-KR -t UTF-8 $1 > "$1"_utf8
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
# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
#-------------------------------------------------------------------------------

tre() {
  tree -aC -I '.git|.gradle|.idea' --dirsfirst "$@" | less -FRNX;
}

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

#-------------------------------------------------------------------------------
# Tunneling through K8S POD
# To install tcpserver: brew install ucspi-tcp
#-------------------------------------------------------------------------------

kubetunnel() {
  ensure_dependency tcpserver
  ensure_dependency nc

  ROW=(`kubectl get pods -n "$1" | grep "$2" | head -n 1`)
  POD="$ROW[1]"
  DEST="$3"
  LPORT="${4:=5000}"

  if [ -z "$POD" -o -z "$DEST" ]; then
    echo "Usage: kubetunnel <NS> <POD> <DEST> [LPORT]"
    echo ""
    echo "Required"
    echo "  NS    : K8S namespace"
    echo "  POD   : POD name to use as a proxy"
    echo "  DEST  : dest address and port"
    echo "Optional"
    echo "  LPORT : local binding port(default: 5000)"
    return 1
  fi

  echo "Connect to 127.0.0.1:$LPORT to access $DEST tunneling through $POD..."
  tcpserver -v 127.0.0.1 "$LPORT" kubectl exec -n "$1" -it "$POD" -- nc "$DEST"
}
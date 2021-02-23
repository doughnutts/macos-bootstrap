export USER_VPN={{REPLACE_VPN_USER}}
export PASSWORD={{REPLACE_VPN_PASSWORD}}
export SOFTWARE_HOME="~/Desktop/Applications"
export M2_HOME="~/.sdkman/candidates/maven/current/"
export M2=$M2_HOME/bin
export PROXY={{REPLACE_PROXY}}
export http_proxy=http://localhost:3128
export http_proxy=http://$USER_VPN:$PASSWORD@$PROXY
export https_proxy=$http_proxy
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export NO_PROXY=localhost*,127.0.0.1

export SONAR_HOME=/usr/local/Cellar/sonar-scanner/*/libexec
export SONAR=$SONAR_HOME/bin
export PATH=$SONAR:$PATH

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
# curlproxy function
echo "proxy=$http_proxy" >| ~/.curlrc
source ~/.curlrc

export SSO_LOGIN_URL=https://login.apigee.com
export APIGEE_USER={{REPLACE_USER}}
export APIGEE_PASSWD={{REPLACE_PASSWORD}}
export APIGEE_ORG={{REPLACE_ORG}}
export APIGEE_CLIENT_AUTH=ZWRnZWNsaTplZGdlY2xpc2VjcmV0
export APIGEE_ACCESS_TOKEN="`~/Desktop/Workspace/playground/apigee/apigee-deploy-framework/scripts/get_token`"
apig() { apigeetool $1 -o "$APIGEE_ORG" -t "$APIGEE_ACCESS_TOKEN" "${@:2}"; }

alias playground="cd ~/Desktop/Workspace"
alias sauce="source ~/.bashrc"
alias mci="mvn clean install"
alias mcist="mvn clean install -DskipTests"
alias mcits="mvn clean install -Dmaven.test.skip=true"
alias gcb="gradle clean build"
alias gcbxt="gradle clean build -x test"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias ll="ls -la"                                   # ls:       Preferred way to list all files in current directory in long list format
alias ..='cd ../'                                   # ..:       Go back 1 directory level
alias ...='cd ../../'                               # ...:      Go back 2 directory level
alias o="open ."                                    # o:        Open the current directory in Finder
alias cls="printf '\33c\e[3J'"                      # cls:      cmd+k a.k.a clear your screen
alias f='open -a Finder ./'                         # f:        Opens current directory in MacOS Finder
alias ~="cd ~"                                      # ~:        Go Home
alias memhogtop='top -l 1 -o rsize | head -20'
alias memhogps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpuhog='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias ttop="top -R -F -s 10 -o rsize"
# cleanls: Cleanup LaunchServices to remove duplicates in the "Open With" menu
alias cleanls="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias cleands="find . -type f -name '*.DS_Store' -ls -delete" # cleands: Cleanup all .DS_Store files
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netcons='lsof -i'                             # netcons:      Show all open TCP/IP sockets
alias flushdns='dscacheutil -flushcache'            # flushdns:     Flush out the DNS Cache
alias lsock='lsof -i -P'                            # lsock:        Display open sockets
alias lsocku='lsof -nP | grep UDP'                  # lsocku:       Display only open UDP sockets
alias lsockt='lsof -nP | grep TCP'                  # lsockt:       Display only open TCP sockets
alias ipinfo0='ipconfig getpacket en0'              # ipinfo0:      Get info on connections for en0
alias ipinfo1='ipconfig getpacket en1'              # ipinfo1:      Get info on connections for en1
alias ports='lsof -i | grep LISTEN'                 # ports:        All listening connections
alias showblocked='ipfw list'                       # showblocked:  All ipfw rules inc/ blocked IPs
alias qfind="find . -name "                         # qfind:        Quickly search for file
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; } # spotlight: Search for file using MacOS Spotlight's metadata
ff () { /usr/bin/find . -name "$@" ; }              # ff:           Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }          # ffs:          Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }          # ffe:          Find file whose name ends with a given string
mkd () { mkdir -p "$1" && cd "$1"; }                # mkd:          Makes new Dir and jumps inside
zipf () { zip -r "$1".zip "$1" ; }                  # zipf:         To create a ZIP archive of a folder
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi ; }
# List processes owned by user
myps() { ps $@ -u {{REPLACE_CURRENT_USER}} -o pid,%cpu,%mem,start,time,bsdtime,command ; }
# findpid: Find Process ID 
findpid () { lsof -t -c "$@" ; }
# xget: preferred wget options
xget() {
    wget --proxy-user=test --proxy-password=test --spider $1
}
# ii: Display useful host related information
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ; myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo ; }
# Get Server info
lookup() {
    host $1;
    dig $1;
    nslookup $1;
}
# mvni: pre-fill mvn install file command
mvni() {
    mvn install:install-file -Dfile=$1 -DgroupId=$2 -DartifactId=$3 -Dversion=$4 -Dpackaging=jar
}
curlproxy() {
    echo $1 >| ~/.curlrc
    source ~/.curlrc
}
# proxy: toggle proxy on/off
proxy() {
    if [ ! -z $1 ]; then
        if [ $1 = "off" -o $1 = "0" ]; then
            unsetproxy
        else
            setproxy
        fi
    else
        setproxy
    fi
}
setproxy() {
    export http_proxy=http://$USER_VPN:$PASSWORD@$PROXY
    export https_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export NO_PROXY=localhost*,127.0.0.1
    sed -i '' 's~# proxy.*~proxy = http://localhost:3128~' ~/.gitconfig
    curlproxy "proxy=$http_proxy"
    echo "proxy set"
}
unsetproxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset NO_PROXY
    sed -i '' 's~proxy.*~# proxy = http://localhost:3128~' ~/.gitconfig
    curlproxy ""
    echo "proxy unset"
}
# check if bash script is runnable
runnable() {
    head -1 $1 | od -c ;
}
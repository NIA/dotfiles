# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'

# my aliases

#  apt aliases
alias apti='sudo apt-get install'
alias aptd='sudo apt-get update'
alias aptg='sudo apt-get upgrade'
#  gem
alias gi="sudo gem install"
alias gu="sudo gem update"
#  ack-grep
alias ack='ack-grep'
alias ackrb='ack --type-add ruby=.erb,.haml'
#  rails
alias ss='script/server'
alias sc='script/console'
#  git
alias gush='git push'
alias gull='git pull'
alias ggui='git gui&'
alias gco='git checkout'
alias gst='git status'
alias gitka='gitk --all&'
alias gdi='git diff'
alias glo='git log'
alias gfe='git fetch'
#  svn
alias sup='svn update'
alias sst='svn status | ack "^[^?]"'
#  ledger
alias leed='gvim $LEDGER_FILE'
#  other
alias o='xdg-open'
alias wget='wget --no-check-certificate' # workaround wget bug, see https://github.com/blog/738-sidejack-prevention-phase-2-ssl-everywhere#comment-9002

# -- FUNCTIONS --
# TODO: separate file

# apts with filtering
apts() {
  apt-cache search $* | ack "$(echo $*|sed 's/\s\+/|/g')"
}

# svn
sdi() {
  svn diff $* | colordiff | less -R
}
slo() {
  svn diff $* | colordiff | less -R
}


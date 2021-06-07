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
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lah'

# my aliases

#  apt aliases
alias apti='sudo apt install'
# WARNING! Disable or change alias below for Ubuntu desktop systems - 'cos there are AptDaemon daemon with 'aptd' name
alias aptd='sudo apt update'
alias aptg='sudo apt upgrade'
alias aptfu='sudo apt full-upgrade'
alias aptac='sudo apt autoclean'
alias aptar='sudo apt autoremove'
# CentOS <=8 yum aliases
#alias yumi='yum install'
#alias yumu='yum update'
#alias yumug='yum upgrade'
#alias yumcu='yum check-update'
#alias yumca='yum clean all'
#alias yumcc='yum clean cache'
#CentOS 8 dnf alias (same as yum)
#alias dnfi='dnf install'
#alias dnfu='dnf update'
#alias dnfug='dnf upgrade'
#alias dnfcu='dnf check-update'
#alias dnfca='dnf clean all'
#alias dnfcc='dnf clean cache'
#  gem
alias gi="sudo gem install"
alias gu="sudo gem update"
#  ack-grep
alias ack='ack-grep'
alias ackrb='ack --type-add ruby=.erb,.haml'
#  git
alias gush='git push'
alias gull='git pull'
alias gspush='git subtree push'
alias gspull='git subtree pull'
alias ggui='git gui&'
alias gco='git checkout'
alias gst='git status'
alias gitka='gitk --all&'
alias gdi='git diff --color'
alias glo='git log --color --graph --decorate'
alias gro='git reflog --date=local --color'
alias gfe='git fetch'
alias gff='git pull --ff-only'
alias grs='git restore **/*.spriteatlas'
#  svn
alias sup='svn update'
# TODO ignoring Makefile system-wide is a Bad Thing. This should be done only for Qt projects.
alias sst='svn status | ack -v "Makefile|(_tmp|pro.user|/_?debug|/_?release)$"'
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

# whichpkg: which package installed this command? (Detects builtins and follows symlinks)
# Usage examples:
#
# nia$ whichpkg vim
# vim-gtk: /usr/bin/vim.gtk
#
# nia$ whichpkg type
# type встроена в оболочку
#
# nia$ whichpkg ll
# ll является алиасом для `ls -lh'
#
# nia$ whichpkg foobarbaz
# No such command: foobarbaz
whichpkg() {
  the_type=$(type -t $1)
  if [[ -z $the_type ]]; then
    echo No such command: $1
  elif [[ "file" == $the_type ]]; then
    # readlink -f: Follow all symlinks till the end
    dpkg -S $(readlink -f $(type -p $1)) # NB: avoid `which` in favor of `type -p`! http://stackoverflow.com/a/677212/693538
  else
    # else (if it is not a file) just print the full `type` message, it is informative
    type $1
  fi
}

# man on bash builtin
bashman () { man bash | less -p "^       $1 "; }

# svn
sdi() {
  svn diff $* | colordiff | less -R
}
slo() {
  svn log $* | colordiff | less -R
}


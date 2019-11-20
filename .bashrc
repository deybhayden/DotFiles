#!/bin/bash

# Set PS1
_git_dirty() {
  [[ $(git status --porcelain 2> /dev/null) != "" ]] && echo '*'
}

_git_prompt() {
  local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo " (${ref#refs/heads/}$(_git_dirty))"
  fi
}

_failed_status() {
  [ "$PIPESTATUS" -ne 0 ] && printf "\n$"
}

_success_status() {
  [ "$PIPESTATUS" -eq 0 ] && printf "\n$"
}

export PS1='\[\e[1;32m\]\u@\h\[\e[m\] \[\e[0;33m\]\w\[\e[0;36m\]$(_git_prompt)\[\e[1;31m\]$(_failed_status)\[\e[1;34m\]$(_success_status)\[\e[m\] '

# Load bash completions
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  # Make sure git completions are loaded
  command -v __git_complete > /dev/null || . /usr/share/bash-completion/completions/git
fi

# Eternal Bash History
## No dupes
export HISTCONTROL=ignoreboth:erasedups
## Undocumented feature which sets the size to "unlimited".
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%F %T "
## Change the file location because certain bash sessions truncate .bash_history file upon close.
export HISTFILE=~/.bash_eternal_history
## Force prompt to write history after every command.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Solarized colors
if [[ "$COLORFGBG" == "11;15" ]]; then
  # dircolors
  eval `dircolors "$HOME/.dircolors-light"`
  # Light
  export FZF_DEFAULT_OPTS='
    --color=bg+:#eee8d5,bg:#fdf6e3,spinner:#2aa198,hl:#268bd2
    --color=fg:#657b83,header:#268bd2,info:#b58900,pointer:#2aa198
    --color=marker:#2aa198,fg+:#073642,prompt:#b58900,hl+:#268bd2
  '
else
  eval `dircolors "$HOME/.dircolors-dark"`
  # Dark
  export FZF_DEFAULT_OPTS='
    --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
    --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
    --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07
  '
fi

# Set Git Repos location if it isn't set
[ -z "$REPO_DIR" ] && export REPO_DIR="$HOME/Repos"

export EDITOR='vim'

# Vim aliases
alias e='vim'
alias v='vim'
alias vm='vim'
alias vmi='vim'
alias vom='vim'
alias es='vim "$HOME/.bashrc"'
alias ev='vim "$HOME/.vimrc"'
alias ea='vim "$HOME"/.bash_aliases'
alias ep='vim "$HOME"/.bash_profile'
alias et='vim "$HOME"/.tmux.conf'
alias em='vim "$HOME"/.local/bin/macsimus.sh'

# Directory alieases
alias src='source "$HOME/.bash_profile"'
alias .f='cd "$REPO_DIR/DotFiles/"'
alias .v='cd "$REPO_DIR/DotFiles/.vim/"'
alias rep='cd "$REPO_DIR/"'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Misc.
alias ls="ls --color=tty"
alias ll="ls -hal --color=tty"
alias cO="curl -L -O"
alias randstr="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1"
alias tax="tmux attach-session"

if [[ $TMUX ]]; then
  alias ssh="TERM=screen-256color ssh"
fi

rpg() {
  # ripgrep with a pager, retain formatting
  rg $1 -p | less -R
}

# python
alias ip="ipython"
alias pylab="ipython --pylab"
pyserve() {
  [ `command -v open` ] && open "http://0.0.0:8000/"
  python -m http.server
}

# fzf configuration
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --color=never'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind -x '"\ep": vim $(fzf --height 40% --reverse);'

# Git utilities
alias g="git"
complete -o bashdefault -o default -o nospace -F _git g
alias gst="git status"
alias ga="git add"
__git_complete ga _git_add
alias gc="git commit -v"
__git_complete gc _git_commit
alias gc!="git commit -v --amend"
alias gca!="git commit -v -a --amend"
alias gcan!="git commit -v -a --no-edit --amend"
alias gcf="git commit --fixup="
alias gco="git checkout"
__git_complete gco _git_checkout
alias gcl="git clone"
alias gcp="git cherry-pick"
__git_complete gcp _git_cherry_pick
alias gb="git branch"
__git_complete gb _git_branch
alias gba="git branch -a"
alias gbc="git branch -a --sort=-committerdate --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gp="git push"
__git_complete gp _git_push
alias gd="git diff"
__git_complete gd _git_diff
alias gdc="git diff --cached"
__git_complete gdc _git_diff
alias gl="git pull"
__git_complete gl _git_pull
alias glg="git log --stat"
alias glgp="git log --stat -p"
alias gclean='git clean -fd'
alias gr='git remote'
__git_complete gr _git_remote
alias gra='git remote add'
alias grb='git rebase'
__git_complete grb _git_rebase
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
__git_complete grbi _git_rebase
alias grbs='git rebase --skip'
alias grh='git reset HEAD'
alias gsta='git stash'
alias gstp='git stash pop'
alias gsub='git submodule update --remote --merge'
alias gg='git grep'
__git_complete gg _git_grep

gca() {
  git add -A
  git commit "$@"
}

gbd() {
  prefix="origin/"
  branch="${1#$prefix}"
  if git rev-parse --quiet --verify $branch > /dev/null; then
    git branch -D $branch
  fi
  if git ls-remote --exit-code --heads origin $branch > /dev/null; then
    git push origin -d $branch
  fi
}
__git_complete gbd _git_branch

gbu() {
  git branch --set-upstream-to="$1"
}
__git_complete gbu _git_branch

ggp() {
  git push --force-with-lease origin $(git rev-parse --abbrev-ref HEAD)
}

gsmash() {
  git add -A
  git commit -v --no-edit --amend
  ggp
}

gl-repos() {
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color
  for d in $(ls "$REPO_DIR"); do
    (
      printf "\n${GREEN}== $d ==${NC}\n"
      cd "$REPO_DIR/$d"
      gl
    )
  done
}

gst-repos() {
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color
  for d in $(ls "$REPO_DIR"); do
    (
      printf "\n${GREEN}== $d ==${NC}\n"
      cd "$REPO_DIR/$d"
      gst
    )
  done
}

# Docker aliases
alias d='docker'
complete -F _docker d
alias db='docker build'
alias dr='docker run'
alias di='docker images'
complete -F _docker_images di
alias dri='docker rmi $(docker images -f "dangling=true" -q)'
alias drc='docker rm $(docker ps -f "status=exited" -q)'
alias dp='docker ps'
complete -F _docker_container_ls dp
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcb="docker-compose build"

# If there are custom aliases, load them
if [[ -f $HOME/.bash_aliases ]] ; then
  . "$HOME/.bash_aliases"
fi

# Clear last status
true

# vim:set ft=sh et sw=2:

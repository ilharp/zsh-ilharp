export EDITOR='vim'

alias c='clear'
alias e='exit'

# Git
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias grm='git rm --cached'
alias grma="git rm --cached '*'"

alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcmsg='git commit -m'

alias gd='git diff'
alias gda='git diff --cached'

alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'

alias gr="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%Creset - %C(auto)%d%Creset %s %Creset%C(bold green)(%ar)%Creset %C(dim white)- %an' --all"

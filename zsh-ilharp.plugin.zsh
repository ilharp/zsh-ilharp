export EDITOR='vim'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias c='clear'
alias e='exit'

# Git
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gai='git add -i'
alias grma="git rm '**'"
alias grmac="git rm --cached '**'"

alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcmsg='git commit -m'

# alias gd='git diff'
# git diff with untracked
gd() {
  (
    git diff --color
    git ls-files --others --exclude-standard |
      while read -r i; do git diff --color -- /dev/null "$i"; done
  ) | less
}
alias gdt='git diff'
alias gda='git diff --cached'

alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'

alias gr="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%Creset - %C(auto)%d%Creset %s %Creset%C(bold green)(%ar)%Creset %C(dim white)- %an' --all"

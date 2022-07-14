
# Set default editor
export EDITOR='vim'

# Set language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Get root dir of zsh-ilharp
ZSH_ILHARP_ROOT=$(dirname "$0")

# Export ohmyzsh root dir
export ZSH=${ZSH_ILHARP_ROOT}/bundles/oh-my-zsh

# Load the oh-my-zsh's library
# antigen use oh-my-zsh

# Load bundles
builtin source ${ZSH_ILHARP_ROOT}/bundles/oh-my-zsh/oh-my-zsh.sh
builtin source ${ZSH_ILHARP_ROOT}/bundles/zsh-autocomplete/zsh-autocomplete.plugin.zsh
builtin source ${ZSH_ILHARP_ROOT}/bundles/zsh-completions/zsh-completions.plugin.zsh
builtin source ${ZSH_ILHARP_ROOT}/bundles/powerlevel10k/powerlevel10k.zsh-theme

# Load configs
builtin source ${ZSH_ILHARP_ROOT}/config-zstyle.zsh
builtin source ${ZSH_ILHARP_ROOT}/config-p10k.zsh

# Common alias
alias c='clear'
alias e='exit'

# Git alias
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gai='git add -i'
alias grma="git rm '**'"
alias grmac="git rm --cached '**'"

alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcmsg='git commit -m'

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

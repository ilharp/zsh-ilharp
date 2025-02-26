
# Set default editor
export EDITOR='vim'

# Enable less mouse support
# export LESS='-FRSX --mouse --wheel-lines 3'
export LESS='-FRS'

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
builtin source ${ZSH_ILHARP_ROOT}/bundles/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
builtin source ${ZSH_ILHARP_ROOT}/bundles/zsh-completions/zsh-completions.plugin.zsh
builtin source ${ZSH_ILHARP_ROOT}/bundles/powerlevel10k/powerlevel10k.zsh-theme

# Load configs
builtin source ${ZSH_ILHARP_ROOT}/config-p10k.zsh

# kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
alias k='kubectl'

# Helm
[[ $commands[helm] ]] && source <(helm completion zsh)

# dotnet
_dotnet_zsh_complete()
{
  local completions

  if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    # Use 'tr' to replace \r\n to \n, then use grep to remove empty line
    completions=("$(dotnet complete "$words" | tr '\r\n' '\n' | grep -v '^$')")
  else
    completions=("$(dotnet complete "$words")")
  fi

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet

# rustup
export RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"
export RUSTUP_UPDATE_ROOT="https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup"

# Common alias
alias c='clear'
alias e='exit'

# Git alias
alias g='git status'
alias gst='g'
alias ga='git add'
alias gaa='git add --all'
alias gai='git add -i'
alias grma="git rm '**'"
alias grmac="git rm --cached '**'"

alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcmsg='git commit -m'

alias gcnm='git commit --allow-empty -m "chore: build"'
alias gcnmsg='git commit --allow-empty -m'

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
alias gfl='git fetch && git pull'
alias gfgl='gfl'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias glg='git log'

alias gsu='git submodule update --init --recursive'

alias gr="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(auto)%d%C(reset) %s %C(bold green)(%aD, %ar)%C(reset) %C(dim white)- %an'"
alias gra="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(auto)%d%C(reset) %s %C(bold green)(%aD, %ar)%C(reset) %C(dim white)- %an' --all"

[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh

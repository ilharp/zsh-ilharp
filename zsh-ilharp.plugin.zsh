
# Set default editor
export EDITOR='vim'

# Enable less mouse support
# export LESS='-FRSX --mouse --wheel-lines 3'
export LESS='-FRS'

# Set language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Get root dir of zsh-ilharp
ZSH_ILHARP_ROOT="${0:A:h}"

# Export ohmyzsh root dir
export ZSH=${ZSH_ILHARP_ROOT}/bundles/oh-my-zsh

# Load bundles
builtin source ${ZSH_ILHARP_ROOT}/bundles/zsh-completions/zsh-completions.plugin.zsh
builtin source ${ZSH_ILHARP_ROOT}/bundles/oh-my-zsh/oh-my-zsh.sh
builtin source ${ZSH_ILHARP_ROOT}/bundles/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
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

# Homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_PIP_INDEX_URL="https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"

# Common alias
alias c='clear'
alias e='exit'

# Git alias
alias g='git status'
alias ga='git add'
alias gaa='git add --all'
alias gai='git add -i'

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
alias gl='git fetch && git merge --ff-only'
alias gp='git push'

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcp='git cherry-pick'

alias gsu='git submodule update --init --recursive'

alias gr="git log --graph --date-order --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(auto)%d%C(reset) %s %C(bold blue)(%aD, %ar)%C(reset) %C(dim white)- %an'"
alias gra="git log --graph --date-order --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(auto)%d%C(reset) %s %C(bold blue)(%aD, %ar)%C(reset) %C(dim white)- %an' --all"
alias grr="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(auto)%d%C(reset) %s %C(bold blue)(%aD, %ar)%C(reset) %C(dim white)- %an'"
alias grra="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(auto)%d%C(reset) %s %C(bold blue)(%aD, %ar)%C(reset) %C(dim white)- %an' --all"

[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh

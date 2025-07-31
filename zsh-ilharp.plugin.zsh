
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

# Remove homebrew provided completions
# From https://stackoverflow.com/a/77774885
if [[ $commands[brew] ]]
then
  # ------ Homebrew ZSH functions (for just + others)
  # This will bring autocomplete for brew installed functions (exa, just, k6, etc)
  # These will overwrite the oh-my-zsh plugins that conflict (like `git`)
  # https://github.com/casey/just#shell-completion-scripts

  # Init Homebrew, which adds environment variables
  eval "$(brew shellenv)"

  remove_conflicting_git_completions() {
      local git_completion_bash="$HOMEBREW_PREFIX/share/zsh/site-functions/git-completion.bash"
      local git_completion_zsh="$HOMEBREW_PREFIX/share/zsh/site-functions/_git"

      [ -e "$git_completion_bash" ] && rm "$git_completion_bash"
      [ -e "$git_completion_zsh" ] && rm "$git_completion_zsh"
  }

  # Delete the brew version of `git` completions because the built in ZSH
  # ones are objectively better (and work with aliases)
  # The reason this runs every time is because brew re-adds these files
  # on `brew upgrade` (and other events)
  remove_conflicting_git_completions

  # Add Homebrew's site functions to fpath (minus git, because that causes conflicts)
  # https://github.com/orgs/Homebrew/discussions/2797
  # https://github.com/ohmyzsh/ohmyzsh/issues/8037
  # https://github.com/ohmyzsh/ohmyzsh/issues/7062
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

  # Needed for autosuggestions (does compinit)
  source $ZSH/oh-my-zsh.sh
fi

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

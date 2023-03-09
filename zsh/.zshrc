# dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# Compilation flags
#export ARCHFLAGS="-arch -arm64"

# source .zshenv and .zshrc
alias sz="source $HOME/.dotfiles/zsh/.zshenv && source $HOME/.dotfiles/zsh/.zshrc && echo "$HOME/.dotfiles/zsh/.zshenv and .zshrc sourced""

# pnpm
alias cocka="pnpm update -g"

# nvim
alias nvim="arch -arm64 nvim"

# brew
alias booba="arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && brew cleanup -s"
alias boocka="booba && cocka"
alias bdump="brew bundle dump --describe -f" # create bundle
alias bdinstall="arch -arm64 brew bundle --no-lock" # install from dump

alias bree="arch -arm64 brew install"

# jino
alias jino="ssh -p 49436 strash@ovz2.strash.pr46m.vps.myjino.ru"

alias l="ls -laG"

alias cd="pushd"

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select interactive search
zstyle ':completion:*' list-prompt %S %p %s
zstyle ':completion:*' select-prompt %S %p %s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' complete-options true

zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' keep-prefix true

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}%D %d%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}%d (errors: %e)%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple}%d%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}feck%f'

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit

fpath+=$HOME/.zfunc

compinit
# End of lines added by compinstall

# Prompt theme
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '[%F{white}%b|%a%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' formats '[%F{white}%b%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' branchformat '[%F{white}%b:%r%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' hgrevformat '[%F{white}%r:%h%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr ●
zstyle ':vcs_info:*' unstagedstr ●
precmd() { vcs_info }
setopt prompt_subst
PS1='%F{white}%B%n%b %f %~ ${vcs_info_msg_0_}%(?00%F{red}feck %f)'

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

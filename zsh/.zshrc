# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

# dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# Compilation flags
#export ARCHFLAGS="-arch -arm64"

# source .zshenv and .zshrc
alias sz="source $HOME/.dotfiles/zsh/.zshenv && source $HOME/.dotfiles/zsh/.zshrc && echo '.zshenv and .zshrc are sourced at path $HOME/.dotfiles/zsh/'"

# pnpm
alias cocka="bun update -g"

# firebase
alias firebase_update="curl -sL https://firebase.tools | upgrade=true bash"

# brew
alias booba="arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && brew cleanup -s"
alias boocka="booba && cocka"
alias bdump="brew bundle dump --describe -f" # create bundle
alias bdinstall="arch -arm64 brew bundle --no-lock" # install from dump

alias bree="arch -arm64 brew install"

alias l="ls -lahG"

# alias cd="pushd"

###-begin-flutter-completion-###

if type complete &>/dev/null; then
  __flutter_completion() {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           flutter completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F __flutter_completion flutter
elif type compdef &>/dev/null; then
  __flutter_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 flutter completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef __flutter_completion flutter
elif type compctl &>/dev/null; then
  __flutter_completion() {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       flutter completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K __flutter_completion flutter
fi

###-end-flutter-completion-###

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
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}fuck%f'

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit

fpath+=$HOME/.zfunc

compinit
# End of lines added by compinstall

# Prompt theme
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '[%F{grey}%b|%a%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' formats '[%F{grey}%b%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' branchformat '[%F{grey}%b:%r%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' hgrevformat '[%F{grey}%r:%h%f%F{red}%u%F{yellow}%c%f] '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr ●
zstyle ':vcs_info:*' unstagedstr ●
precmd() { vcs_info }
setopt prompt_subst
PS1='%F{grey}%B%n%b%f %~ ${vcs_info_msg_0_}%(?00%F{red}fuck %f)'

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


# bun completions
[ -s "/Users/strash/.bun/_bun" ] && source "/Users/strash/.bun/_bun"

source <(fzf --zsh)

# dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# Path to your oh-my-zsh installation.
#export ZSH="/Users/strash/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="minimal"
CASE_SENSITIVE="true"
export UPDATE_ZSH_DAYS=7
ENABLE_CORRECTION="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

plugins=(git dotnet osx tmux httpie pod)

#source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
#export ARCHFLAGS="-arch -arm64"

# source .zshenv and .zshrc
alias sz="source ~/.dotfiles/zsh/.zshenv && source ~/.dotfiles/zsh/.zshrc && echo '~/.dotfiles/zsh/.zshenv and .zshrc sourced'"

# brew
alias booba="arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && arch -arm64 brew cleanup"
alias boocka="booba && cocka"
alias bdump="brew bundle dump --describe -f" # create bundle
alias bdinstall="arch -arm64 brew bundle --no-lock" # install from dump

# jino
alias jino="ssh -p 49436 strash@ovz2.strash.pr46m.vps.myjino.ru"

# devd
alias server_slow="devd -A 127.0.0.1 -p 8080 -d 114 -u 51 -n 275 ./ -X"
alias server="devd -A 127.0.0.1 -p 8080 ./ -X"

# png minification
# установка imageoptim-cli
# cd
# curl --output imageoptim-cli.tgz https://registry.npmjs.org/imageoptim-cli/-/imageoptim-cli-3.0.7.tgz
# tar -xvzf ./imageoptim-cli.tgz
# rm imageoptim-cli.tgz
# mv ./package ./imageoptim-cli
# установить https://pngmini.com
# установить https://imageoptim.com
alias png="imageoptim -a -S '**/*.png'"

# npm
alias cocka="npm update -g"

# nvim
alias nvim="arch -arm64 nvim"

# luamake
alias luamake=/Users/strash/lua-language-server/3rd/luamake/luamake

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
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/Users/strash/.zshrc'

autoload -Uz compinit
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
PS1='%F{white}%Bstrash%b %f %~ ${vcs_info_msg_0_}$ '


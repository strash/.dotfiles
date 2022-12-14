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
alias boocka="booba && cocka && rustup update"
alias bdump="brew bundle dump --describe -f" # create bundle
alias bdinstall="arch -arm64 brew bundle --no-lock" # install from dump

# jino
alias jino="ssh -p 49436 strash@ovz2.strash.pr46m.vps.myjino.ru"

# devd
alias server_slow="devd -A 127.0.0.1 -p 8080 -d 114 -u 51 -n 275 ./ -X"
alias server="devd -A 127.0.0.1 -p 8080 ./ -X"

alias l="ls -laG"

alias cd="pushd"

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
alias cocka="pnpm update -g"

# nvim
alias nvim="arch -arm64 nvim"

# luamake
alias luamake=/Users/strash/lua-language-server/3rd/luamake/luamake

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/Users/strash/.zshrc'

autoload -Uz compinit

fpath+=~/.zfunc

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
PS1='%F{white}%Bstrash%b %f %~ ${vcs_info_msg_0_}'


# pnpm
export PNPM_HOME="/Users/strash/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

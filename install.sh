#!/bin/zsh

cd ~/.dotfiles

# installing dev tools
echo "> installing dev tools"
xcode-select --install

# installing brew
echo "> installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# installing formulae and casks from brew bundle /wo generating a lock file (guess I don't need it)
echo "> installing formulae and casks from brew bundle /wo generating a lock file (guess I don't need it)"
brew bundle istall --no-lock

# installing oh my zsh
echo "> installing oh my zsh"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --unattended

# remove init.vim because full lua
echo "> removing init.vim for the sake of full lua"
rm ~/.config/nvim/init.vim

# install nvim packer
echo "> installing nvim packer"
mkdir -p ~/.local/share/nvim/site/pack/packer/start
pushd ~/.local/share/nvim/site/pack/packer/start/
git clone https://github.com/wbthomason/packer.nvim.git
nvim --headless -n -c "autocmd User PackerComplete qa" -c "PackerCompile"
nvim --headless -n -c "autocmd User PackerComplete qa" -c "PackerInstall"
popd

# run stow
echo "> run stow"
stow_install.sh

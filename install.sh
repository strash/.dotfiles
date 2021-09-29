#!/bin/zsh

cd ~/.dotfiles

# installing dev tools
echo "> installing dev tools"
xcode-select --install

# installing brew
echo "> installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off

# installing formulae and casks from brew bundle /wo generating a lock file (guess I don't need it)
echo "> installing formulae and casks from brew bundle /wo generating a lock file (guess I don't need it)"
brew bundle install --no-lock

flutter config --no-analytics

# installing oh my zsh
echo "> installing oh my zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

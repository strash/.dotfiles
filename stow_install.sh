#!/bin/zsh

# alacritty
rm ~/.alacritty.yml
stow -v alacritty

# git
rm ~/.gitconfig
stow -v git

# neovim
rm ~/.config/nvim/init.lua
rm -rf ~/.config/nvim/lua
stow -v nvim

# tmux
rm ~/.tmux.conf
stow -v tmux

# zsh
rm ~/.zshenv ~/.zshrc
stow -v zsh

# godot
rm ~/Library/Application\ Support/Godot/editor_settings-3.tres
rm ~/Library/Application\ Support/Godot/script_templates/blocks.gd
stow -v godot

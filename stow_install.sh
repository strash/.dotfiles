#!/bin/zsh

# git
rm $HOME/.gitconfig
stow -R git

# godot
rm $HOME/Library/Application\ Support/Godot/editor_settings-3.tres
rm $HOME/Library/Application\ Support/Godot/script_templates/blocks.gd
stow -R godot

# neovim
rm -rf $HOME/.config/nvim/init.lua $HOME/.config/nvim/lua
stow -R nvim

# wezterm
rm $HOME/.config/wezterm/wezterm.lua
stow -R wezterm

# zsh
rm $HOME/.zshenv $HOME/.zshrc
stow -R zsh


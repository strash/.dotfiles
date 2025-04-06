#!/bin/zsh

# git
rm $HOME/.gitconfig
stow -S git

# godot
# rm $HOME/Library/Application\ Support/Godot/editor_settings-3.tres
# rm $HOME/Library/Application\ Support/Godot/script_templates/blocks.gd
# stow -R godot

# neovim
rm -rf $HOME/.config/nvim/init.lua $HOME/.config/nvim/lua
stow -S nvim

# wezterm
# rm $HOME/.config/wezterm/wezterm.lua
# stow -R wezterm

# zsh
rm $HOME/.zshenv $HOME/.zshrc
stow -S zsh

# ghostty
rm $HOME/.config/ghostty/config
stow -S ghostty

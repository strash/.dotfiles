#!/bin/zsh

rm ~/.alacritty.yml
stow -v alacritty
rm ~/.gitconfig
stow -v git
rm ~/.config/nvim/init.lua
rm -rf ~/.config/nvim/lua
stow -v nvim
rm ~/.tmux.conf
stow -v tmux
rm ~/.zshenv ~/.zshrc
stow -v zsh
rm ~/Library/Application\ Support/Godot/editor_settings-3.tres
rm ~/Library/Application\ Support/Godot/script_templates/blocks.gd
stow -v godot

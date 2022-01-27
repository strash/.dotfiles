#!/bin/zsh

# alacritty
rm ~/.alacritty.yml
stow -R alacritty

# wezterm
rm ~/.config/wezterm/wezterm.lua
stow -R wezterm

# git
rm ~/.gitconfig
stow -R git

# neovim
rm ~/.config/nvim/init.lua
rm -rf ~/.config/nvim/lua
stow -R nvim

# tmux
rm ~/.tmux.conf
stow -R tmux

# zsh
rm ~/.zshenv ~/.zshrc
stow -R zsh

# godot
rm ~/Library/Application\ Support/Godot/editor_settings-3.tres
rm ~/Library/Application\ Support/Godot/script_templates/blocks.gd
stow -R godot

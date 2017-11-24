#!/bin/bash

# install script
dotfiles_dir="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Installing from $dotfiles_dir"


sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.bashrc > /dev/null 2>&1
sudo rm -rf ~/.tmux > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zsh_prompt > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.antigen > /dev/null 2>&1
sudo rm -rf ~/.antigen.zsh > /dev/null 2>&1
sudo rm -rf ~/.psqlrc > /dev/null 2>&1
sudo rm -rf ~/.conkyrc > /dev/null 2>&1
sudo rm -rf ~/.tigrc > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1




ln -sf $dotfiles_dir/vim ~/.vim
ln -sf $dotfiles_dir/vim/.vimrc ~/.vimrc
ln -sf $dotfiles_dir/tmux/.tmux.conf ~/.tmux.conf
ln -sf $dotfiles_dir/zsh/zsh_completion ~/zsh_completion
ln -sf $dotfiles_dir/zsh/.zshrc ~/.zshrc

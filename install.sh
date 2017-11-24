#!/bin/bash

# install script

here=$(dirname $0)

ln -s $here/zsh/.zshrc ~/.zshrc

ln -s $here/.vim ~/.vim

ln -s $here/dircolors-solarized ~/dircolors-solarized

ln -s $here/tmux/.tmux.conf ~/.tmux.conf

ln -s $here/vim/.vimrc ~/.vimrc 
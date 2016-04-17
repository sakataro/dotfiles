#!/bin/sh

ln -Fis ~/dotfiles/.vimrc ~/.vimrc
ln -Fis ~/dotfiles/vimfiles ~/.vim

git clone git://github.com/Shougo/neobundle.vim ~/dotfiles/vimfiles/bundle/neobundle.vim

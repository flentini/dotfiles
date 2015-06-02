#!/bin/bash
echo "setup vim"
rm -rf ~/.vim && cp -rf $PWD/vim ~/.vim && cp -rf $PWD/vim/colors ~/.vim/colors
cp -f $PWD/vim/vimrc ~/.vimrc
if [ ! -d ~/.vim/bundle/vundle ]; then
      git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim +PluginInstall! +qall

#!/bin/bash
echo "setup vim"
rm -rf ~/.vim &&
cp -f $PWD/vimrc ~/.vimrc
if [ ! -d ~/.vim/bundle/vundle ]; then
      git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim +PluginInstall! +qall

unlink ~/.bashrc
ln -s ~/dotfiles/bashrc ~/.bashrc

unlink ~/.zshrc
unlink ~/.zshenv
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/env ~/.zshenv


ln -nfs ~/bin/mvim ~/dotfiles/bin/vim

unlink ~/.vim
unlink ~/.vimrc
unlink ~/.gvimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/gvimrc ~/.gvimrc


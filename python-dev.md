# Python Development Environment Setup

## Install Utilities
```bash
$ [sudo] apt install tmux htop
```

## Setup dotfiles
Copy [.bashrc](.bashrc) and [.vimrc_python](.vimrc_python) to the home directory.
```bash
$ cp dotfiles/.bashrc ~/
$ cp dotfiles/.vimrc_python ~/.vimrc
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Virtual Environment
Always work on virtual environment so that, when you install or update packages, it won't affect other users.
### Install `virtualenv`
```bash
$ [sudo] pip install -U virtualenv
```

### Create a virtual environment
```bash
$ virtualenv --system-site-packages jeong-ve
```

### Activate/use/deactivate the virtual environment
```bash
$ source jeong-ve/bin/activate
(jeong-ve) $ pip install -U <cool-packages-to-try-out>
..
(jeong-ve) $ deactivate
```

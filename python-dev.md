# Python Development Environment Setup

## Install Utilities
```bash
$ [sudo] apt install tmux htop
```

## Setup dotfiles
Copy [.bashrc](.bashrc) and [.vimrc](.vimrc) to the home directory.
```bash
$ cp dotfiles/.bashrc ~/
$ cp dotfiles/.vimrc ~/.vimrc
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Virtual Environment
Always work on virtual environment so that, when you install or update packages, it won't affect other users.

### Using `conda`
```bash
# Install miniconda. Instruction is available at https://conda.io/projects/conda/en/latest/user-guide/install/index.html
# Create a new virtual environment
$ conda create -n py37 python=3.7
# Activate the virtual environment
$ conda activate py37
(py37) $ pip install -U [packages to install]
...
# Deactivate the virtual environment
(py37) $ deactivate
```

### Using `virtualenv`
```bash
# Install virtualenv using pip if needed
$ [sudo] pip install -U virtualenv
# Create a new virtual environment
$ virtualenv --python=[path to Python binary. e.g. /usr/bin/python3.7] py37
# Activate the virtual environment
$ source py37/bin/activate
(py37) $ pip install -U [packages to install]
..
# Deactivate the virtual environment
(py37) $ deactivate
```

## Jupyter Notebook on a Remote Server

### From a remote server

```bash
# Install Jupyter Notebook
$ pip install jupyter
# Install Jupyter Notebook extensions
$ pip install jupyter_contrib_nbextensions
$ jupyter nbextensions_configurator enable --user
or
$ conda install -c conda-forge jupyter_contrib_nbextensions
# Run Jupyter Notebook
$ jupyter notebook --no-browser --port 12345
```

### From the local machine
```bash
$ ssh -N -f -L localhost:12345:localhost:12345 username@remote_server
```
Then open the browser on the local machine and go to localhost:12345

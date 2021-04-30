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

## Setup CUDA/cuDNN for GPU
The easiest way to set up the CUDA/cuDNN environment for GPU is either using the NVidia docker or `conda` environment.

### Using `conda`

1. Create an `environment.yml`
```
name: tf2.4 

channels:  
  - nvidia
  - conda-forge
  - defaults
  - pytorch
  
dependencies:  
  - cudatoolkit=11.0.221
  - cudnn=8.0.4
  - pip=20.0
  - python=3.7
  - jupyterlab
  - pytorch
  - torchvision
  - torchaudio
  - pip:
    - tensorflow-gpu==2.4.1
```
2. Create a `conda` virtual environment
```bash
$ conda env create
```
3. Add the environment to the Jupyter notebook
```bash
$ conda activate tf2.4
$ pip install ipykernel
$ python -m ipykernel install --user --name tf2.4 --display-name "Python 3.7 (TF2.4)"    
```
4. If you want to remove the Jupyter notebook kernel:
```bash
# List all kernels and grap the name of the kernel you want to remove
$ jupyter kernelspec list
# Remove it
$ jupyter kernelspec remove <kernel_name>

```

### Using the NVidia docker image
Follow the instruction from the Tensorflow website [here](https://www.tensorflow.org/install/docker)

### Troubleshooting

1. Could not load dynamic library `libcusolver.so.11` with `cudatoolkit=11.0`: create a symlink from an existing `libcusolver.so.XX` to `libcusolver.so.11`. If you used `conda` to create a TF + CUDA + cuDNN environment, CUDA libraries are in `[conda install path]/envs/[environment name]/lib` instead of `/usr/lib/cuda/lib64/`.

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

### Troubleshooting

#### channel 2: open failed: administratively prohibited: open failed

1. check if you have `127.0.0.1 localhost` in `/etc/hosts/`
2. check if `AllowTcpForwarding` is set to `yes`
3. check if `PermitOpen` is set to `any`

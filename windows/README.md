# Setup for ML Development on Windows

As of 11/2020, I recommend two options: (1) using WSL2 or (2) using native Windows with Git bash. WSL2 provides **almost** seamless experience similar to native Linux, but might have an issue with VPN. If you don't need the full VPN connection, it can be a great choice. However, if you need VPN, and face an issue with WSL2, you can use native Windows with Git bash.

## Set up Windows Terminal

Windows Terminal allows users to switch between multiple command line interfaces such as PowerShell, WSL1/2, Git Bash, Anaconda, etc.

* Install Windows Terminal with the [Install Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started) guide
* Install the Casadia Code PL font with the [Installing-Cascadia-Code](https://github.com/microsoft/cascadia-code/wiki/Installing-Cascadia-Code) guide
* Set up the Powerline for Windows Terminal and VS Code with the [Set up Powerline in Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup) tutorial

# Using Bash on Windows Subsystem for Linux 2 (WSL2)
Bash on WSL allows to use Ubuntu on Windows without virtual machine. For details, check out [introduction page](https://msdn.microsoft.com/en-us/commandline/wsl/about).

## Install WSL and update to WSL2
Follow [installation guide](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide) on MSDN.

## Install the latest Windows build from the Windows Insider Program
Follow [getting started with Windows Insider Program](https://insider.windows.com/en-us/getting-started#install) guide to install the build version 20145 or higher.

## Install CUDA 10.1 on WSL2
Follow the [CUDA on WSL](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#installing-wip) guide.

* Download the latest NVidia driver for WSL from [here](https://developer.nvidia.com/cuda/wsl)
* Update WSL2 and install CUDA toolkit
```bash
$ sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
$ sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
$ sudo apt-get update
$ sudo apt-get install -y cuda-toolkit-10-1
```

## Run NVidia Docker Container on WSL2
Follow the [Setting up to Run Containers](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#setting-containers) guide.

:warning: If `libcublas.so.10` can't be found, install it as follows:
```bash
$ sudo apt-get install --reinstall libcublas10
```
and add the following line to `~/.bashrc`:
```
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-10.2/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
```

## Monitor GPU Usage
:warning: WSL doesn't support `nvida-smi`. You can check the GPU usage from Task Manager > Performance > GPU instead.

## Install and Set up VSCode for WSL2
* Install VSCode on Windows as usual ([download link](https://code.visualstudio.com/download))
* Install the [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) VSCode extension
* Run VSCode within WSL2 as follows:
```
$ code .
```

# Using Native Windows with Git Bash

* Install Visual Studio form the [Microsoft website](https://visualstudio.microsoft.com/) if you haven't. The community version is free.
* Install CUDA Toolkit 10.1 from the [NVidia website](https://developer.nvidia.com/cuda-10.1-download-archive-base).
* Download and install cuDNN 7.6.5 from the [NVidia website](https://developer.nvidia.com/rdp/cudnn-archive). You need the NVidia Developer membership, which is free. Installation guide is available [here](https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#install-windows)
* Install Git Bash from [here](https://gitforwindows.org/)
* Install Anaconda Individual Edition from the [Anaconda website](https://www.anaconda.com/products/individual)
* Add Git Bash to Windows Terminal by following the instruction [here](https://medium.com/@techpreacher/using-git-bash-with-the-microsoft-terminal-bd1f71fa17a1)
* Run `%USERPROFILE%\\anaconda3\\Scripts\\conda init bash` from Git Bash

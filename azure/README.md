# Azure Setup

## General
From [Quickstart for using the Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/quickstart):
If you haven't, you need to create a storage account and Azure file share on the Azure Cloud Shell.
* Launch Cloud Shell from the top navigation of the [Azure portal](https://ms.portal.azure.com).
* Choose the subscription you want to use and create a storage account.

### Azure CLI
From [Get Started with Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli):

* Install Azure CLI 2.0
```bash
$ echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
$ sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
$ sudo apt update 
$ sudo apt install apt-transport-https
$ sudo apt-get install azure-cli
```
* Login to your account It will show a code and ask to authenticate by entering the code on https://aka.ms/devicelogin.
```bash
$ az login
```
* Set your subscription
```bash
$ az account list
$ az account set --subscription "name of the preferred subscription"
```

### AzCopy
From [AzCopy on Linux](https://docs.microsoft.com/en-us/azure/storage/storage-use-azcopy-linux):
AzCopy on Linux is a command-line utility designed for copying data to and from Microsoft Azure Blob and File storage using simple commands with optimal performance.
* Install .NET Core.
:exclamation: Starting in AzCopy 7.2 version, the .NET Core dependencies are packaged with the AzCopy package. If you use 7.2 version or later, you no longer need to install .NET Core as a pre-requisite.
```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update
sudo apt-get install dotnet-sdk-2.0.2
```
* Download and install AzCopy.
```bash
wget -O azcopy.tar.gz https://aka.ms/downloadazcopylinux64
tar -xf azcopy.tar.gz
sudo ./install.sh
```

## Virtual Machine
There are two types of GPU VMs on Azure: NV with M60 and NC with K80. M60 is faster (see [DL Benchmarks between P100, K80 and M40](https://www.microway.com/hpc-tech-tips/deep-learning-benchmarks-nvidia-tesla-p100-16gb-pcie-tesla-k80-tesla-m40-gpus/).

### Data Science Virtual Machine for Ubuntu
See [Provision DS VM for Ubuntu](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/machine-learning/machine-learning-data-science-dsvm-ubuntu-intro.md)

* Change permission for `/anaconda`
```bash
$ sudo chown -R <username> /anaconda
```
* Activate python 2.7 or 3.5 environment
```bash
$ source /anaconda/bin/activate root	# for python 2.7
$ source /anaconda/bin/activate py35	# for python 3.5
```
* Upgrade pip packages with [requirements.txt](./reauirements.txt) and CNTK installation URL at [Setup Linux Python](https://docs.microsoft.com/en-us/cognitive-toolkit/Setup-Linux-Python)
```bash
$ pip install -r requirements.txt
$ pip install -U --no-deps https://cntk.ai/PythonWheel/GPU/cntk-2.0-cp35-cp35m-linux_x86_64.whl
```
* Install PyTorch using conda
```bash
$ conda install pytorch torchvision cuda80 -c soumith
```

### Azure ML Workbench
* Configuring a remote docker
```bash
$ az ml computetarget attach remotedocker --name "remotevm" --address "remotevm_IP_address" --username "sshuser" -K
$ az ml experiment prepare -c remotevm
$ az ml experiment submit --run-configuration remotevm iris_sklearn.py 0.1
```

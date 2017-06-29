# Setup for ML Development on Windows

## Using Native Windows

### Install CUDA
Check out the [CUDA installation guide for Windows](http://docs.nvidia.com/cuda/cuda-installation-guide-linux/#axzz4VZnqTJ2A).
* Download CUDA 8.0 toolkit from https://developer.nvidia.com/cuda-downloads.
* Install CUDA 8.0 toolkit. For GTX 10X0, select No to install NVidia driver 376.

For GTX 10X0, you need to use the NVidia driver >= 381.09.
* Open Windows Device Manager, find the NVidia device under Display.
* Click the NVidia device and update its driver.

You can validate CUDA installation with following commands:
```
> nvcc -V
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2016 NVIDIA Corporation
Built on Mon_Jan__9_17:32:33_CST_2017
Cuda compilation tools, release 8.0, V8.0.60
```

### Install cuDNN 5.1
* Download cuDNN from https://developer.nvidia.com/cudnn. You need to sign up for membership if you haven't.
* Extract the archive and copy files to `%CUDA_PATH%` (e.g. `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0`)

### Download and install Python 3.5.2
TensorFlow supports only Python 3.5.x on Windows. You can download Python 3.5.2 at https://www.python.org/downloads/release/python-352/.

### Download and install NumPy and SciPy
Keras requires SciPy. On Windows, SciPy and NumPy can be best installed from pre-built binaries at http://www.lfd.uci.edu/~gohlke/pythonlibs/.
* Download NumPy+MKL binary from http://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy
* Download SciPy+MKL binary from http://www.lfd.uci.edu/~gohlke/pythonlibs/#sciupy
```
> pip install <numpy-binary>
> pip install <scipy-binary>
```

### Install TensorFlow with GPU
Upgrade `pip`
```
> pip install -U pip
```

Install TensorFlow with GPU
```
> pip install -U tensorflow-gpu
```

## Install CNTK with GPU
Find a right URL for your Python version and CPU at CNTK's [Setup Windows Python](https://docs.microsoft.com/en-us/cognitive-toolkit/setup-windows-python) page.
```
> pip install <url>
```

### Install Keras
Install dependencies (PyYAML, and h5py).
* Download and install the PyYAML installer at http://pyyaml.org/wiki/PyYAML
```
> pip install -U h5py
```

Install latest Keras from github.
```
> git clone https://github.com/fchollet/keras.git
> cd keras
> python setup.py install
```

To change the Keras backend, edit `backend` in `%USERPROFILE%/.keras/keras/json`:
```
{
    "floatx": "float32",
    "image_data_format": "channels_last",
    "epsilon": 1e-07,
    "backend": "cntk"			# or "tensorflow"/"theano"
}
```

Test installation with example codes:
```
> python .\mnist_mlp.py
Using CNTK backend.
Downloading data from https://s3.amazonaws.com/img-datasets/mnist.npz
10534912/11490434 [==========================>...] - ETA: 0s60000 train samples
10000 test samples
_________________________________________________________________
Layer (type)                 Output Shape              Param #
=================================================================
dense_1 (Dense)              (None, 512)               401920
_________________________________________________________________
dropout_1 (Dropout)          (None, 512)               0
_________________________________________________________________
dense_2 (Dense)              (None, 512)               262656
_________________________________________________________________
dropout_2 (Dropout)          (None, 512)               0
_________________________________________________________________
dense_3 (Dense)              (None, 10)                5130
=================================================================
Total params: 669,706
Trainable params: 669,706
Non-trainable params: 0
_________________________________________________________________
Train on 60000 samples, validate on 10000 samples
Epoch 1/20
2017-06-28 18:04:04.448188: I c:\tf_jenkins\home\workspace\release-win\m\windows-gpu\py\35\tensorflow\core\common_runtime\gpu\gpu_device.cc:940] Found device 0 with proper
ties:
name: GeForce GTX 1060
major: 6 minor: 1 memoryClockRate (GHz) 1.6705
pciBusID 0000:01:00.0
Total memory: 6.00GiB
Free memory: 4.99GiB
2017-06-28 18:04:04.448388: I c:\tf_jenkins\home\workspace\release-win\m\windows-gpu\py\35\tensorflow\core\common_runtime\gpu\gpu_device.cc:961] DMA: 0
2017-06-28 18:04:04.450278: I c:\tf_jenkins\home\workspace\release-win\m\windows-gpu\py\35\tensorflow\core\common_runtime\gpu\gpu_device.cc:971] 0:   Y
2017-06-28 18:04:04.450995: I c:\tf_jenkins\home\workspace\release-win\m\windows-gpu\py\35\tensorflow\core\common_runtime\gpu\gpu_device.cc:1030] Creating TensorFlow devic
e (/gpu:0) -> (device: 0, name: GeForce GTX 1060, pci bus id: 0000:01:00.0)
60000/60000 [==============================] - 67s - loss: 0.2441 - acc: 0.9246 - val_loss: 0.1033 - val_acc: 0.9674
Epoch 2/20
60000/60000 [==============================] - 2s - loss: 0.1013 - acc: 0.9693 - val_loss: 0.0854 - val_acc: 0.9744
...
Epoch 20/20
60000/60000 [==============================] - 2s - loss: 0.0179 - acc: 0.9955 - val_loss: 0.1265 - val_acc: 0.9835
Test loss: 0.126466653087
Test accuracy: 0.9835
```

## Using Bash on Windows Subsystem for Linux (WSL)
Bash on WSL allows to use Ubuntu on Windows without virtual machine. For details, check out [introduction page](https://msdn.microsoft.com/en-us/commandline/wsl/about).

:warning: On WSL, you cannot access GPU. If you need GPU (e.g. for Deep Learning), see [Using Native Windows](#using-native-windows).

### Install Bash on WSL
Follow [installation guide](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide) on MSDN.

### Run the Setup Script for WSL
Run [setup-wsl.sh](setup-wsl.sh).
```
$ sudo bash setup-wsl.sh
```

## CUDA installation guide:
Check out the [CUDA installation guide for Windows](http://docs.nvidia.com/cuda/cuda-installation-guide-linux/#axzz4VZnqTJ2A).

## Download and install CUDA 8.0
* Download CUDA 8.0 toolkit from https://developer.nvidia.com/cuda-downloads.
* Install CUDA 8.0 toolkit. For GTX 10X0, select No to install NVidia driver 376.

For GTX 10X0, you need to update NVidia driver with 381.09.
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

## Install cuDNN 5.1
Download cuDNN from https://developer.nvidia.com/cudnn. You need to sign up for membership if you haven't.

## Download and install Python 3.5.2
TensorFlow supports only Python 3.5.x. You can download Python 3.5.2 at https://www.python.org/downloads/release/python-352/.

## Install TensorFlow with GPU
Upgrade pip
```
> pip install -U pip
```

Install TensorFlow with GPU
```
> pip install -U tensorflow-gpu
```

## Install Keras
Install dependencies (SciPy, PyYAML, and h5py)
* Download and install the PyYAML installer at http://pyyaml.org/wiki/PyYAML
* Download a pre-built Windows installer for Scipy from http://www.lfd.uci.edu/~gohlke/pythonlibs/
```
> pip install scipy-0.19.1-cp35-cp35m-win_amd64.whl
> pip install -U h5py
```

Install Keras
```
> git clone https://github.com/fchollet/keras.git
> cd keras
> python setup.py install
```
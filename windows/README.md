# Setup for ML Development on Windows

## Using Bash on Windows Subsystem for Linux 2 (WSL2)
Bash on WSL allows to use Ubuntu on Windows without virtual machine. For details, check out [introduction page](https://msdn.microsoft.com/en-us/commandline/wsl/about).

### Install WSL and update to WSL2
Follow [installation guide](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide) on MSDN.

### Install the latest Windows build from the Windows Insider Program
Follow [getting started with Windows Insider Program](https://insider.windows.com/en-us/getting-started#install) guide to install the build version 20145 or higher.

### Install CUDA on WSL2
Follow the [CUDA on WSL](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#installing-wip) guide.

* Download the latest NVidia driver for WSL from [here](https://developer.nvidia.com/cuda/wsl)

### Run the Setup Script for WSL
Run [setup-wsl.sh](setup-wsl.sh).
```
$ sudo bash setup-wsl.sh
```

## Using Native Windows

### Install Visual Studio
Download and install Visual Stuido at https://www.visualstudio.com/.

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
    "backend": "cntk"						# or "tensorflow"/"theano"
}
```
Not surprisingly, CNTK is faster than TensorFlow on Windows. For performance comparisons on Ubuntu, check out [Keras Backend Benchmark](https://github.com/szilard/benchm-dl/blob/master/keras_backend.md).

Test installation with example codes:
```
> python .\mnist_mlp.py
Using CNTK backend
Selected GPU[0] GeForce GTX 1060 as the process wide default device.
60000 train samples
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
C:\Program Files\Python35\lib\site-packages\cntk\core.py:351: UserWarning: your data is of type "float64", but your input variable (uid "Input67") expects "<class 'numpy.fl
oat32'>". Please convert your data beforehand to speed up training.
  (sample.dtype, var.uid, str(var.dtype)))
60000/60000 [==============================] - 3s - loss: 0.2442 - acc: 0.9251 - val_loss: 0.1034 - val_acc: 0.9689
Epoch 2/20
60000/60000 [==============================] - 2s - loss: 0.1022 - acc: 0.9692 - val_loss: 0.0739 - val_acc: 0.9755
...
Epoch 20/20
60000/60000 [==============================] - 2s - loss: 0.0168 - acc: 0.9959 - val_loss: 0.1136 - val_acc: 0.9838
Test loss: 0.113552630741
Test accuracy: 0.9838
```

### Install LightGBM
Download and install cmake at https://cmake.org/download/.

Install LightGBM from GitHub:
```
> git clone --recursive https://github.com/Microsoft/LightGBM
> cd LightGBM
> mkdir build
> cd build
> cmake -DCMAKE_GENERATOR_PLATFORM=x64 ..
> cmake --build . --target ALL_BUILD --config Release
> cd ..python-package
> python setup.py install
```


## Using Anaconda
If you don't need latest versions of ML packages and tools, this is easiest way to get started.

Download and install Anaconda at https://www.continuum.io/downloads.

## CUDA installation guide:
http://docs.nvidia.com/cuda/cuda-installation-guide-linux/#axzz4VZnqTJ2A
```
$ lspci | grep -i nvidia
$ uname -m && cat /etc/*release
$ gcc --version
```

## Install LINUX headers
```
$ sudo apt install linux-headers-$(uname -r)
```

## Download and install CUDA 8.0
For GTX 1080 Ti, select No to install NVidia driver 376.
```
$ wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
$ sudo sh cuda_8.0.61_375.26_linux-run
```

For GTX 1080 Ti, you need to install NVidia driver 381.09 manually
```
$ sudo add-apt-repository ppa:graphics-drivers/ppa
$ sudo apt update
$ sudo apt -y install nvidia-381
```

If the installation fails, remove X lock in /tmp.

## Disable Nouveau if a command below displays anything:
```
$ lsmod | grep nouveau
```

Create a file at /etc/modprobe.d/blacklist-nouveau.conf with the following # contents:
```
blacklist nouveau
options nouveau modeset=0
```
Then regenerate the kernel initramfs:
```
$ sudo update-initramfs -u
```

## Install cuDNN 5.1
Download cuDNN from https://developer.nvidia.com/cudnn
```
$ sudo cp include/cudnn.h /usr/local/cuda/include
$ sudo cp -P lib64/libcudnn* /usr/local/cuda/lib64/
$ sudo chmod a+r /usr/local/cuda/include/cudnn.h
$ sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
```

## Install NVIDIA CUDA Profile Tools
```
$ sudo apt install libcupti-dev
```

## Install python3.6 on ubuntu 16.04
* You need to have python3.5 installed. 
Instructions to install python3.6 using PPA [reference link](https://askubuntu.com/questions/865554/how-do-i-install-python-3-6-using-apt-get)
  ```
  $ sudo add-apt-repository ppa:deadsnakes/ppa
  $ sudo apt-get update
  $ sudo apt-get install python3.6
  ```
  * Start virtual-env if you are using other versions as well `$ virtualenv -p /usr/bin/python3.6 my_venv_python36`
* Once you run `sudo apt-get update`, you may need to re-install your NVIDIA drivers and CUDA.
  * you can check the status by `$ nvidia-smi`
* To re-install NVIDIA Drivers and CUDA remove already installed cuda completely [reference link](https://askubuntu.com/questions/206283/how-can-i-uninstall-a-nvidia-driver-completely)
  ```
  $ sudo /usr/local/cuda-X.Y/bin/uninstall_cuda_X.Y.pl
  $ sudo apt-get --purge remove cuda-X.Y
  $ sudo apt-get install ubuntu-desktop
  $ sudo apt-get purge nvidia-*
  $ sudo apt autoremove
  ```
  * make sure no folders are left behind: `$ ls /usr/local/cuda-X.Y`
* Follow the instructions [above](https://github.com/jeongyoonlee/dotfiles/blob/master/ubuntu/dl.md) to re-install drivers. 

## Install OpenCV2
From http://leoybkim.com/wiki/installing-opencv-2.4.13-on-ubunto-16.04/
```
$ sudo apt update
$ sudo apt install -y checkinstall libopencv-dev libgtk2.0-dev pkg-config libavcodec-dev libpng12-dev libavformat-dev libswscale-dev yasm libxine2 libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libqt4-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils
$ sudo apt install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libjasper-dev libdc1394-22-dev

$ wget https://github.com/opencv/opencv/archive/2.4.13.2.tar.gz
$ tar xzvf 2.4.13.2.tar.gz && cd opencv-2.4.13.2
$ mkdir release && cd release
$ cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DBUILD_FAT_JAVA_LIB=ON -DINSTALL_TO_MANGLED_PATHS=ON -DINSTALL_CREATE_DISTRIB=ON -DINSTALL_TESTS=ON -DENABLE_FAST_MATH=ON -DWITH_IMAGEIO=ON -DBUILD_SHARED_LIBS=OFF -DWITH_GSTREAMER=ON ..
$ make all -j
$ sudo make install && sudo checkinstall
```
Note that it puts `cv2.so` in `/usr/local/python/2.7/` instead of `/usr/local/lib/python2.7/site-packages`. I moved `cv2.so` to `/usr/local/lib/python2.7/site-packages` and add the directory to `PYTHONPATH` in `.bashrc` as follows:
```
export PYTHONPATH=$PYTHONPATH:.:/usr/local/lib/python2.7/site-packages
```
## Install TensorFlow with GPU
```
$ sudo pip install -U tensorflow-gpu
```

## Install Keras
For Python:
```
$ git clone https://github.com/fchollet/keras.git
$ cd keras
$ sudo python setup.py install
```

For R:
```
# From the R console:
> devtools::install_github("rstudio/keras")
> library(keras)
> install_tensorflow(gpu=TRUE)
```

## Install CNTK
```
$ sudo apt -y install openmpi-bin
$ sudo pip install https://cntk.ai/PythonWheel/GPU-1bit-SGD/cntk-2.0-cp27-cp27mu-linux_x86_64.whl
$ python -c "import cntk; print(cntk.__version__)"
$ sudo python -m cntk.sample_installer
```

## Install MXNet
For Python:
```
$ sudo pip install mxnet-cu80
$ sudo apt -y install graphviz
$ sudo pip install graphviz
```

For R:
```
# From the command line:
$ sudo apt -y install libcurl4-openssl-dev libssl-dev

# From the R console:
> install.packages('devtools', repo='https://cran.rstudio.com')
> install.packages('DiagrammeR')
> install.packages('visNetwork')
> install.packages('data.table')
> install.packages('jsonlite')
> install.packages('stringr')

# From the command line:
$ git clone --recursive https://github.com/dmlc/mxnet
$ cd mxnet
$ make -j $(nproc) USE_OPENCV=1 USE_BLAS=openblas USE_CUDA=1 USE_CUDA_PATH=/usr/local/cuda USE_CUDNN=1
$ sudo make rpkg
$ sudo R CMD INSTALL mxnet_current_r.tar.gz
```

## Install PyTorch
```
$ sudo pip install http://download.pytorch.org/whl/cu80/torch-0.1.12.post2-cp27-none-linux_x86_64.whl 
$ sudo pip install torchvision
```

## Install GpuStat
```
$ sudo pip install gpustat
```
